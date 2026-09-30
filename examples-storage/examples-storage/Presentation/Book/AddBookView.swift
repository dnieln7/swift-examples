//
//  AddBookView.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 08/05/25.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
  @Environment(\.modelContext) private var modelContext

  @Query private var authors: [AuthorDbModel]

  @State private var title: String = ""
  @State private var selectedAuthor: AuthorDbModel? = nil
  @State private var coverUrl: String = ""
  @State private var year: String = ""

  @Binding var navigationPath: NavigationPath

  var body: some View {
    VStack(alignment: .center, spacing: 12) {
      TextField("Insert title", text: $title)
        .textFieldStyle(.roundedBorder)
      List(authors) { author in
        HStack {
          if selectedAuthor == author {
            Image(systemName: "checkmark")
              .padding([.trailing])
          }
          Text(author.name)
        }
        .onTapGesture {
          selectedAuthor = author
        }
      }
      .frame(height: 100)
      .listStyle(.inset)
      TextField("Insert cover url", text: $coverUrl)
        .textFieldStyle(.roundedBorder)
      TextField("Insert year", text: $year)
        .keyboardType(.numberPad)
        .textFieldStyle(.roundedBorder)
      Button("Save") { saveBook() }
        .buttonStyle(.borderedProminent)
        .padding([.top])
      Spacer()
    }
    .padding()
    .navigationTitle("Add Book")
  }

  private func saveBook() {
    let title = title.trimmingCharacters(in: .whitespaces)
    let coverUrl = coverUrl.trimmingCharacters(in: .whitespaces)
    let year = year.trimmingCharacters(in: .whitespaces)

    guard !title.isEmpty, selectedAuthor != nil, let yearInt = Int(year) else {
      return
    }

    var coverUrlNullable: String?

    if !coverUrl.isEmpty {
      coverUrlNullable = coverUrl
    }

    let newBook = BookDbModel(
      id: UUID(),
      title: title,
      author: selectedAuthor,
      coverUrl: coverUrlNullable,
      year: yearInt
    )

    modelContext.insert(newBook)
    try? modelContext.save()
    navigationPath.removeLast()
  }
}

#Preview {
  @Previewable @State var navigationPath: NavigationPath = NavigationPath()

  AddBookView(
    navigationPath: $navigationPath
  )
  .modelContainer(for: swiftDataModels, inMemory: true)
}
