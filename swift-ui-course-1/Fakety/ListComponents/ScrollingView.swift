//
//  ScrollingView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 14/10/24.
//

import SwiftUI

struct ScrollingView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    @State private var title: String = ""
    @State private var bookID: Book.ID? = nil

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Text(String(describing: bookID))
                ScrollView {
                    LazyVStack {
                        ForEach(applicationData.books) { book in
                            BookListTile(book: book, verticalMode: true)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $bookID)
            }
        }
    }

    func getCurrentTitle() -> String {
        var title = "Unknown"

        if let book = applicationData.books.first(where: { $0.id == bookID }) {
            title = book.title
        } else if !applicationData.books.isEmpty {
            title = applicationData.books[0].title
        }

        return title
    }
}

struct VerticalScroll: View {
    private let books: [Book]

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(books) { book in
                    BookListTile(book: book, verticalMode: true)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .scrollIndicatorsFlash(onAppear: false) // Show the scroll bar when the view appears
    }
}

fileprivate struct BookListTile: View {
    let book: Book
    let verticalMode: Bool

    var body: some View {
        if verticalMode {
            Group {
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
                    .border(.black, width: 1)
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
                .padding([.leading, .trailing], 10)
                .padding([.top, .bottom], 5)
                Divider()
            }
        } else {
            Group {
                VStack {
                    AsyncImage(
                        url: URL(string: book.cover),
                        content: { image in
                            image.resizable()
                        },
                        placeholder: { Color.white }
                    )
                    .scaledToFit()
                    Text(book.title)
                        .bold()
                    Text(book.author)
                    Text(book.displayYear)
                        .font(.caption)
                }
                .padding(10)
            }
        }
    }
}

#Preview {
    ScrollingView()
        .environment(ApplicationData())
}
