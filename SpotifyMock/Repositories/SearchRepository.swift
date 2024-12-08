//
//  SearchRepository.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Combine

protocol SearchRepository {
  func getTracks(for artist: String) -> AnyPublisher<TrackListResponse, Error>
}

class SearchRepositoryImpl: SearchRepository {
  
  @Injected(\.networkService) var network: NetworkService
  
  func getTracks(for artist: String) -> AnyPublisher<TrackListResponse, Error> {
    network.request(with: SearchEndpoint.searchTracks(for: artist))
  }
}
