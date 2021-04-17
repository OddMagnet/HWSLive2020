//
//  MapView.swift
//  Journeys
//
//  Created by Michael Brünen on 11.04.21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locations: Locations

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: Location.example.location.latitude,
            longitude: Location.example.location.longitude
        ),
        span: MKCoordinateSpan(latitudeDelta: 150, longitudeDelta: 150)
    )

    @ScaledMetric var annotationWidth: CGFloat = 60
    @ScaledMetric var annotationHeight: CGFloat = 30

    var body: some View {
        // Create a map with annotationItems, using the `places` array of the EnvironmentObject `locations`
        Map(coordinateRegion: $region, annotationItems: locations.places) { location in
            // For each location create a MapAnnotation
            MapAnnotation(coordinate: location.coordinate) {
                // Each annotation links towards the locations DiscoverView
                NavigationLink(destination: DiscoverView(location: location)) {
                    // The Label of the NavigationLink also serves as the marker on the map
                    // Each marker consists of the countries flag, as well as the locations name
                    VStack(spacing: 1) {
                        Image(location.country)
                            .renderingMode(.original)   // avoid blue tint from the link
                            .resizable()
                            .flagStyle()
                            .frame(width: annotationWidth, height: annotationHeight)

                        Text(location.name)
                            .bold()
                    }
                }
            }
        }
        .navigationTitle("Journeys Map")
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MapView()
        }
        .environmentObject(Locations())
    }
}
