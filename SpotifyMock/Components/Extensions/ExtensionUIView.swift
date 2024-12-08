//
//  ExtensionUIView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

extension UIView {
  var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
  
  func addTapGesture(for target: Any, action: Selector) {
    let tapGesture = UITapGestureRecognizer.init(target: target, action: action)
    isUserInteractionEnabled = true
    addGestureRecognizer(tapGesture)
  }
  
  func roundCorners(for maskedCorners: CACornerMask, with radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = maskedCorners
    self.layer.masksToBounds = true
  }
}
