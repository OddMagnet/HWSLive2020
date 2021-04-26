//
//  ContentView.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = DataModel(canPurchase: true)

    var body: some View {
        TabNavigationView()
            .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
