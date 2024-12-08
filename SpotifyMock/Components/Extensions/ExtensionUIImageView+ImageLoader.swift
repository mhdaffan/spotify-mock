//
//  ExtensionUIImageView+ImageLoader.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit
import SDWebImage

extension UIImageView {
  func setImage(from urlString: String?, with placeholder: UIImage? = nil) {
    guard let urlString = urlString, let url = URL(string: urlString) else {
      self.image = placeholder
      return
    }
    self.sd_setImage(with: url, placeholderImage: placeholder, options: .continueInBackground)
  }
}
