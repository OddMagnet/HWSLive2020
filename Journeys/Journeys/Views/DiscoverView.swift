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
    @State private var travelAdvisoryShowing = false

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

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(location.pictures, id: \.self) { picture in
                                    Image("\(picture)-thumb")
                                        .resizable()
                                        .frame(width: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .frame(height: 85)
                        .padding(.horizontal)
                        .padding(.bottom)

                        VStack(alignment: .leading) {
                            Text(location.description)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Dont't miss")
                                .font(.title3)
                                .bold()
                                .padding(.top, 20)

                            Map(
                                coordinateRegion: .constant(
                                    MKCoordinateRegion(
                                        center: location.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                                    )
                                ),
                                interactionModes: []
                            )
                            .aspectRatio(2, contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black.opacity(0.5), lineWidth: 2)
                            )

                            if location.advisory.isEmpty == false {
                                VStack {
                                    DisclosureGroup(isExpanded: $travelAdvisoryShowing) {
                                        Text(location.advisory)
                                            .font(.caption)
                                    } label: {
                                        Text("Travel Advisories")
                                            .font(.headline)
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation {
                                            travelAdvisoryShowing.toggle()
                                        }
                                    }

                                    Spacer()
                                }
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
