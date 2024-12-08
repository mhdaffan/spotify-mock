//
//  AddLibraryViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit
import SnapKit

protocol AddLibraryViewDelegate: AnyObject {
  func onCreateNewPlaylist()
}

final class AddLibraryViewController: ViewController {
  
  // MARK: - UI Properties
  
  private let containerView = UIView().then {
    $0.backgroundColor = .darkCharcoal
  }
  private let createPlaylistView = AddLibraryCreatePlaylistView()
  
  // MARK: - Delegates
  
  weak var delegate: AddLibraryViewDelegate?
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupActions()
  }
  
  @objc private func onTapCreatePlaylist() {
    dismiss(animated: true) { [weak self] in
      self?.delegate?.onCreateNewPlaylist()
    }
  }
  
  @objc private func onTapBackground() {
    dismiss(animated: true)
  }
}

// MARK: - Private Methods

private extension AddLibraryViewController {
  func configureUI() {
    view.backgroundColor = .black.withAlphaComponent(0.5)
    view.addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
    }
    containerView.addSubview(createPlaylistView)
    createPlaylistView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(24)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    containerView.roundCorners(for: [.layerMinXMinYCorner, .layerMaxXMinYCorner], with: 8)
  }
  
  func setupActions() {
    view.addTapGesture(
      for: self,
      action: #selector(onTapBackground)
    )
    createPlaylistView.addTapGesture(
      for: self,
      action: #selector(onTapCreatePlaylist)
    )
  }
}
