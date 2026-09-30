//
//  DocumentView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct DocumentView: View {
    
    @State private var showExporter: Bool = false
    @State private var showImporter: Bool = false
    
    @Binding var textDocument: TextDocument
    
    var body: some View {
        NavigationStack {
            GroupBox("Editor") {
                TextEditor(text: $textDocument.content)
            }
            .padding()
            .navigationTitle("New Document")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(
                        action: {
                            showImporter = true
                        },
                        label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                    )
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        action: {
                            showExporter = true
                        },
                        label: {
                         Image(systemName: "square.and.arrow.up")
                        }
                    )
                }
            }
            .fileExporter(
                isPresented:$showExporter,
                document: textDocument,
                contentType: .plainText,
                defaultFilename: "New Document",
                onCompletion: { result in
                    debugPrint("result: \(result)")
                }
            )
            .fileImporter(
                isPresented: $showImporter,
                allowedContentTypes: [.plainText],
                onCompletion: { result in
                    if let fileURL = try? result.get() {
                        if fileURL.startAccessingSecurityScopedResource() {
                            if let data = try? Data(contentsOf: fileURL) {
                                if let text = String(data: data, encoding: .utf8) {
                                    textDocument.content = text
                                }
                            }
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    @Previewable @State var textDocument: TextDocument = TextDocument()
    
//    DocumentView(textDocument: .constant(TextDocument()))
    DocumentView(textDocument: $textDocument)
}
