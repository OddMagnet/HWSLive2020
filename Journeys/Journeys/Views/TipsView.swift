//
//  TipsView.swift
//  Journeys
//
//  Created by Michael Brünen on 05.04.21.
//

import SwiftUI

struct TipsView: View {
    let tips = Bundle.main.decode([Tip].self, from: "tips.json")

    var expandingTips: [ExpandingTip] {
        var result = [ExpandingTip]()

        for tip in tips {
            let child = ExpandingTip(content: tip.body)
            let parent = ExpandingTip(content: tip.title, image: tip.image, answer: [child])
            result.append(parent)
        }

        return result
    }

    var body: some View {
        List(expandingTips, children: \.answer) { tip in
            VStack(alignment: .leading) {
                if tip.answer != nil {      // different font for the titles
                    Label(tip.content, systemImage: tip.image ?? "error")
                        .font(.headline)
                } else {
                    Text(tip.content)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Text("iPad Placeholder Text")
            TipsView()
        }
    }
}
