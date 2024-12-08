//
//  PlaylistViewModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Combine

final class PlaylistViewModel: ViewModel {
  var playlist: PlaylistModel
  
  init(playlist: PlaylistModel) {
    self.playlist = playlist
    tracksDataSource = playlist.tracks.toDataSource()
    playlistHeaderModel = PlaylistHeaderModel(
      name: playlist.name,
      totalSongs: playlist.tracks.count
    )
  }
  
  // MARK: Injected
  
  @Injected(\.databaseUseCase) var databaseUseCase: DatabaseUseCase
  
  // MARK: - Observables
  
  @Published var tracksDataSource: [TrackDataSource] = []
  @Published var playlistHeaderModel: PlaylistHeaderModel
  
  func getTracks() {
    guard let playlist = databaseUseCase.getPlaylist(by: playlist.id) else {
      return
    }
    self.playlist = playlist
    tracksDataSource = playlist.tracks.toDataSource()
    playlistHeaderModel = PlaylistHeaderModel(
      name: playlist.name,
      totalSongs: playlist.tracks.count
    )
  }
  
  func removeTrack(track: TrackDataSource) {
    guard let index = playlist.tracks.firstIndex(where: { $0.trackId == track.trackId }) else { return }
    playlist.tracks.remove(at: index)
    databaseUseCase.savePlaylist(playlist)
    getTracks()
  }
}
