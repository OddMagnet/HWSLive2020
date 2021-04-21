//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("text") private var text = "programming..."
    @AppStorage("fontSize") private var fontSize = 16
    @State private var backgroundColor: Color
    @State private var foregroundColor: Color

    init() {
        let background = UserDefaults.standard.color(forKey: "background") ?? .white
        let foreground = UserDefaults.standard.color(forKey: "foreground") ?? .black

        _backgroundColor = State(wrappedValue: background)
        _foregroundColor = State(wrappedValue: foreground)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                    .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .monospaced))
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        // Background color
                        ColorPicker("Back", selection: $backgroundColor)
                            .fixedSize()

                        // Foreground color
                        ColorPicker("Fore", selection: $foregroundColor)
                            .fixedSize()

                        // FontSize
                        Stepper("\(fontSize, specifier: "%0.f")", value: $fontSize)
                            .font(.title2)
                        .labelsHidden()   // needs a better way to inform user what stepper does
                    }
                }
            }
            .navigationTitle("NaNoGo")
        }
        .navigationViewStyle(StackNavigationViewStyle())    // force iPadOS to give all the space to the editor
        .onAppear {
            UITextView.appearance().backgroundColor = UIColor(backgroundColor)
            UITextView.appearance().textColor = UIColor(foregroundColor)
        }
        .onChange(of: backgroundColor) { value in
            UserDefaults.standard.set(value, forKey: "background")
        }
        .onChange(of: foregroundColor) { value in
            UserDefaults.standard.set(value, forKey: "foreground")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
