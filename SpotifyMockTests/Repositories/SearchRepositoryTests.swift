//
//  SearchRepositoryTests.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import XCTest
import Combine
@testable import SpotifyMock

final class SearchRepositoryTests: TestCase {
  var sut: SearchRepositoryImpl!
  var mockNetworkService = MockNetworkService()
  
  override func setUp() {
    super.setUp()
    sut = SearchRepositoryImpl()
    InjectedValue[\.networkService] = mockNetworkService
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testGetTracksSuccess() {
    let successResponse = TrackListResponse.stub200()
    mockNetworkService.result = .success(successResponse)
    
    sut.getTracks(for: "Eminem")
      .sinkToResult(
        onReceiveValue: { response in
          XCTAssertEqual(response, successResponse)
        },
        storeIn: &cancellables
      )
  }
  
  func testGetTracksFailure() {
    let parseError = NetworkError.parseError
    mockNetworkService.result = .failure(parseError)
    
    sut.getTracks(for: "Eminem")
      .sinkToResult(
        onFailure: { error in
          XCTAssertEqual(error.localizedDescription, parseError.localizedDescription)
        },
        storeIn: &cancellables
      )
  }
}
