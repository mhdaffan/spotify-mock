//
//  TableViewDiffableDataSource.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

final class TableViewDiffableDataSource<Section: Hashable, Item: Hashable>: NSObject {
  private var dataSource: UITableViewDiffableDataSource<Section, Item>?
  
  init(
    tableView: UITableView,
    cellProvider: @escaping (UITableView, IndexPath, Item) -> UITableViewCell?
  ) {
    super.init()
    dataSource = UITableViewDiffableDataSource<Section, Item>(
      tableView: tableView,
      cellProvider: cellProvider
    )
  }
  
  func applySnapshot(
    sections: [Section],
    items: [Section: [Item]],
    animated: Bool = true
  ) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections(sections)
    for section in sections {
      snapshot.appendItems(items[section] ?? [], toSection: section)
    }
    dataSource?.apply(snapshot, animatingDifferences: animated)
  }
  
  func currentSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item>? {
    dataSource?.snapshot()
  }
  
  func updateItem(_ item: Item) {
    guard var snapshot = currentSnapshot() else { return }
    snapshot.reloadItems([item])
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
  
  func deleteItem(_ item: Item) {
    guard var snapshot = currentSnapshot() else { return }
    snapshot.deleteItems([item])
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
  
  func itemIdentifier(for indexPath: IndexPath) -> Item? {
    dataSource?.itemIdentifier(for: indexPath)
  }
  
  func sectionIdentifier(for section: Int) -> Section? {
    dataSource?.sectionIdentifier(for: section)
  }
}
