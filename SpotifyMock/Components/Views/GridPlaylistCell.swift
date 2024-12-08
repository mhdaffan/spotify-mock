//
//  GridPlaylistCell.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit
import SnapKit

final class GridPlaylistCell: CollectionViewCell {
  
  // MARK: - UI Properties
  
  let vStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 4
  }
  let thumbnailView = ThumbnailView().then {
    $0.cornerRadius = 8
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
    contentView.addSubview(vStackView)
    backgroundColor = .black
    vStackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    thumbnailView.snp.makeConstraints {
      $0.width.height.equalTo(184)
    }
    vStackView.addArrangedSubviews(
      thumbnailView,
      playlistNameLabel,
      playlistDetailLabel
    )
    vStackView.setCustomSpacing(2, after: playlistNameLabel)
  }
  
  func updateUI(with playlist: PlaylistDataSource) {
    thumbnailView.update(with: playlist.thumbnail())
    playlistNameLabel.text = playlist.name
    playlistDetailLabel.text = "\(Localized.commonPlaylist) • \(playlist.tracks.count) \(Localized.commonSearch)"
  }
}
