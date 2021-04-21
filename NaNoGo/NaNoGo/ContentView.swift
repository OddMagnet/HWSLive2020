//
//  ContentView.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("text") var text = ""
    @AppStorage("fontSize") private var fontSize = 17
    @State private var backgroundColor: Color
    @State private var foregroundColor: Color

    init() {
        let bg = UserDefaults.standard.color(forKey: "Background") ?? .white
        let fg = UserDefaults.standard.color(forKey: "Foreground") ?? .black

        _backgroundColor = State(wrappedValue: bg)
        _foregroundColor = State(wrappedValue: fg)
    }

    var body: some View {
        NavigationView {
            TextEditor(text: $text)
                .font(.system(size: CGFloat(fontSize)))
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Stepper("Font size", value: $fontSize)
                                .labelsHidden()
                            ColorPicker("BG", selection: $backgroundColor)
                                .fixedSize()
                            ColorPicker("FG", selection: $foregroundColor)
                                .fixedSize()
                        }
                    }
                }
                .navigationTitle("NaNoGo")
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onChange(of: backgroundColor) { value in
            UserDefaults.standard.set(value, forKey: "Background")
        }
        .onChange(of: foregroundColor) { value in
            UserDefaults.standard.set(value, forKey: "Foreground")
        }
    }
}

extension UserDefaults {
    func set(_ value: Color, forKey key: String) {
        let color = UIColor(value)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        UserDefaults.standard.set(red, forKey: "\(key)Red")
        UserDefaults.standard.set(green, forKey: "\(key)Green")
        UserDefaults.standard.set(blue, forKey: "\(key)Blue")
        UserDefaults.standard.set(alpha, forKey: "\(key)Alpha")
        UserDefaults.standard.set(true, forKey: key)
    }

    func color(forKey key: String) -> Color? {
        if UserDefaults.standard.bool(forKey: key) {
            let red = UserDefaults.standard.double(forKey: "\(key)Red")
            let green = UserDefaults.standard.double(forKey: "\(key)Green")
            let blue = UserDefaults.standard.double(forKey: "\(key)Blue")
            let alpha = UserDefaults.standard.double(forKey: "\(key)Alpha")
            return Color(red: red, green: green, blue: blue, opacity: alpha)
        } else {
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
