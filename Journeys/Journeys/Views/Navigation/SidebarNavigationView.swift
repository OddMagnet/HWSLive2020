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
                    Label("Discover", systemImage: "leaf.fill")
                }

                NavigationLink(destination: PicksView()) {
                    Label("Top Picks", systemImage: "star.fill")
                }

                NavigationLink(destination: TipsView()) {
                    Label("Tips", systemImage: "lightbulb.fill")
                }

                NavigationLink(destination: MapView()) {
                    Label("Map", systemImage: "map.fill")
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
