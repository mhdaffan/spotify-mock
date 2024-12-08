//
//  Navigation.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

enum ScreenName {
  case home
  case search
  case yourLibrary
  case createPlaylist(delegate: CreatePlaylistViewDegate?)
  case playlist(playlist: PlaylistModel)
  case addPlaylistTracks(playlist: PlaylistModel)
  case addLibrary(delegate: AddLibraryViewDelegate)
}

extension ScreenName {
  func build() -> ViewController {
    switch self {
    case .home:
      return HomeViewController()
    case .search:
      let viewModel = SearchTabViewModel()
      return SearchTabViewController(viewModel: viewModel)
    case .yourLibrary:
      let viewModel = YourLibraryViewModel()
      return YourLibraryViewController(viewModel: viewModel)
    case .createPlaylist(let delegate):
      let viewModel = CreatePlaylistViewModel()
      let viewController = CreatePlaylistViewController(viewModel: viewModel)
      viewController.delegate = delegate
      return viewController
    case .playlist(let playlist):
      let viewModel = PlaylistViewModel(playlist: playlist)
      return PlaylistViewController(viewModel: viewModel)
    case .addPlaylistTracks(let playlist):
      let viewModel = AddPlaylistTracksViewModel(playlist: playlist)
      return AddPlaylistTracksViewController(viewModel: viewModel)
    case .addLibrary(let delegate):
      let viewController = AddLibraryViewController()
      viewController.delegate = delegate
      viewController.modalPresentationStyle = .overFullScreen
      return viewController
    }
  }
}

extension ViewController {
  
  func push(to screen: ScreenName, animated: Bool = true) {
    navigationController?.pushViewController(screen.build(), animated: animated)
  }
  
  func pop(animated: Bool = true) {
    navigationController?.popViewController(animated: true)
  }
  
  func pop(to screen: ScreenName, animated: Bool = true) {
    if let viewController = navigationController?.viewControllers.first(where: { type(of: $0) == type(of: screen.build()) }) {
      navigationController?.popToViewController(viewController, animated: true)
    } else {
      navigationController?.popViewController(animated: true)
    }
  }
  
  func present(_ screen: ScreenName, animated: Bool = true, completion: (() -> Void)? = nil) {
    present(screen.build(), animated: animated, completion: completion)
  }
  
  func showAlert(
    title: String? = nil,
    message: String? = nil,
    actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)],
    preferredStyle: UIAlertController.Style = .alert
  ) {
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: preferredStyle
    )
    
    actions.forEach { alertController.addAction($0) }
    present(alertController, animated: true, completion: nil)
  }
}
