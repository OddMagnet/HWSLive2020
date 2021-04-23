//
//  HeaderView.swift
//  Symbol Explorer
//
//  Created by Michael Brünen on 23.04.21.
//

import UIKit

class HeaderView: UICollectionReusableView {
    let label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        let inset: CGFloat = 20

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported at the moment.")
    }
}
