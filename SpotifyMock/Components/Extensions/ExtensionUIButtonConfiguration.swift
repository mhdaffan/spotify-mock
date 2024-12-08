//
//  ExtensionUIButtonConfiguration.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

extension UIButton.Configuration {
  static func text(alignment: UIButton.Configuration.TitleAlignment = .center, padding: CGFloat) -> UIButton.Configuration {
    var configuration = UIButton.Configuration.plain()
    configuration.titlePadding = padding
    configuration.titleAlignment = alignment
    return configuration
  }
}
