//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""

    var body: some View {
        NavigationView {
            TextEditor(text: $text)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .navigationTitle("NaNoGo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
