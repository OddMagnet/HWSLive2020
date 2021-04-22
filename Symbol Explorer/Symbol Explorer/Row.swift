//
//  Row.swift
//  Symbol Explorer
//
//  Created by Michael Brünen on 22.04.21.
//

import Foundation

struct Row: Hashable, Decodable {
    enum CodingKeys: CodingKey {
        case title, items
    }

    let title: String
    var items: [Row]

    init(title: String, items: [Row]) {
        self.title = title
        self.items = items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)

        let strings = try container.decode([String].self, forKey: .items)
        items = strings.map { Row(title: $0, items: [])}
    }
}
