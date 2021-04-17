//
//  LocationsView.swift
//  Journeys
//
//  Created by Michael Brünen on 11.04.21.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject var locations: Locations

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40))

    // Example for proportional scaling
    @ScaledMetric var annotationSize: CGFloat = 80.0

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations.places) { location in
            MapAnnotation(coordinate: location.coordinate) {
                NavigationLink(destination: DiscoverView(location: location)) {
                    Image(location.country)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: annotationSize, height: annotationSize / 2)   // Example for proportional scaling
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 4)
                        )
                }
            }
        }
        .navigationTitle("Vacation Map")
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationsView()
        }
        .environmentObject(Locations())
    }
}
