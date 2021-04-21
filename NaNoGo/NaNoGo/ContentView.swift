//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
//    @SceneStorage("text") private var text = "programming..."
    @Binding var document: TextFile
    @AppStorage("fontSize") private var fontSize = 16
    @State private var backgroundColor: Color
    @State private var foregroundColor: Color
    @State private var wordCount: Int = 0

    init(document: Binding<TextFile>) {
        let background = UserDefaults.standard.color(forKey: "background") ?? .white
        let foreground = UserDefaults.standard.color(forKey: "foreground") ?? .black

        _backgroundColor = State(wrappedValue: background)
        _foregroundColor = State(wrappedValue: foreground)
        _document = document
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Words: \(wordCount, specifier: "% 3d")")
                        .font(.system(size: 17, weight: .bold, design: .monospaced))

                    ProgressView("", value: min(500, Double(wordCount)), total: 500)
                        .offset(y: -8.0)
                }
                .padding()

                TextEditor(text: $document.text)
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
            wordCount = document.text.components(separatedBy: .whitespacesAndNewlines).filter { $0.isEmpty == false }.count
        }
        .onChange(of: backgroundColor) { value in
            UserDefaults.standard.set(value, forKey: "background")
        }
        .onChange(of: foregroundColor) { value in
            UserDefaults.standard.set(value, forKey: "foreground")
        }
        .onChange(of: document.text) { value in
            wordCount = value.components(separatedBy: .whitespacesAndNewlines).filter { $0.isEmpty == false }.count
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(TextFile(initialText: "programming...")))
    }
}
