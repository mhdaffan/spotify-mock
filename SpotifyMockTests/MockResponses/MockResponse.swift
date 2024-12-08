//
//  MockResponse.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import Foundation
@testable import SpotifyMock

struct MockResponse: Decodable, Equatable {
  let id: Int
  let title: String
}

extension MockResponse {
  static func mockFail() -> Data {
    return """
    {
      "id": 1
    }
  """.toJsonData()
  }
  
  static func mock200() -> Data {
    return jsonString.toJsonData()
  }
  
  static let jsonString: String =
  """
    {
      "id": 1,
      "title": "test"
    }
  """
}
