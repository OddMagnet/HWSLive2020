//
//  BarkingClipApp.swift
//  BarkingClip
//
//  Created by Michael Brünen on 27.04.21.
//

import SwiftUI
import AppClip
import CoreLocation

@main
struct BarkingClipApp: App {
    @StateObject var model = DataModel(canPurchase: false)

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SelectStoreView()
            }
            .environmentObject(model)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleActivity)
        }
    }

    func handleActivity(_ userActivity: NSUserActivity) {
        // check that the url, its components and queryItems are valid
        guard let url = userActivity.webpageURL else { return }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        guard let queryItems = components.queryItems else { return }

        // select the store if available
        if let storeID = queryItems.value(for: "store") {
            model.selectedStore = storeID
        }

        // try to verify location
        guard let payload = userActivity.appClipActivationPayload,
              let lat = queryItems.value(for: "latitude"),
              let lon = queryItems.value(for: "longitude"),
              let latitude = Double(lat),
              let longitude = Double(lon) else {
            return
        }

        // set location
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: 100, identifier: "location")


        payload.confirmAcquired(in: region) { inRegion, error in
            // if an error occured
            if let error = error as? APActivationPayloadError {
                switch error.code {
                    case .disallowed:
                        print("Not launched via QR code")
                    case .doesNotMatch:
                        print("Region does not match location")
                    default:
                        print(error.localizedDescription)
                }
            } else {
                // location confirmed – enable purchasing if we are inside the region
                DispatchQueue.main.async {
                    model.canPurchase = inRegion
                }
            }

            // testing purposes only – always enable purchasing!
            DispatchQueue.main.async {
                model.canPurchase = true
            }
        }
    }
}
