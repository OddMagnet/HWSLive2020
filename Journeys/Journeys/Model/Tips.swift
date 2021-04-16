//
//  Tips.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import Foundation

struct Tip: Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case title, image, body
    }

    let id = UUID()
    let title: String
    let image: String
    let body: String
}

struct ExpandingTip: Identifiable {
    var id: String { content }
    let content: String
    var image: String?
    var answer: [ExpandingTip]?
}
