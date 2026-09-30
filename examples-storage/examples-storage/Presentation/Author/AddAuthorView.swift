//
//  AddAuthorView.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 08/05/25.
//

import SwiftData
import SwiftUI

struct AddAuthorView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var authors: [AuthorDbModel]

    @State private var name: String = ""

    @State private var isEditing: Bool = false
    @State private var editingAuthor: AuthorDbModel? = nil

    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            TextField("Insert name", text: $name)
                .textFieldStyle(.roundedBorder)
            Button(isEditing ? "Update" : "Save") {
                if isEditing {
                    updateAuthor()
                } else {
                    saveAuthor()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding([.top])
            List(authors) { author in
                HStack {
                    if let picture = author.displayPicture {
                        Image(uiImage: picture)
                    }
                    Text("\(author.name) - \(author.books.count) books")
                }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button("Edit") {
                            isEditing = true
                            editingAuthor = author
                            name = author.name
                        }
                        .tint(.blue)
                    }
            }
            .padding([.top])
        }
        .padding()
        .navigationTitle("Add Author")
    }

    private func saveAuthor() {
        let name = name.trimmingCharacters(in: .whitespaces)

        guard !name.isEmpty else { return }
        
        let picture = UIImage(systemName: "person")?.pngData()

        let newAuthor = AuthorDbModel(id: UUID(), name: name, picture: picture, books: [])

        modelContext.insert(newAuthor)
        try? modelContext.save()
        
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    private func updateAuthor() {
        guard let editingAuthor else { return }

        editingAuthor.name = name

        try? modelContext.save()

        isEditing = false
        self.editingAuthor = nil
        name = ""
    }
}

#Preview(traits: .modifier(PreviewFakeData())) {
    @Previewable @State var navigationPath: NavigationPath = NavigationPath()

    AddAuthorView(
        navigationPath: $navigationPath
    )
}
