//
//  Service.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import Foundation

struct Service: Decodable, Identifiable {
    let id: String
    let name: String
    let description: String
    let price: Decimal
    let duration: TimeInterval

    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: price as NSNumber) ?? "Free"
    }

    static let example = Bundle.main.decode([Service].self, from: "services.json")[0]
}
