//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("text") private var text = "programming..."

    var body: some View {
        NavigationView {
            TextEditor(text: $text)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
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
