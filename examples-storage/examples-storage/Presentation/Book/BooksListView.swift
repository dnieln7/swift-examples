//
//  BooksListView.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 09/05/25.
//

import SwiftData
import SwiftUI

struct BooksListView: View {
    @Environment(\.modelContext) var modelContext

    @Query private var books: [BookDbModel]

    init(sortOrder: SortOrder, title: String) {
        var predicate = #Predicate<BookDbModel> { _ in true }

        if !title.isEmpty {
            let titleLowercased = title.lowercased()
            predicate = #Predicate<BookDbModel> { book in
                book.title.localizedStandardContains(titleLowercased)
            }
        }

        _books = Query(filter: predicate, sort: \BookDbModel.year, order: sortOrder)
    }

    var body: some View {
        List(books) { book in
            BookListTileView(book: book)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(
                        role: .destructive,
                        action: {
                            modelContext.delete(book)
                            try? modelContext.save()
                        },
                        label: { Image(systemName: "trash") }
                    )
                }
        }
    }

    func getBooks(sortOrder:SortOrder, title: String) {
        let sort = SortDescriptor<BookDbModel>(\.title, order: sortOrder)
        var predicate = #Predicate<BookDbModel> { _ in true }

        if !title.isEmpty {
            let titleLowercased = title.lowercased()
            predicate = #Predicate<BookDbModel> { book in
                book.title.localizedStandardContains(titleLowercased)
            }
        }
        
        let fetch = FetchDescriptor(predicate: predicate, sortBy: [sort])
        let books = (try? modelContext.fetch(fetch)) ?? []
        
        for book in books {
            debugPrint("Title \(book.title)")
        }
    }
}

#Preview {
    BooksListView(sortOrder: .forward, title: "")
        .modelContainer(for: swiftDataModels, inMemory: true)
}
