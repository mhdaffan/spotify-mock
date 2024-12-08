//
//  ExtensionUIImage.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit

extension UIImage {
  func withColor(_ color: UIColor) -> UIImage {
    self.withTintColor(color, renderingMode: .alwaysOriginal)
  }
}
