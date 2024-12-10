//
//  NavigationSplitDouble.swift
//  Fakety
//
//  Created by Daniel Nolasco on 28/10/24.
//

import SwiftUI

struct NavigationSplitDouble: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    @State private var selectedBook: Book? = nil
    @State private var visibility: NavigationSplitViewVisibility = .automatic

    var body: some View {
        NavigationSplitView(
            columnVisibility: $visibility,
            sidebar: {
                BooksList(selectedBook: $selectedBook)
            },
            detail: {
                if let book = selectedBook {
                    BookDetailView(book: book)
                } else {
                    BookDetailPlaceHolderView()
                }
            }
        )
        .onAppear {
            if let book = applicationData.books.first {
                selectedBook = book
            }
        }
    }
}

fileprivate struct BooksList: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData
    @Binding var selectedBook: Book?

    var body: some View {
        NavigationStack {
            List(applicationData.books, selection: $selectedBook) { book in
                NavigationLink(
                    value: book,
                    label: {
                        Text(book.title)
                    }
                )
            }
            .listStyle(.sidebar)
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        value: 1,
                        label: {
                            Image(systemName: "gear")
                        }
                    )
                    .isDetailLink(false) // If true it will open on the detail side
                }
            }
            .navigationDestination(for: Int.self) { _ in
                VStack {
                    Text("New side bar")
                }
            }
        }
    }
}

fileprivate struct BookDetailPlaceHolderView: View {
    // Can also be in the UniversalInterfaceView and have it updated in the onChange of every new selectedBook update
    @State private var navigationPath: NavigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Spacer()
                Text("Select a book")
                    .font(.largeTitle)
                    .onTapGesture {
                        navigationPath.append("toggle")
                    }
                Spacer()
            }
            .navigationTitle("Placeholder")
        }
        .navigationDestination(for: String.self) { _ in
            ToggleSliderView()
                .navigationTitle("Toggle")
        }
    }
}

#Preview {
    NavigationSplitDouble()
        .environment(ApplicationData())
}
