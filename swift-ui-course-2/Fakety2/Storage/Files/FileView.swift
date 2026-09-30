//
//  FileView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct FileView: View {
    @State private var content: String = ""

    let fileName: String

    var body: some View {
        VStack {
            Text(content)
                .font(.body)
                .padding()
            Spacer()
        }
        .navigationTitle(fileName)
        .task {
            content = await DummyFileManager.shared.load(name: fileName) ?? "No content"
        }
    }
}

#Preview {
    FileView(fileName: "Test")
}
