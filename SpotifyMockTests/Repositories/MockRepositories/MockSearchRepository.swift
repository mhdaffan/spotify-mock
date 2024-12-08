//
//  MockSearchRepository.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import Combine
@testable import SpotifyMock

class MockSearchRepository: SearchRepository {
  var getTracksResult: Result<TrackListResponse, Error> = .failure(NetworkError.parseError)
  
  func getTracks(for artist: String) -> AnyPublisher<TrackListResponse, Error> {
    return getTracksResult.publisher.eraseToAnyPublisher()
  }
}
