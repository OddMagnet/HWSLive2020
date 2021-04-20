//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("text") private var text = "programming..."
    @State private var fontSize: CGFloat = 16

    var body: some View {
        NavigationView {
            TextEditor(text: $text)
                .font(.system(size: fontSize, weight: .semibold, design: .monospaced))
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Stepper("\(fontSize, specifier: "%0.f")", value: $fontSize)
                                .font(.title2)
//                                .labelsHidden()   // needs a better way to inform user what stepper does
                        }
                    }
                }
                .navigationTitle("NaNoGo")
        }
        .navigationViewStyle(StackNavigationViewStyle())    // force iPadOS to give all the space to the editor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
