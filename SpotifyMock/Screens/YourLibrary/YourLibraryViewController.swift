//
//  YourLibraryViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit
import SnapKit

final class YourLibraryViewController: TabBarItemViewController {
  
  // MARK: - UI Properties
  
  private(set) lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    $0.backgroundColor = .black
    $0.register(cell: PlaylistCell.self)
    $0.register(cell: GridPlaylistCell.self)
    $0.delegate = self
  }
  private let headerView = YourLibraryHeaderView()
  
  private var dataSource: CollectionViewDiffableDataSource<CollectionSectionDataSrouce, PlaylistDataSource>?
  
  private let viewModel: YourLibraryViewModel
  
  // MARK: - Initializers
  
  init(viewModel: YourLibraryViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureDataSource()
    bindViewModel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.getPlaylists()
  }
  
  @objc private func onTapAddButton() {
    present(.addLibrary(delegate: self))
  }
}

// MARK: - Private Methods

private extension YourLibraryViewController {
  func configureUI() {
    configureNavBar()
    
    view.addSubviews(headerView, collectionView)
    headerView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
    collectionView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.bottom.leading.trailing.equalToSuperview()
    }
    headerView.delegate = self
  }
  
  func configureNavBar() {
    addLeftBarButtonItem(
      image: .icPersonFill?.withColor(.gray),
      size: CGSize(width: 34, height: 34)
    )
    addRightBarButtonItem(
      image: .icAdd.withColor(.quickSilver),
      action: #selector(onTapAddButton)
    )
    addLeftBarTitle(title: Localized.commonYourLibrary)
    applyStandardAppearance()
  }
  
  func configureDataSource() {
    dataSource = CollectionViewDiffableDataSource(
      collectionView: collectionView,
      layoutProvider: { section in
        switch section {
        case .grid:
          let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
          
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
          
          let section = NSCollectionLayoutSection(group: group)
          section.interGroupSpacing = 8
          section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
          return section
        case .list:
          let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(84))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
          let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(84))
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
          
          let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
          return section
        }
      },
      cellProvider: { [weak self] collectionView, indexPath, item in
        self?.createCell(for: indexPath, with: item)
      }
    )
  }
  
  func createCell(for indexPath: IndexPath, with item: PlaylistDataSource) -> UICollectionViewCell? {
    let section = self.dataSource?.sectionIdentifier(for: indexPath.section)
    switch section {
    case .list:
      let cell = collectionView.dequeueReusableCell(for: indexPath, cell: PlaylistCell.self)
      cell.updateUI(with: item)
      return cell
    case .grid:
      let cell = collectionView.dequeueReusableCell(for: indexPath, cell: GridPlaylistCell.self)
      cell.updateUI(with: item)
      return cell
    default:
      return nil
    }
  }
  
  func bindViewModel() {
    viewModel.$isLoading
      .sinkOnMainThread(
        onReceiveValue: { [weak self] isLoading in
          self?.setLoadingIndicator(isLoading: isLoading)
        },
        storeIn: &cancellables
      )
    
    viewModel.$playlistsDataSource.sinkOnMainThread(
      onReceiveValue: { [weak self] playlists in
        guard let `self` else { return }
        self.dataSource?.applySnapshot(
          sections: [self.viewModel.collectionSection],
          items: [self.viewModel.collectionSection: playlists]
        )
      },
      storeIn: &cancellables
    )
    
    viewModel.$collectionSection
      .sinkOnMainThread(
        onReceiveValue: { [weak self] section in
          guard let `self` else { return }
          self.headerView.updateUI(for: section)
          self.dataSource?.applySnapshot(
            sections: [section],
            items: [section: viewModel.playlistsDataSource]
          )
        },
        storeIn: &cancellables)
  }
}

// MARK: - UICollectionViewDelegate

extension YourLibraryViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let playlist = dataSource?.itemIdentifier(for: indexPath) else { return }
    push(to: .playlist(playlist: playlist.toDomain()))
  }
}

// MARK: - YourLibraryHeaderView

extension YourLibraryViewController: YourLibraryHeaderViewDelegate {
  func onTapSwitchButton() {
    viewModel.toggleLibrarySection()
  }
}

// MARK: - CreatePlaylistViewDegate

extension YourLibraryViewController: CreatePlaylistViewDegate {
  func onPlaylistDidCreate(playlist: PlaylistModel) {
    push(to: .playlist(playlist: playlist))
  }
}

// MARK: - AddLibraryViewDelegate

extension YourLibraryViewController: AddLibraryViewDelegate {
  func onCreateNewPlaylist() {
    present(.createPlaylist(delegate: self))
  }
}
