//
//  MainTabBarController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
  
  // MARK: - UI Properties
  
  private let homeVC = ScreenName.home.build().then {
    $0.title = Localized.commonHome
    $0.tabBarItem.image = .icHome
  }
  private let searchVC = ScreenName.search.build().then {
    $0.title = Localized.commonSearch
    $0.tabBarItem.image = .icSearch
  }
  private let libraryVC = ScreenName.yourLibrary.build().then {
    $0.title = Localized.commonYourLibrary
    $0.tabBarItem.image = .icLibrary
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabbar()
    configureViewControllers()
  }
}

// MARK: - Private Methods

private extension MainTabBarController {
  func configureViewControllers() {
    viewControllers = [
      UINavigationController(rootViewController: homeVC),
      UINavigationController(rootViewController: searchVC),
      UINavigationController(rootViewController: libraryVC)
    ]
  }
  
  func configureTabbar() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .black
    tabBar.standardAppearance = appearance
    tabBar.scrollEdgeAppearance = appearance
    
    let fontAttribute = [NSAttributedString.Key.font: UIFont.avenirRegular(11)]
    UITabBarItem.appearance().setTitleTextAttributes(fontAttribute, for: .normal)
    
    tabBar.tintColor = .white
    tabBar.unselectedItemTintColor = .quickSilver
  }
}
