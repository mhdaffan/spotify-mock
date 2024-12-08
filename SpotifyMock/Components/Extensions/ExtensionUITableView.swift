//
//  ExtensionUITableView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit

extension UITableViewCell {
  static var cellIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewHeaderFooterView {
  static var cellIdentifier: String {
    return String(describing: self)
  }
}

extension UITableView {
  final func register<T: UITableViewCell>(cell: T.Type) {
    self.register(T.self, forCellReuseIdentifier: cell.cellIdentifier)
  }
  
  final func register<T: UITableViewHeaderFooterView>(headerFooter: T.Type) {
    self.register(T.self, forHeaderFooterViewReuseIdentifier: headerFooter.cellIdentifier)
  }
  
  final func dequeueReusableCell<T: UITableViewCell>(
    for indexPath: IndexPath,
    cell: T.Type = T.self
  ) -> T {
    guard let reusableCell = self.dequeueReusableCell(withIdentifier: cell.cellIdentifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue cell with identifier \(cell.cellIdentifier) matching type \(cell.self)")
    }
    
    return reusableCell
  }
}
