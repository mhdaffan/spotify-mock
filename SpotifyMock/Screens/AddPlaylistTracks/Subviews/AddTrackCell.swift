//
//  AddTrackCell.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit
import SnapKit

final class AddTrackCell: TrackCell {
  
  // MARK: - UI Properties
  
  let addButton = UIButton().then {
    $0.setImage(.icAddCircleFill?.withColor(.primaryGreen), for: .normal)
  }
  
  // MARK: - Closures
  
  var onTapAdd: (() -> Void)?
  
  override func configureUI() {
    super.configureUI()
    hStackView.addArrangedSubview(addButton)
    addButton.snp.makeConstraints {
      $0.width.height.equalTo(24)
    }
    addButton.addPrimaryAction { [weak self] in
      self?.onTapAdd?()
    }
  }
  
  override func updateUI(with track: TrackDataSource) {
    super.updateUI(with: track)
    addButton.isHidden = track.isFavorited
  }
}
