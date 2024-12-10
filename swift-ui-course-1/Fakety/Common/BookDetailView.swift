//
//  BookDetailView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 28/10/24.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let book: Book

    var body: some View {
        if horizontalSizeClass == .regular {
            // Portrait
            HStack {
                VStack {
                    Text("ID: \(book.id)")
                        .multilineTextAlignment(.center)
                        .padding()
                    Text("Author: \(book.author)")
                        .multilineTextAlignment(.center)
                        .padding()
                }
                VStack {
                    Text("Year: \(book.year)")
                        .padding()
                    Text("Selected: \(book.selected)")
                        .padding()
                }
            }
            .navigationTitle(book.title)
        } else {
            // Landscape
            VStack {
                Text("ID: \(book.id)")
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Author: \(book.author)")
                    .multilineTextAlignment(.center)
                    .padding()
                Text("Year: \(book.year)")
                    .padding()
                Text("Selected: \(book.selected)")
                    .padding()
            }
            .navigationTitle(book.title)
        }
    }
}

#Preview {
    BookDetailView(
        book: Book(
            title: "1984",
            author: "George Orwell",
            cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png",
            year: "1949",
            selected: false
        )
    )
}
