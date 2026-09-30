//
//  NewFileSheetView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct NewFileSheetView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction

    @State private var name: String = ""
    @State private var content: String = ""

    var body: some View {
        VStack {
            Text("Create a new file")
                .font(.headline)
                .padding([.bottom])
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding([.trailing, .leading])
            TextField("Content", text: $content)
                .textFieldStyle(.roundedBorder)
                .padding([.trailing, .leading, .bottom])
            HStack {
                Spacer()
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding([.trailing])
                Button("Create") {
                    if !name.isEmpty || !content.isEmpty {
                        DummyFileManager.shared.save(name: name, content: content)
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    NewFileSheetView()
}
