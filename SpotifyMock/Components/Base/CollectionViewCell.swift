//
//  CollectionViewCell.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {}
}
