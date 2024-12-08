//
//  ExtensionUITextField.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

extension UITextField {
  func onEditingChanged(action: @escaping (String) -> Void) {
    let action = UIAction { [weak self] _ in
      action((self?.text).orEmpty)
    }
    self.addAction(action, for: .editingChanged)
  }
}
