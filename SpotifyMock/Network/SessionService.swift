//
//  SessionService.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Foundation
import Combine

protocol SessionService {
  func request(with endpoint: Requestable) -> AnyPublisher<(Data, URLResponse), URLError>
}

class SessionServiceImpl: NSObject, SessionService {
  
  @Injected(\.networkConfiguration) var networkConfig: NetworkConfiguration
  
  func request(with endpoint: Requestable) -> AnyPublisher<(Data, URLResponse), URLError> {
    do {
      let request = try endpoint.urlRequest(with: networkConfig)
      return URLSession.shared
        .dataTaskPublisher(for: request)
        .map(\.data, \.response)
        .eraseToAnyPublisher()
    } catch {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
  }
}
