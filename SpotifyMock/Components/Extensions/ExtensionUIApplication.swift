//
//  ExtensionUIApplication.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit

extension UIApplication {
  var keyWindow: UIWindow? {
    connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .first?
      .windows
      .first(where: { $0.isKeyWindow })
  }
}
