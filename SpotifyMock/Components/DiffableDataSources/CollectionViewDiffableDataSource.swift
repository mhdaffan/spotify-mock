//
//  CollectionViewDiffableDataSource.swift
//  SpotifyMock
//
//  Created by Muhammad Affan on 08/12/24.
//

import UIKit

final class CollectionViewDiffableDataSource<Section: Hashable, Item: Hashable>: NSObject {
  private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
  
  init(
    collectionView: UICollectionView,
    layoutProvider: @escaping (Section) -> NSCollectionLayoutSection,
    cellProvider: @escaping (UICollectionView, IndexPath, Item) -> UICollectionViewCell?
  ) {
    super.init()
    
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(
      collectionView: collectionView,
      cellProvider: cellProvider
    )
    
    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
      guard let `self`, let section = self.dataSource?.snapshot().sectionIdentifiers[safe: sectionIndex] else {
        return nil
      }
      return layoutProvider(section)
    }
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
