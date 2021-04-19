//
//  DiscoverView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI
import MapKit
import VisualEffects

struct DiscoverView: View {
    let location: Location
    @Namespace var matchedGeometry                              // used for matched geometry effect
    @State private var travelAdvisoryShowing = false
    @State private var selectedPicture: String?                 // used for matched geometry effect
    @ScaledMetric var locationPreviewHeight: CGFloat = 85.0
    @ScaledMetric var locationPreviewWidth: CGFloat = 150.0

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
                                    // if the picture is selected, show a placeholder
                                    if selectedPicture == picture {
                                        Color.clear
                                            .frame(width: locationPreviewWidth)
                                    } else {
                                        // otherwise just display the picture
                                        Image("\(picture)-thumb")
                                            .resizable()
                                            .frame(width: locationPreviewWidth)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            // add the namespace for the matched geometry, using the pictures name as id
                                            .matchedGeometryEffect(id: picture, in: matchedGeometry)
                                            .onTapGesture {
                                                // when tapped, change the selectedPicture with an animation
                                                withAnimation(.easeInOut(duration: 0.3)) {
                                                    selectedPicture = picture
                                                }
                                            }
                                    }
                                }
                            }
                        }
                        .frame(height: locationPreviewHeight)
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

                // Overlay for selected picture
                if let picture = selectedPicture {
                    VStack {
                        ScrollView {
                            VStack(alignment: .center) {
                                Image(picture)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: .infinity)    // let the image take as much height as it needs
                                    .matchedGeometryEffect(id: picture, in: matchedGeometry)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedPicture = nil
                                        }
                                    }

                                Text("\(picture) - Location name")  // placeholder for later real location names
                                    .font(.title)
                                    .bold()
                                    .padding()

                                Text(String.init(repeating: "Placeholder ", count: 52))
                                    .padding(.horizontal)
                            }
                        }

                        Button {
                            withAnimation {
                                selectedPicture = nil
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                            Text("Close")
                                .bold()
                        }
                        .font(.title2)
                        // Give the text some space
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        // Back- and foreground colors
                        .background(Color.blue)
                        .foregroundColor(.white)
                        // Rounded corners
                        .cornerRadius(20)
                        // some padding
                        .padding(3)
                        // and an outer circle
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 3)
                        )
                        // and make sure it doesn't touch the navbar
                        .padding(.bottom, 10)
                    }
                    .background(
                        VisualEffectBlur(blurStyle: .systemThinMaterial)
                    )
                    .zIndex(99)
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
