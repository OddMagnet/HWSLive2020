//
//  Store.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import CoreLocation
import Foundation

struct Store: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let address: String
    let location: Coordinate

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }

    static func ==(lhs: Store, rhs: Store) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static let example = Bundle.main.decode([Store].self, from: "stores.json")[0]
}
