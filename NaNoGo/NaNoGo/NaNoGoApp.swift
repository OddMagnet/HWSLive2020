//
//  NaNoGoApp.swift
//  NaNoGo
//
//  Created by Michael Brünen on 20.04.21.
//

import SwiftUI
import UniformTypeIdentifiers

@main
struct NaNoGoApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TextFile()) { file in
            ContentView(document: file.$document)
        }
    }
}

struct TextFile: FileDocument {
    static var readableContentTypes = [UTType.plainText]

    var text = ""

    init(initialText: String = "") {
        text = initialText
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
