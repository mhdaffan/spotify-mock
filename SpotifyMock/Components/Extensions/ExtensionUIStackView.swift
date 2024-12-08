//
//  ExtensionUIStackView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: UIView...) {
    for view in views {
      addArrangedSubview(view)
    }
  }
}
