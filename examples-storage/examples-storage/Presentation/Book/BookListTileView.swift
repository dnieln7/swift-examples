//
//  BookListTileView.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 08/05/25.
//

import SwiftUI

struct BookListTileView: View {
    let book: BookDbModel

    var coverURL: URL?
    var author: String?

    init(book: BookDbModel) {
        self.book = book

        if let coverUrl = book.coverUrl {
            coverURL = URL(string: coverUrl)
        }

        if let author = book.author?.name {
            self.author = author
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(
                url: coverURL,
                content: {
                    image in
                    image.resizable()
                },
                placeholder: {
                    Color.blue
                }
            )
            .frame(width: 96, height: 120)
            .clipShape(.rect(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 12) {
                Text(book.title)
                    .font(.title2)
                Text(author ?? "No author")
                    .font(.body)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    let book = BookDbModel(
        id: UUID(),
        title: "Harry potter and the Sorcerer's stone",
        author: AuthorDbModel(id: UUID(), name: "J.K. Rowling", picture: nil, books: []),
        coverUrl: url,
        year: 1997
    )

    BookListTileView(book: book)
}

fileprivate let url = "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQlMPUYcyU4Qbv-ulofYB0K9GL_eHH0nFOwkXOeGR9flxTA8VRj"
