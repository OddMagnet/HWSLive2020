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
        return UICollectionViewCompositionalLayout.list(using: config)
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

        // create the data source
        let source = UICollectionViewDiffableDataSource<String, Row>(collectionView: collectionView) { collectionView, indexPath, identifier in
            collectionView.dequeueConfiguredReusableCell(using: cell, for: indexPath, item: identifier)
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

