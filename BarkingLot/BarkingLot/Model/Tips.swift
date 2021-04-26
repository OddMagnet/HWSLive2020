//
//  Tips.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import Foundation

struct Tips: Decodable, Identifiable {
    var id: String { title }
    var title: String
    var body: String
}
