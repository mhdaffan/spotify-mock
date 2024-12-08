//
//  TrackResponse.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

struct TrackResponse: Decodable, Equatable {
  let artistId: Int?
  let trackId: Int
  let artistName: String?
  let trackName: String?
  let artworkUrl100: String?
}

extension TrackResponse {
  func toDomain() -> TrackModel {
    return TrackModel(
      artistId: artistId ?? 0,
      trackId: trackId,
      artistName: artistName.orEmpty,
      trackName: trackName.orEmpty,
      artworkUrl100: artworkUrl100.orEmpty
    )
  }
}
