//
//  TrackListResponse.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

struct TrackListResponse: Decodable, Equatable {
  let resultCount: Int?
  let results: [TrackResponse]?
}

extension TrackListResponse {
  func toDomain() -> [TrackModel] {
    return results?.map { $0.toDomain() } ?? []
  }
}
