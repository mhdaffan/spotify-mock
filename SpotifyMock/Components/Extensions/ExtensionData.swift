//
//  ExtensionData.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 06/12/24.
//

import Foundation

extension Data {
  func toObject<T: Decodable>(_ object: T.Type) -> T? {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try? decoder.decode(object, from: self)
  }
}
