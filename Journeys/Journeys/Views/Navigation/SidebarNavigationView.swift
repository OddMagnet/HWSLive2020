//
//  SidebarNavigationView.swift
//  Journeys
//
//  Created by Michael Brünen on 15.04.21.
//

import SwiftUI

struct SidebarNavigationView: View {
    @EnvironmentObject var locations: Locations

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DiscoverView(location: locations.primary)) {
                    Text("Discover")
                }

                NavigationLink(destination: PicksView()) {
                    Text("Picks")
                }

                NavigationLink(destination: TipsView()) {
                    Text("Tips")
                }

                NavigationLink(destination: MapView()) {
                    Text("Map")
                }
            }
            .navigationTitle("Journeys")
            .listStyle(SidebarListStyle())

            DiscoverView(location: locations.primary)
        }
    }
}

struct SidebarNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SidebarNavigationView()
                .environmentObject(Locations())
        }
    }
}
