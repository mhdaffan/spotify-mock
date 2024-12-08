//
//  AddPlaylistTracksViewController.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 07/12/24.
//

import UIKit
import SnapKit
import Combine

final class AddPlaylistTracksViewController: ViewController {
  
  // MARK: - UI Properties
  
  private(set) lazy var searchController = UISearchController().then {
    $0.searchBar.placeholder = Localized.commonSearch
    $0.searchBar.barStyle = .black
    $0.searchBar.tintColor = .white
    $0.searchBar.barTintColor = .white
    $0.searchBar.delegate = self
  }
  private(set) lazy var tableView = UITableView().then {
    $0.backgroundColor = .black
    $0.separatorStyle = .none
    $0.register(cell: AddTrackCell.self)
  }
  
  private let viewModel: AddPlaylistTracksViewModel
  
  private var dataSource: TableViewDiffableDataSource<SectionDataSrouce, TrackDataSource>?
  
  // MARK: - Initializers
  
  init(viewModel: AddPlaylistTracksViewModel) {
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
}

// MARK: - Private Methods

private extension AddPlaylistTracksViewController {
  func configureUI() {
    applyStandardAppearance()
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func configureDataSource() {
    dataSource = TableViewDiffableDataSource(
      tableView: tableView,
      cellProvider: { tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: AddTrackCell.self)
        cell.updateUI(with: item)
        cell.onTapAdd = { [weak self] in
          self?.viewModel.saveTrack(with: item)
        }
        return cell
      }
    )
  }
  
  func bindViewModel() {
    viewModel.$isLoading
      .sinkOnMainThread(
        onReceiveValue: { [weak self] isLoading in
          self?.setLoadingIndicator(on: self?.view, isLoading: isLoading)
        },
        storeIn: &cancellables
      )
    
    viewModel.$tracksDataSource
      .sinkOnMainThread(
        onReceiveValue: { [weak self] tracks in
          self?.dataSource?.applySnapshot(
            sections: [.main],
            items: [.main: tracks]
          )
        },
        storeIn: &cancellables
      )
    
    viewModel.$searchKeyword
      .debounceOnMainThread()
      .removeDuplicates()
      .sinkToResult(
        onReceiveValue: { [weak self] keyword in
          self?.viewModel.getTracks(for: keyword)
        },
        storeIn: &cancellables
      )
  }
}

// MARK: - UISearchBarDelegate

extension AddPlaylistTracksViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchKeyword = searchText
  }
}
