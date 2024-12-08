//
//  ExtensionUIColor.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit

extension UIColor {
  convenience init(hex: String, alpha: CGFloat = 1.0) {
    var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexString = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString
    let scanner = Scanner(string: hexString as String)
    
    var color: UInt64 = 0
    scanner.scanHexInt64(&color)
    
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    
    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
