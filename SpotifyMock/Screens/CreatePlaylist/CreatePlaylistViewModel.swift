//
//  CreatePlaylistViewModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Combine

final class CreatePlaylistViewModel: ViewModel {
  
  // MARK: - Injected
  
  @Injected(\.databaseUseCase) var databaseUseCase: DatabaseUseCase
  
  // MARK: - Observables
  
  @Published var playlist: PlaylistModel? = nil
  
  func createPlaylist(with playlistName: String) {
    let id = (databaseUseCase.getPlaylists().last?.id ?? 0) + 1
    let playlist = PlaylistModel(id: id, name: playlistName, tracks: [])
    databaseUseCase.savePlaylist(playlist)
    self.playlist = playlist
  }
}
