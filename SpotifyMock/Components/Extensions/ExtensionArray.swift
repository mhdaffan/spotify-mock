//
//  ExtensionArray.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
