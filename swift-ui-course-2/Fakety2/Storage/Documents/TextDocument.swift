//
//  TextDocument.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct TextDocument: FileDocument {
    static let readableContentTypes: [UTType] = [.plainText]

    var content: String

    // Init from a new document
    init() {
        content = ""
    }

    // Init from an existing document
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            if let text = String(data: data, encoding: .utf8) {
                content = text
            } else {
                throw CocoaError(.fileReadCorruptFile)
            }
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    // Write to document
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = content.data(using: .utf8)!
        let fileWrapper = FileWrapper(regularFileWithContents: data)
        
        return fileWrapper
    }
}
