//
//  HomeViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import Foundation

final class HomeViewController: TabBarItemViewController {
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
}

// MARK: - Private Methods

private extension HomeViewController {
  func configureUI() {
    addLeftBarButtonItem(
      image: .icPersonFill?.withColor(.gray),
      size: CGSize(width: 34, height: 34)
    )
    addLeftBarTitle(title: Localized.commonHome)
    applyStandardAppearance()
  }
}
