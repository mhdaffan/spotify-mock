//
//  TrackDatabaseModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import RealmSwift

class TrackDatabaseModel: Object {
  @Persisted var trackId: Int
  @Persisted var artistId: Int
  @Persisted var artistName: String
  @Persisted var trackName: String
  @Persisted var artworkUrl100: String
}

extension TrackDatabaseModel {
  func toDomain() -> TrackModel {
    return TrackModel(
      artistId: artistId,
      trackId: trackId,
      artistName: artistName,
      trackName: trackName,
      artworkUrl100: artworkUrl100
    )
  }
}
