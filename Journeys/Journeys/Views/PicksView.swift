//
//  PicksView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI

struct PicksView: View {
    @EnvironmentObject var locations: Locations

    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]

    var body: some View {
        // Example solution for Paging TabView
        ScrollView {
            TabView {
                ForEach(1..<9) { picture in
                    GeometryReader { geo in
                        Image("photo\(picture)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width)
                            .clipped()
                    }
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            // Example solution for Grids
            LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                ForEach(locations.places) { place in
                    NavigationLink(destination: DiscoverView(location: place)) {
                        Place(location: place)
                    }
                }
            }
        }
        .background(Color(white: 0.95))
        .navigationTitle("Our Top Picks")
    }
}

struct Place: View {
    let location: Location

    var body: some View {
        VStack {
            Image(location.country)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(location.name)
                .font(.title3)
            Text(location.country)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 10)
        .padding()
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
