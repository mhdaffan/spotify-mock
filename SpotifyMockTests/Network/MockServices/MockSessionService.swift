//
//  MockSessionService.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import Foundation
import Combine
@testable import SpotifyMock

class MockSessionService: SessionService {
  var mockData: Data = MockResponse.mock200()
  
  func request(with endpoint: Requestable) -> AnyPublisher<(Data, URLResponse), URLError> {
    let mockResponse = HTTPURLResponse(
      url: URL(string: "https://example.com")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )!
    
    return Just((mockData, mockResponse))
      .setFailureType(to: URLError.self)
      .eraseToAnyPublisher()
  }
}
