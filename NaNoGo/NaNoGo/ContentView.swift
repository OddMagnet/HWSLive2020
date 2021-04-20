//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("text") var text = ""

    var body: some View {
        NavigationView {
            TextEditor(text: $text)
                .navigationTitle("NaNoGo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
