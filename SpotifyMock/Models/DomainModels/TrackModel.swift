//
//  TrackModel.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

struct TrackModel: Equatable {
  let artistId: Int
  let trackId: Int
  let artistName: String
  let trackName: String
  let artworkUrl100: String
}

extension TrackModel {
  func toDataSource() -> TrackDataSource {
    return TrackDataSource(
      trackId: trackId,
      artistId: artistId,
      artistName: artistName,
      trackName: trackName,
      artworkUrl100: artworkUrl100,
      isFavorited: false
    )
  }
  
  func toDatabaseModel() -> TrackDatabaseModel {
    let databaseModel = TrackDatabaseModel()
    databaseModel.trackId = trackId
    databaseModel.artistId = artistId
    databaseModel.artistName = artistName
    databaseModel.trackName = trackName
    databaseModel.artworkUrl100 = artworkUrl100
    return databaseModel
  }
}

extension Array where Element == TrackModel {
  func toDataSource() -> [TrackDataSource] {
    return self.map { $0.toDataSource() }
  }
}
