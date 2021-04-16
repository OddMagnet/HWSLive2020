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

// Example solution for Sidebar
struct SidebarNavigation: View {
    @EnvironmentObject var locations: Locations

    var body: some View {
        NavigationView {
            // Example solution for labels
            List {
                NavigationLink(destination: DiscoverView(location: locations.primary)) {
                    Label("Discover", systemImage: "airplane.circle.fill")
                }

                NavigationLink(destination: PicksView()) {
                    Label("Our Picks", systemImage: "star.fill")
                }

                NavigationLink(destination: LocationsView()) {
                    Label("Map", systemImage: "map.fill")
                }

                NavigationLink(destination: TipsView()) {
                    Label("Tips", systemImage: "list.bullet")
                }
            }
            .navigationTitle("Journeys")
            .listStyle(SidebarListStyle())

            DiscoverView(location: locations.primary)
        }
    }
}
// Example solution for Sidebar
struct TabNavigation: View {
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
                LocationsView()
            }
            .tabItem {
                Image(systemName: "map.fill")
                    .imageScale(.large)
                Text("Map")
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    // Example solution for Sidebar
    var body: some View {
        if sizeClass == .compact {
            TabNavigation()
        } else {
            SidebarNavigation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Locations())
    }
}
