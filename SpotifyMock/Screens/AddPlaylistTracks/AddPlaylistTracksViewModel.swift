//
//  AddPlaylistTracksViewModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Foundation
import Combine

final class AddPlaylistTracksViewModel: ViewModel {
  
  var playlist: PlaylistModel
  
  init(playlist: PlaylistModel) {
    self.playlist = playlist
  }
  
  // MARK: Injected
  
  @Injected(\.searchUseCase) var searchUseCase: SearchUseCase
  @Injected(\.databaseUseCase) var databaseUseCase: DatabaseUseCase
  
  // MARK: - Observables
  
  @Published var tracksDataSource: [TrackDataSource] = []
  @Published var searchKeyword: String = ""
  
  func getTracks(for artist: String) {
    guard !artist.isEmpty else {
      tracksDataSource = []
      return
    }
    isLoading = true
    searchUseCase.getTracks(for: artist)
      .sinkOnMainThread(
        onReceiveValue: { [weak self] response in
          self?.isLoading = false
          self?.tracksDataSource = response.toDataSource()
          self?.updateDataSource()
        },
        onFailed: { [weak self] error in
          self?.isLoading = false
        },
        storeIn: &cancellables
      )
  }
  
  func updateDataSource() {
    let tracks = getPlaylist()?.tracks ?? []
    tracksDataSource = tracksDataSource.map { item -> TrackDataSource in
      var _item = item
      _item.isFavorited = tracks.contains(where: { $0.trackId == item.trackId })
      return _item
    }
  }
  
  func saveTrack(with track: TrackDataSource) {
    guard !isTrackExist(trackId: track.trackId) else { return }
    playlist.tracks.append(track.toDomain())
    databaseUseCase.savePlaylist(playlist)
    updateDataSource()
  }
  
  func isTrackExist(trackId: Int) -> Bool {
    playlist.tracks.contains(where: { $0.trackId == trackId })
  }
  
  func getPlaylist() -> PlaylistModel? {
    return databaseUseCase.getPlaylist(by: playlist.id)
  }
}
