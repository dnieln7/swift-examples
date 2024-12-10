//
//  ListActionsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 15/10/24.
//

import SwiftUI

struct ListActionsView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    var body: some View {
        List {
            ForEach(applicationData.books) { book in
                BookListTile(book: book)
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button(
                            role: .destructive,
                            action: {
                                removeBook(book: book)
                            },
                            label: {
                                Image(systemName: "trash")
                            }
                        )
                    }
            }
        }
        .refreshable {
            print("Refreshing...")
        }
    }

    func removeBook(book: Book) {
        var indexSet = IndexSet()

        if let index = applicationData.books.firstIndex(where: { $0.id == book.id }) {
            indexSet.insert(index)
        }

        applicationData.books.remove(atOffsets: indexSet)
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
    ListActionsView()
        .environment(ApplicationData())
}
