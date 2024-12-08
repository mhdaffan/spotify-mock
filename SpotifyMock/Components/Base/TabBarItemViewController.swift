//
//  TabBarItemViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import Foundation

class TabBarItemViewController: ViewController {
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = false
  }
  
}
