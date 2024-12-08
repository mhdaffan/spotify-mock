//
//  YourLibraryHeaderView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit
import SnapKit

protocol YourLibraryHeaderViewDelegate: AnyObject {
  func onTapSwitchButton()
}

final class YourLibraryHeaderView: UIView {
  
  // MARK: - UI Properties
  
  let switchButton = UIButton()
  
  // MARK: - Delegates
  
  weak var delegate: YourLibraryHeaderViewDelegate?
  
  // MARK: - Initialized
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setupAction()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateUI(for section: CollectionSectionDataSrouce) {
    switch section {
    case .grid:
      switchButton.setImage(.icGrid?.withColor(.white), for: .normal)
    case .list:
      switchButton.setImage(.icList?.withColor(.white), for: .normal)
    }
  }
}

// MARK: - Private Methods

private extension YourLibraryHeaderView {
  func configureUI() {
    addSubview(switchButton)
    switchButton.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(4)
      $0.trailing.equalToSuperview()
      $0.width.height.equalTo(50)
    }
  }
  
  func setupAction() {
    switchButton.addPrimaryAction { [weak self] in
      self?.delegate?.onTapSwitchButton()
    }
  }
}
