//
//  TestCase.swift
//  SpotifyMockTests
//
//  Created by Muhammad Affan on 09/12/24.
//

import XCTest
import Combine

class TestCase: XCTestCase {
  var cancellables: Set<AnyCancellable> = []
  
  override func tearDown() {
    cancellables = []
    super.tearDown()
  }
}
