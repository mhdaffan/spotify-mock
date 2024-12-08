//
//  NetworkService.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Foundation
import Combine

protocol NetworkService {
  func request<T: Decodable>(with endpoint: Endpoint<T>) -> AnyPublisher<T, Error>
}

class NetworkServiceImpl: NetworkService {
  
  @Injected(\.sessionService) var sessionService: SessionService
  
  func request<T: Decodable>(with endpoint: Endpoint<T>) -> AnyPublisher<T, Error> {
    sessionService.request(with: endpoint)
      .tryMap({ response in
        if let response = response.0.toObject(T.self) {
          return response
        }
        
        throw NetworkError.parseError
      })
      .mapError { error in
        return error
      }
      .eraseToAnyPublisher()
  }
}
