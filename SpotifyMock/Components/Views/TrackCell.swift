//
//  TrackCell.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit
import SnapKit

class TrackCell: TableViewCell {
  
  // MARK: - UI Properties
  
  let hStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 16
    $0.alignment = .center
  }
  let thumbnailImageView = UIImageView(image: .icPersonFill).then {
    $0.contentMode = .scaleAspectFill
    $0.cornerRadius = 8
    $0.clipsToBounds = true
  }
  let vStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 2
  }
  let artistName = UILabel().then {
    $0.textColor = .white
    $0.font = .avenirMedium(15)
  }
  let trackName = UILabel().then {
    $0.textColor = .silver
    $0.font = .avenirMedium(15)
  }
  
  override func configureUI() {
    super.configureUI()
    contentView.addSubview(hStackView)
    backgroundColor = .black
    hStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(8)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
    hStackView.addArrangedSubviews(
      thumbnailImageView,
      vStackView
    )
    thumbnailImageView.snp.makeConstraints {
      $0.width.height.equalTo(50)
    }
    vStackView.addArrangedSubviews(
      artistName,
      trackName
    )
  }
  
  func updateUI(with track: TrackDataSource) {
    thumbnailImageView.setImage(from: track.artworkUrl100)
    artistName.text = track.artistName
    trackName.text = track.trackName
  }
}
