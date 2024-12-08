//
//  TrackDataSource.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

struct TrackDataSource: Hashable {
  let trackId: Int
  let artistId: Int
  let artistName: String
  let trackName: String
  let artworkUrl100: String
  var isFavorited: Bool
}

extension TrackDataSource {
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
