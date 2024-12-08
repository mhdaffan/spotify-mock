//
//  PlaylistTrackCell.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit
import SnapKit

final class PlaylistTrackCell: TrackCell {
  
  // MARK: - UI Properties
  
  let moreButton = UIButton().then {
    $0.setImage(.icMore.withColor(.silver), for: .normal)
  }
  
  // MARK: - Closures
  
  var onTapMore: (() -> Void)?
  
  override func configureUI() {
    super.configureUI()
    hStackView.addArrangedSubview(moreButton)
    moreButton.snp.makeConstraints {
      $0.width.height.equalTo(24)
    }
    moreButton.addPrimaryAction { [weak self] in
      self?.onTapMore?()
    }
  }
  
  override func updateUI(with track: TrackDataSource) {
    super.updateUI(with: track)
  }
}
