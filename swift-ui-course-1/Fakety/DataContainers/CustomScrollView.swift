//
//  CustomScrollView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 10/12/24.
//

import SwiftUI

struct CustomScrollView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    @State private var title: String = ""
    @State private var bookID: Book.ID? = nil

    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Text(getCurrentTitle())
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(applicationData.books) { book in
                            BookPageTile(book: book)
                                // adjusts the size of the view to the horizontal size of it's container
//                                .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
                                .containerRelativeFrame(.horizontal)
                                // Custom scroll effect
                                .scrollTransition(axis: .horizontal) { effect, phase in
                                    effect
                                        .opacity(phase.isIdentity ? 1 : 0)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.5)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $bookID)
                Button("To first") {
                    if let firstID = applicationData.books.first?.id {
                        withAnimation {
                            proxy.scrollTo(firstID)
                        }
                        bookID = firstID
                    }
                }
                .buttonStyle(.bordered)
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

fileprivate struct BookPageTile: View {
    let book: Book

    var body: some View {
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

#Preview {
    CustomScrollView()
        .environment(ApplicationData())
}
