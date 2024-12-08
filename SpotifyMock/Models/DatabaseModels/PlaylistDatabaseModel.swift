//
//  PlaylistDatabaseModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import RealmSwift

class PlaylistDatabaseModel: Object {
  @Persisted(primaryKey: true) var id: Int
  @Persisted var name: String
  @Persisted var tracks: List<TrackDatabaseModel>
}

extension PlaylistDatabaseModel {
  func toDomain() -> PlaylistModel {
    let tracks: [TrackModel] = tracks.map { $0.toDomain() }
    return PlaylistModel(
      id: id,
      name: name,
      tracks: tracks
    )
  }
}
