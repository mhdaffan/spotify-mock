//
//  ExtensionString.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Foundation

extension String {
  func toJsonData() -> Data {
    return Data(self.utf8)
  }
}

extension Optional where Wrapped == String {
  var orEmpty: String {
    return self ?? ""
  }
}
