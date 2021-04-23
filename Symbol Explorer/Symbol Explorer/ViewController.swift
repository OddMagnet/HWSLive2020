//
//  ViewController.swift
//  Symbol Explorer
//
//  Created by Michael Brünen on 22.04.21.
//

import UIKit

class ViewController: UIViewController {
    // Layout for the CollectionView
    lazy var layout: UICollectionViewLayout = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)

        // swipe to delete
        config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            UISwipeActionsConfiguration(actions: [
                UIContextualAction(style: .destructive, title: "Delete", handler: { action, view, completion in
                    guard let self = self else {
                        completion(false)
                        return
                    }

                    self.data[indexPath.section].items.remove(at: indexPath.item)
                    self.updateSnapshot(animating: true)
                    completion(true)
                })
            ])
        }

        // header
        config.headerMode = .supplementary

        return UICollectionViewCompositionalLayout.list(using: config)
    }()

    // alternative layout
    lazy var flowLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 100)
        return layout
    }()

    // The CollectionView itself
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()

    // Data Source
    lazy var dataSource: UICollectionViewDiffableDataSource<String, Row> = {
        // create a cell registration
        let cell = UICollectionView.CellRegistration<UICollectionViewListCell, Row> { [weak self] cell, indexPath, row in
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: row.title)
            content.text = row.title
            cell.contentConfiguration = content
        }

        // create a header
        let header = UICollectionView.SupplementaryRegistration<HeaderView>(elementKind: "Header") { [weak self] supplementaryView, string, indexPath in
            guard let firstApp = self?.dataSource.itemIdentifier(for: indexPath) else { return }
            guard let section = self?.dataSource.snapshot().sectionIdentifier(containingItem: firstApp) else { return }
            supplementaryView.label.text = section
        }

        // create the data source
        let source = UICollectionViewDiffableDataSource<String, Row>(collectionView: collectionView) { collectionView, indexPath, identifier in
            collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: identifier)
        }

        // add the header
        source.supplementaryViewProvider = { view, kind, index in
            self.collectionView.dequeueConfiguredReusableSupplementary(using: header, for: index)
        }

        return source
    }()

    var data = Bundle.main.decode([Row].self, from: "symbols.json")

    override func loadView() {
        view = UIView(frame: .zero)
        view.addSubview(collectionView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateSnapshot(animating: false)
    }

    /// Updates the data source with a snapshot
    /// - Parameter animating: If the update should be animated
    func updateSnapshot(animating: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<String, Row>()
        snapshot.appendSections(data.map(\.title))

        for section in data {
            snapshot.appendItems(section.items, toSection: section.title)
        }

        dataSource.apply(snapshot, animatingDifferences: animating)
    }
}

