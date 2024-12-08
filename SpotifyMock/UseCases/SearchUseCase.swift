//
//  SearchUseCase.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Combine

protocol SearchUseCase {
  func getTracks(for artist: String) -> AnyPublisher<[TrackModel], Error>
}

struct SearchUseCaseImpl: SearchUseCase {
  
  @Injected(\.searchRepository) var searchRepository: SearchRepository
  
  func getTracks(for artist: String) -> AnyPublisher<[TrackModel], Error> {
    searchRepository.getTracks(for: artist)
      .map { $0.toDomain() }
      .eraseToAnyPublisher()
  }
}
