//
//  PicksView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI

struct PicksView: View {
    @EnvironmentObject var locations: Locations

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
        }
        .background(Color(white: 0.95))
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
