//
//  SearchUseCaseTests.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import XCTest
import Combine
@testable import SpotifyMock

final class SearchUseCaseTests: TestCase {
  var sut: SearchUseCaseImpl!
  var mockSearchRepository = MockSearchRepository()
  
  override func setUp() {
    super.setUp()
    sut = SearchUseCaseImpl()
    InjectedValue[\.searchRepository] = mockSearchRepository
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testGetTracksSuccess() {
    let successResponse = TrackListResponse.stub200()
    mockSearchRepository.getTracksResult = .success(successResponse)
    
    sut.getTracks(for: "Eminem")
      .sinkToResult(
        onReceiveValue: { response in
          XCTAssertEqual(response, successResponse.toDomain())
        },
        storeIn: &cancellables
      )
  }
  
  func testGetTracksFailure() {
    let parseError = NetworkError.parseError
    mockSearchRepository.getTracksResult = .failure(parseError)
    
    sut.getTracks(for: "Eminem")
      .sinkToResult(
        onFailure: { error in
          XCTAssertEqual(error.localizedDescription, parseError.localizedDescription)
        },
        storeIn: &cancellables
      )
  }
}
