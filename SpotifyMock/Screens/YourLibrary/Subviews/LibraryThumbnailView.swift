//
//  LibraryThumbnailView.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit
import SnapKit

final class ThumbnailView: UIView {
  
  // MARK: - UI Properties
  
  private let containerStackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .fillEqually
  }
  private let topRowStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
  }
  private let bottomRowStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
  }
  private(set) lazy var imageView1 = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  private(set) lazy var imageView2 = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  private(set) lazy var imageView3 = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  private(set) lazy var imageView4 = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  private(set) lazy var singleImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  
  // MARK: - Initializers
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with model: LibraryThumbnailType) {
    switch model {
    case .placeholder:
      singleImageView.image = .icMusicNote?.withColor(.silver)
      showGrid(false)
    case .single(let url):
      singleImageView.setImage(from: url)
      showGrid(false)
    case .multiple(let url1, let url2, let url3, let url4):
      imageView1.setImage(from: url1)
      imageView2.setImage(from: url2)
      imageView3.setImage(from: url3)
      imageView4.setImage(from: url4)
      showGrid(true)
    }
  }
}

// MARK: - Private Methods

private extension ThumbnailView {
  private func configureUI() {
    addSubviews(containerStackView, singleImageView)
    singleImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    containerStackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    containerStackView.addArrangedSubviews(
      topRowStackView,
      bottomRowStackView
    )
    topRowStackView.addArrangedSubviews(
      imageView1,
      imageView2
    )
    bottomRowStackView.addArrangedSubviews(
      imageView3,
      imageView4
    )
  }
  
  func showGrid(_ show: Bool) {
    containerStackView.isHidden = !show
    singleImageView.isHidden = show
  }
}
