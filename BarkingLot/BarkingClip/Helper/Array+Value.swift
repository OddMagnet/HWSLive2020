//
//  Array+Value.swift
//  BarkingClip
//
//  Created by Michael Brünen on 27.04.21.
//

import Foundation

extension Array where Element == URLQueryItem {
    func value(for name: String) -> String? {
        first(where: { $0.name == name })?.value
    }
}
