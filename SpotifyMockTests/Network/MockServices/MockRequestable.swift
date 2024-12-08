//
//  MockRequestable.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import Foundation
@testable import SpotifyMock

struct MockEndpoint {
  static func mockRequest() -> Endpoint<MockResponse> {
    return Endpoint(
      path: "/mock",
      method: .get
    )
  }
}
