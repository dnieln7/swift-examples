//
//  ContentView.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 05/05/25.
//

import SwiftData
import SwiftUI

private let expression = #Expression<Int, Bool> { year in
    year >= 2000
}

struct BooksView: View {
    @Environment(\.modelContext) var modelContext

//    @Query(
//        sort: [
//            SortDescriptor(\BookDbModel.title, order: .forward),
//            SortDescriptor(\BookDbModel.year, order: .forward),
//        ]
//    )
//    var books: [BookDbModel]

//    @Query(
    ////        filter: #Predicate<BookDbModel> { $0.year >= 2000 },
//        filter: #Predicate<BookDbModel> { expression.evaluate($0.year) },
//    )
//    var books: [BookDbModel]

    @State private var navigationPath: NavigationPath = NavigationPath()
    @State private var sortOrder: SortOrder = .forward
    @State private var searchText: String = ""
    @State private var viewSectioned: Bool = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                HStack(alignment: .center, spacing: 20) {
                    NavigationLink(
                        value: "add_author",
                        label: {
                            Label("Author", systemImage: "plus")
                        }
                    )
                    .buttonStyle(.bordered)
                    NavigationLink(
                        value: "add_book",
                        label: {
                            Label("Book", systemImage: "plus")
                        }
                    )
                    .buttonStyle(.bordered)
                    NavigationLink(
                        value: "add_user",
                        label: {
                            Label("User", systemImage: "plus")
                        }
                    )
                    .buttonStyle(.bordered)
                }
                .padding()
                HStack {
                    Button(sortOrder == .forward ? "Sorted forward" : "Sorted reversed") {
                        sortOrder = sortOrder == .forward ? .reverse : .forward
                    }
                    .buttonStyle(.borderedProminent)
                    Button(viewSectioned ? "Normal Style" : "Sectioned Style") {
                        viewSectioned = viewSectioned ? false : true
                    }
                    .buttonStyle(.borderedProminent)
                }
                if viewSectioned {
                    AuthorBooksView()
                }else {
                    BooksListView(sortOrder: sortOrder, title: searchText)
                }
            }
            .searchable(text: $searchText, prompt: "Search by title")
            .navigationTitle("Books")
            .navigationDestination(for: String.self) { destination in
                if destination == "add_book" {
                    AddBookView(navigationPath: $navigationPath)
                }
                if destination == "add_author" {
                    AddAuthorView(navigationPath: $navigationPath)
                }
                if destination == "add_user" {
                    AddUserView(navigationPath: $navigationPath)
                }
            }
        }
    }
}

#Preview {
    BooksView()
        .modelContainer(for: swiftDataModels, inMemory: true)
}
