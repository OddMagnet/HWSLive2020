//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("text") var text = ""
    @State private var fontSize: CGFloat = 17

    var body: some View {
        NavigationView {
            TextEditor(text: $text)
                .font(.system(size: fontSize))
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Stepper("Font size", value: $fontSize)
                            .labelsHidden()
                    }
                }
                .navigationTitle("NaNoGo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
