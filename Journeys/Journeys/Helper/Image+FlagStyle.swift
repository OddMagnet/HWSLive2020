//
//  FlagShape.swift
//  Journeys
//
//  Created by Michael Brünen on 11.04.21.
//

import SwiftUI

extension Image {
    func flagStyle() -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        Image("Japan")
            .flagStyle()
    }
}
