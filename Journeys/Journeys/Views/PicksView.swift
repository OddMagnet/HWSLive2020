//
//  PicksView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI

struct PicksView: View {
    @EnvironmentObject var locations: Locations

    let columns: [GridItem] = [
        .init(.adaptive(minimum: 200))
    ]

    var body: some View {
        ScrollView {
            TabView {
                ForEach(1 ..< 9) { img in
                    GeometryReader { geo in
                        Image("photo\(img)")
                            .resizable()
                            .scaledToFill()
                            .padding(.horizontal ,2)
                            .frame(width: geo.size.width)
                            .clipped()
                        /* Reasoning for modifiers
                         - resizable, to enable further modifiers
                         - scaledToFill, so the frame will be filled no matter what
                         - padding() to add a little bit of visible background to the sides
                         - frame(...), to provide a frame that fills the screens width
                         - clipped(), to clip whatever goes outside the frame, if necessary
                         */
                    }
                }
            }
            .frame(height: 280)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle())

            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                ForEach(locations.places) { place in
                    NavigationLink(destination: DiscoverView(location: place)) {
                        DestinationView(location: place)
                    }
                }
            }
        }
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
