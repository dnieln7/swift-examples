//
//  BasicListView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 15/10/24.
//

import SwiftUI

struct BasicListView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    var body: some View {
        List(applicationData.books) { book in
            let index = applicationData.books.firstIndex(where: { $0.id == book.id }) ?? 0

            BookListTile(book: book)
                .listRowBackground(
                    index % 2 == 0 ? Color.white : Color.gray
                )
                .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
    }
}

struct MixedList: View {
    let books: [Book]

    var body: some View {
        List {
            HStack {
                Image(systemName: "book.circle")
                    .font(.largeTitle)
                Spacer()
                Text("My favorite books")
                    .font(.headline)
            }
            .frame(height: 50)
            ForEach(books) { book in
                BookListTile(book: book)
            }
        }
    }
}

fileprivate struct BookListTile: View {
    let book: Book

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(
                url: URL(string: book.cover),
                content: { image in
                    image.resizable()
                },
                placeholder: { Color.white }
            )
            .scaledToFit()
            .frame(width: 80, height: 100)
            VStack(alignment: .leading, spacing: 2) {
                Text(book.title)
                    .bold()
                Text(book.author)
                Text(book.displayYear)
                    .font(.caption)
            }
            .padding(.top, 5)
            Spacer()
        }
    }
}

#Preview {
    BasicListView()
        .environment(ApplicationData())
}
