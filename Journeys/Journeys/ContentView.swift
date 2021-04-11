//
//  ContentView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI

/*
Your company has been asked to build a proof of concept for a travel company – if the prototype gets the green light then you'll be paid an absurd amount of money to build more or less the same thing, just with fewer bugs. (Probably)
Your CTO put together the bare bones of the app, but it's down to you to fill it out with lots of SwiftUI code from iOS 14.
*/

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Locations())
    }
}
