//
//  TipsView.swift
//  BarkingLot
//
//  Created by Michael Brünen on 26.04.21.
//

import SwiftUI

struct TipsView: View {
    let tips = Bundle.main.decode([Tips].self, from: "tips.json")

    var body: some View {
        List(tips) { tip in
            VStack(alignment: .leading) {
                Text(tip.title)
                    .font(.headline)

                Text(tip.body)
            }
            .padding()
        }
        .navigationTitle("Grooming Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
