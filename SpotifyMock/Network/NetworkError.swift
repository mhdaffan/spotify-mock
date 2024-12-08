//
//  NetworkError.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Foundation

struct NetworkError {
  static var noData = createError(code: NSURLErrorResourceUnavailable, description: "Data not found")
  static var parseError = createError(code: NSURLErrorCannotParseResponse, description: "Unable to parse data")
  static var badURL = createError(code: NSURLErrorBadURL, description: "Bad URL")
  
  static func createError(code: Int, description: String) -> Error {
    return NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: description])
  }
}
