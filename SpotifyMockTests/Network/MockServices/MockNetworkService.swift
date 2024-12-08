//
//  MockNetworkService.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import Foundation
import Combine
@testable import SpotifyMock

class MockNetworkService: NetworkService {
  var result: Result<Decodable, Error>?
  
  func request<T>(with endpoint: Endpoint<T>) -> AnyPublisher<T, Error> where T: Decodable {
    guard let result = result else {
      return .mockFailure(NetworkError.parseError)
    }
    
    switch result {
    case .success(let value):
      if let response = value as? T {
        return .mockSuccess(value: response)
      } else {
        return .mockFailure(NetworkError.parseError)
      }
    case .failure(let error):
        return .mockFailure(error)
    }
  }
}
