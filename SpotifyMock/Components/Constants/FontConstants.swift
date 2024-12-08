//
//  FontConstants.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit

extension UIFont {
  enum FontName: String {
    case avenirDemiBold = "Avenir Next Demi Bold"
    case avenirMedium = "Avenir Next Medium"
    case avenirRegular = "Avenir Next Regular"
  }
  
  private static func getFont(name: FontName, size: CGFloat) -> UIFont {
    if let font = UIFont(name: name.rawValue, size: size) {
      return font
    }
    
    return UIFont(name: name.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
  }
  
  static func avenirDemiBold(_ size: CGFloat) -> UIFont {
    getFont(name: .avenirDemiBold, size: size)
  }
  
  static func avenirMedium(_ size: CGFloat) -> UIFont {
    getFont(name: .avenirMedium, size: size)
  }
  
  static func avenirRegular(_ size: CGFloat) -> UIFont {
    getFont(name: .avenirRegular, size: size)
  }
}
