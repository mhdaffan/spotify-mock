//
//  DatabaseUseCase.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

protocol DatabaseUseCase {
  func savePlaylist(_ playlist: PlaylistModel)
  func getPlaylists() -> [PlaylistModel]
  func getPlaylist(by id: Int) -> PlaylistModel?
}

struct DatabaseUseCaseImpl: DatabaseUseCase {
  
  @Injected(\.databaseRepository) var databaseRepository: DatabaseRepository
  
  func savePlaylist(_ playlist: PlaylistModel) {
    databaseRepository.add(playlist.toDatabaseModel())
  }
  
  func getPlaylists() -> [PlaylistModel] {
    let playlists = databaseRepository.get(PlaylistDatabaseModel.self)
    return playlists.map { $0.toDomain() }
  }
  
  func getPlaylist(by id: Int) -> PlaylistModel? {
    guard let playlist = databaseRepository.getObject(PlaylistDatabaseModel.self, primaryKey: id) else {
      return nil
    }
    return playlist.toDomain()
  }
}
