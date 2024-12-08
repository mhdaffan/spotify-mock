//
//  NetworkServiceTests.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import XCTest
import Combine
@testable import SpotifyMock

class NetworkServiceTests: TestCase {
  var sut: NetworkServiceImpl!
  var mockSession = MockSessionService()
  
  override func setUp() {
    super.setUp()
    sut = NetworkServiceImpl()
    InjectedValue[\.sessionService] = mockSession
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testNetworkServiceSuccess() {
    mockSession.mockData = MockResponse.mock200()
    let endpoint = MockEndpoint.mockRequest()
    
    sut.request(with: endpoint)
      .sinkToResult(
        onReceiveValue: { response in
          XCTAssertEqual(response.id, 1)
          XCTAssertEqual(response.title, "test")
        },
        storeIn: &cancellables
      )
  }
  
  func testNetworkService_ParseError() {
    mockSession.mockData = MockResponse.mockFail()
    let endpoint = MockEndpoint.mockRequest()
    
    sut.request(with: endpoint)
      .sinkToResult(
        onFailure: { error in
          XCTAssertEqual(error.localizedDescription, NetworkError.parseError.localizedDescription)
        },
        storeIn: &cancellables
      )
  }
}
