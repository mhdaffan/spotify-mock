//
//  PlaylistViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit
import SnapKit
import Combine

final class PlaylistViewController: ViewController {
  
  // MARK: - UI Properties
  
  private(set) lazy var tableView = UITableView().then {
    $0.backgroundColor = .black
    $0.separatorStyle = .none
    $0.register(cell: PlaylistTrackCell.self)
  }
  private(set) lazy var tableHeaderView = PlaylistHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
  private let viewModel: PlaylistViewModel
  
  private var dataSource: TableViewDiffableDataSource<SectionDataSrouce, TrackDataSource>?
  
  // MARK: - Initializers
  
  init(viewModel: PlaylistViewModel) {
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
    addKeyboardObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.getTracks()
  }
  
  @objc private func onTapAddButton() {
    push(to: .addPlaylistTracks(playlist: viewModel.playlist))
  }
}

// MARK: - Private Methods

private extension PlaylistViewController {
  func configureUI() {
    addRightBarButtonItem(
      image: .icAdd.withColor(.quickSilver),
      action: #selector(onTapAddButton)
    )
    
    applyStandardAppearance()
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    tableView.tableHeaderView = tableHeaderView
  }
  
  private func configureDataSource() {
    dataSource = TableViewDiffableDataSource(
      tableView: tableView,
      cellProvider: { tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: PlaylistTrackCell.self)
        cell.updateUI(with: item)
        cell.onTapMore = { [weak self] in
          self?.showAlert(
            actions: [
              UIAlertAction(title: Localized.commonRemove, style: .destructive, handler: { [weak self] _ in
                self?.viewModel.removeTrack(track: item)
              }),
              UIAlertAction(title: Localized.commonCancel, style: .cancel)
            ],
            preferredStyle: .actionSheet)
        }
        return cell
      }
    )
  }
  
  func bindViewModel() {
    viewModel.$tracksDataSource
      .sinkOnMainThread(
        onReceiveValue: { [weak self] tracks in
          self?.dataSource?.applySnapshot(
            sections: [.main],
            items: [.main: tracks]
          )
        }, storeIn: &cancellables)
    
    viewModel.$playlistHeaderModel
      .sinkOnMainThread(
        onReceiveValue: { [weak self] model in
          self?.tableHeaderView.updateUI(with: model)
        },
        storeIn: &cancellables)
  }
}
