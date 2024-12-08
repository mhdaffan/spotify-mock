//
//  SearchEndpoint.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

struct SearchEndpoint {
  static func searchTracks(for artist: String) -> Endpoint<TrackListResponse> {
    return Endpoint(
      path: "/search",
      method: .get,
      queryParameters: [
        "term": artist,
        "entity": "musicVideo"
      ]
    )
  }
}
