//
//  TabNavigationView.swift
//  Journeys
//
//  Created by Michael Brünen on 15.04.21.
//

import SwiftUI

struct TabNavigationView: View {
    @EnvironmentObject var locations: Locations

    var body: some View {
        TabView {
            DiscoverView(location: locations.primary)
                .tabItem {
                    Image(systemName: "airplane.circle.fill")
                        .imageScale(.large)
                    Text("Discover")
                }

            NavigationView {
                PicksView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                    .imageScale(.large)
                Text("Picks")
            }

            NavigationView {
                TipsView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                    .imageScale(.large)
                Text("Tips")
            }

            NavigationView {
                MapView()
            }
            .tabItem {
                Image(systemName: "map.fill")
                Text("Map")
            }
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
            .environmentObject(Locations())
    }
}
