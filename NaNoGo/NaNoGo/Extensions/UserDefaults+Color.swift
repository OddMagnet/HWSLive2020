//
//  UserDefaults+Color.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

extension UserDefaults {
    func set(_ value: Color, forKey key: String) {
        // convert to UIColor
        let color = UIColor(value)
        // get the colors components
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        // then save them individually
        UserDefaults.standard.set(red, forKey: "\(key)Red")
        UserDefaults.standard.set(green, forKey: "\(key)Green")
        UserDefaults.standard.set(blue, forKey: "\(key)Blue")
        UserDefaults.standard.set(alpha, forKey: "\(key)Alpha")
        // use the given key to set a boolean, so when retrieving it can be checked if there are colors under the sub-keys
        UserDefaults.standard.set(true, forKey: key)
        print("Set color for key: \(key)")
    }

    func color(forKey key: String) -> Color? {
        // check if the given key is true, if yes, the sub-keys will have values for the color
        if UserDefaults.standard.bool(forKey: key) {
            let red = UserDefaults.standard.double(forKey: "\(key)Red")
            let green = UserDefaults.standard.double(forKey: "\(key)Green")
            let blue = UserDefaults.standard.double(forKey: "\(key)Blue")
            let alpha = UserDefaults.standard.double(forKey: "\(key)Alpha")
            // then create and return the color
            print("Retrieved color for key: \(key)")
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        } else {
            print("Could not retrieve color for key: \(key)")
            // if the given key does not exist, then there are no values for the color
            return nil
        }
    }
}
