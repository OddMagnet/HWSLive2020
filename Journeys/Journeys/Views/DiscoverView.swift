//
//  DiscoverView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI
import MapKit

struct DiscoverView: View {
    let location: Location
    @State private var region: MKCoordinateRegion

    init(location: Location) {
        self.location = location
        _region = State(wrappedValue: MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image(location.heroPicture)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: geo.size.width)
                    .frame(height: geo.size.height * 0.7)

                ScrollView(showsIndicators: false) {
                    Spacer().frame(height: geo.size.height * 0.35)

                    HStack {
                        Text(location.name)
                            .font(.system(size: 48, weight: .bold))
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(1), radius: 5)

                        Spacer()
                    }
                    .padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(location.country)
                                .font(.title)
                                .bold()

                            Spacer()

                            Button {
                                print("Bookmarked")
                            } label: {
                                Image(systemName: "heart")
                                    .font(.title)
                                    .padding(20)
                                    .background(Circle().fill(Color.white))
                                    .shadow(radius: 20)
                            }
                            .offset(y: -40)
                        }
                        .padding(.horizontal, 20)

                        // Example solution for Discovery-Tab images
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(location.pictures, id: \.self) { picture in
                                    Image("\(picture)-thumb")
                                        .resizable()
                                        .frame(width: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            .frame(height: 100)
                            .padding([.horizontal, .bottom], 20)
                        }

                        VStack(alignment: .leading) {
                            Text(location.description)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Dont't miss")
                                .font(.title3)
                                .bold()
                                .padding(.top, 20)

                            // Example solution for integrating a map
                            Map(coordinateRegion: $region, interactionModes: [])
                                .aspectRatio(2, contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.secondary.opacity(0.5), lineWidth: 2)
                                )

                            // Example solution for Disclosure Group
                            if location.advisory.isEmpty == false {
                                DisclosureGroup {
                                    Text(location.advisory)
                                } label: {
                                    Text("Travel advisories")
                                        .font(.headline)
                                }
                                .padding(.top)
                            }

                            Text(location.more)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 50)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Background"))
                    )
                }
            }
        }
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(location: Location.example)
    }
}
