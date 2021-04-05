//
//  PicksView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI

struct PicksView: View {
    @EnvironmentObject var locations: Locations

    var body: some View {
        Text("Hello, World!")
            .padding()
            .navigationTitle("Our Top Picks")
    }
}

struct PicksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PicksView()
        }
        .environmentObject(Locations())
    }
}
