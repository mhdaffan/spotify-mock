//
//  AddLibraryCreatePlaylistView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 09/12/24.
//

import UIKit
import SnapKit

final class AddLibraryCreatePlaylistView: UIView {
  
  // MARK: - UI Properties
  
  let stackView = UIStackView().then {
    $0.spacing = 16
    $0.axis = .horizontal
    $0.alignment = .leading
    $0.distribution = .fill
  }
  let playlistContainerView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 2
    $0.alignment = .center
  }
  let detailContainerView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 2
  }
  let imageView = UIImageView(image: .icPlaylist)
  let playlistLabel = UILabel().then {
    $0.text = Localized.commonPlaylist
    $0.textColor = .silver
    $0.font = .avenirRegular(12)
  }
  let titleLabel = UILabel().then {
    $0.text = Localized.commonPlaylist
    $0.textColor = .white
    $0.font = .avenirMedium(20)
  }
  let descriptionLabel = UILabel().then {
    $0.text = Localized.createPlaylistDescription
    $0.textColor = .silver
    $0.font = .avenirMedium(12)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods

private extension AddLibraryCreatePlaylistView {
  func configureUI() {
    addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(24)
    }
    stackView.addArrangedSubviews(
      playlistContainerView,
      detailContainerView
    )
    
    playlistContainerView.addArrangedSubviews(
      imageView,
      playlistLabel
    )
    detailContainerView.addArrangedSubviews(
      titleLabel,
      descriptionLabel
    )
    
    playlistContainerView.snp.makeConstraints {
      $0.width.equalTo(50)
    }
    imageView.snp.makeConstraints {
      $0.width.height.equalTo(32)
    }
  }
}
