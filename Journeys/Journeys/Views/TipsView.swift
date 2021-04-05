//
//  TipsView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI

struct TipsView: View {
    let tips = Bundle.main.decode([Tip].self, from: "tips.json")

    var body: some View {
        List(tips) { tip in
            VStack(alignment: .leading) {
                Text(tip.title)
                    .font(.headline)
                Text(tip.body)
            }
            .padding(.vertical)
        }
        .navigationTitle("Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TipsView()
        }
    }
}
