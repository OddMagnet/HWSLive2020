//
//  DataModel.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import Foundation

class DataModel: ObservableObject {
    @Published var canPurchase = false
    @Published var selectedStore: String?

    init(canPurchase: Bool) {
        _canPurchase = Published(initialValue: canPurchase)
    }
}
