//
//  PlaylistCell.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit
import SnapKit

final class PlaylistCell: CollectionViewCell {
  
  // MARK: - UI Properties
  
  let hStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 16
    $0.alignment = .center
  }
  let thumbnailView = ThumbnailView().then {
    $0.cornerRadius = 8
  }
  let vStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 8
  }
  let playlistNameLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .avenirMedium(15)
  }
  let playlistDetailLabel = UILabel().then {
    $0.textColor = .silver
    $0.font = .avenirMedium(15)
  }
  
  override func configureUI() {
    super.configureUI()
    contentView.addSubview(hStackView)
    backgroundColor = .black
    hStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(8)
      $0.leading.trailing.equalToSuperview()
    }
    hStackView.addArrangedSubviews(
      thumbnailView,
      vStackView
    )
    thumbnailView.snp.makeConstraints {
      $0.width.height.equalTo(60)
    }
    vStackView.addArrangedSubviews(
      playlistNameLabel,
      playlistDetailLabel
    )
  }
  
  func updateUI(with playlist: PlaylistDataSource) {
    thumbnailView.update(with: playlist.thumbnail())
    playlistNameLabel.text = playlist.name
    playlistDetailLabel.text = "\(Localized.commonPlaylist) • \(playlist.tracks.count) \(Localized.commonSearch)"
  }
}
