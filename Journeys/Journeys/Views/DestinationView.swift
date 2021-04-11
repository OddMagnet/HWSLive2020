//
//  DestinationView.swift
//  Journeys
//
//  Created by Michael Brünen on 09.04.21.
//

import SwiftUI

struct DestinationView: View {
    let location: Location

    var body: some View {
        VStack {
            Image(location.country)
                .renderingMode(.original)   // avoiding images getting blue tint in NavigationLinks
                .resizable()
                .flagStyle()
                .scaledToFit()

            Text(location.name)
                .font(.subheadline)
            Text(location.country)
                .font(.title2)
                .bold()
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 5)
        .padding()
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            DestinationView(location: Location.example)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
