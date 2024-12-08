//
//  PlaylistHeaderView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit
import SnapKit

final class PlaylistHeaderView: UIView {
  let titleLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .avenirMedium(20)
  }
  let descriptionLabel = UILabel().then {
    $0.textColor = .silver
    $0.font = .avenirMedium(14)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateUI(with model: PlaylistHeaderModel) {
    titleLabel.text = model.name
    descriptionLabel.text = "\(model.totalSongs) \(Localized.commonSongs)"
  }
}

// MARK: - Private Methods

private extension PlaylistHeaderView {
  func configureUI() {
    addSubviews(
      titleLabel,
      descriptionLabel
    )
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(8)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(titleLabel)
      $0.bottom.equalToSuperview().inset(8)
    }
  }
}
