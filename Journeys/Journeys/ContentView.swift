//
//  ContentView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI
import MapKit

/*
Your company has been asked to build a proof of concept for a travel company – if the prototype gets the green light then you'll be paid an absurd amount of money to build more or less the same thing, just with fewer bugs. (Probably)
Your CTO put together the bare bones of the app, but it's down to you to fill it out with lots of SwiftUI code from iOS 14.
*/

struct ContentView: View {
    @EnvironmentObject var locations: Locations
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.689722, longitude: 139.692222),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    let manager = CLLocationManager()

    var body: some View {
        TabView {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                Text("\(region.center.latitude), \(region.center.longitude)")
            }
            .onAppear {
                manager.requestWhenInUseAuthorization()
            }
            .tabItem {
                Image(systemName: "star")
                Text("TEST")
            }

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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Locations())
    }
}
