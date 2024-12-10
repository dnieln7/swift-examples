//
//  ListSectionsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 15/10/24.
//

import SwiftUI

struct ListSectionsView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    // returns array of tuples like:
    // a to [book1, book2...]
    // b to [book1, book2...]
    var orderBooks: [(key: String, value: [Book])] {
        let charToBooks: Dictionary<String, [Book]> = Dictionary(grouping: applicationData.books, by: { book in
            let index = book.title.startIndex
            let firstChar = book.title[index]

            return String(firstChar)
        })

        return charToBooks.sorted(
            by: { charToBook1, charToBook2 in
                charToBook1.key < charToBook2.key
            }
        )
    }

    var body: some View {
        BasicSections(books: applicationData.books)
    }
}

struct BasicSections: View {
    let books: [Book]

    var body: some View {
        List {
            Section(header: Text("Statistics") /* , footer: Text("footer") */ ) {
                HStack {
                    Text("Total books")
                    Spacer()
                    Text(String(books.count))
                }
            }
            .headerProminence(.increased) // Use bold text
            //            .listSectionSeparator(.hidden, edges: .top)
            //            .listSectionSeparatorTint(.blue)
            Section(header: Text("My Books")) {
                ForEach(books) { book in
                    BookListTile(book: book)
                }
            }
            .headerProminence(.increased)
            //            .listSectionSeparator(.hidden)
        }
        .environment(\.defaultMinListRowHeight, 100)
        //        .listStyle(.plain)
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
    ListSectionsView()
        .environment(ApplicationData())
}
