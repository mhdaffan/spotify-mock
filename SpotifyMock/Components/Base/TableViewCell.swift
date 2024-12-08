//
//  TableViewCell.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

class TableViewCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUI() {
    selectionStyle = .none
  }
}
