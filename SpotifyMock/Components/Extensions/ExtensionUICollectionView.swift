//
//  ExtensionUICollectionView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit

extension UICollectionViewCell {
  static var cellIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionReusableView {
  static var reusableViewIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionView {
  
  final func register<T: UICollectionViewCell>(cell: T.Type) {
    self.register(T.self, forCellWithReuseIdentifier: cell.cellIdentifier)
  }
  
  final func register<T: UICollectionReusableView>(
    supplementaryView: T.Type,
    ofKind kind: String
  ) {
    self.register(
      T.self,
      forSupplementaryViewOfKind: kind,
      withReuseIdentifier: supplementaryView.reusableViewIdentifier
    )
  }
  
  final func dequeueReusableCell<T: UICollectionViewCell>(
    for indexPath: IndexPath,
    cell: T.Type = T.self
  ) -> T {
    guard let cell = self.dequeueReusableCell(withReuseIdentifier: cell.cellIdentifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue cell with identifier \(cell.cellIdentifier) matching type \(cell.self)")
    }
    return cell
  }
  
  final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
    ofKind kind: String,
    for indexPath: IndexPath,
    view: T.Type = T.self
  ) -> T {
    guard let supplementaryView = self.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: view.reusableViewIdentifier,
      for: indexPath
    ) as? T else {
      fatalError("Failed to dequeue supplementary view with identifier \(view.reusableViewIdentifier) matching type \(view.self)")
    }
    return supplementaryView
  }
}
