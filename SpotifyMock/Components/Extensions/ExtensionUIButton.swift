//
//  ExtensionUIButton.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

extension UIButton {
  func addPrimaryAction(action: @escaping () -> Void) {
    self.addAction(
      UIAction { _ in action() },
      for: .primaryActionTriggered
    )
  }
}
