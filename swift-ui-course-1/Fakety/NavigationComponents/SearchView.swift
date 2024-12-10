//
//  SearchView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 22/10/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    @State private var searchScope: SearchScope = .title
    @State private var searchTokens: [SearchToken] = []
    @State private var query: String = ""

    var body: some View {
        NavigationStack {
            List(applicationData.filteredBooks) { book in
                BookListTile(book: book)
            }
            .navigationTitle("Books")
            .toolbar {
                // Search token
                let authors = applicationData.staticBooks.map({ $0.author })
                let authorsSet = Set(authors).sorted()
                
                Menu(
                    content: {
                        ForEach(authorsSet, id: \.self) { author in
                            Button(author) {
                                searchTokens = [SearchToken(name: author)]
                            }
                        }
                    },
                    label: {
                        Image(systemName: "pencil.circle")
                    }
                )
            }
//            CustomSearch()
//                .navigationTitle("Books")
        }
//        .searchable(
//            text: $query,
//            placement: .navigationBarDrawer(displayMode: .always),
//            prompt: Text("Search by title")
//        )
        .searchable(
            // Search token
            text: $query,
            tokens: $searchTokens,
            token: { token in
                Text(token.name)
            }
        )
//        .searchScopes($searchScope) {
//            Text("Title").tag(SearchScope.title)
//            Text("Author").tag(SearchScope.author)
//        }
//        .searchSuggestions({
//            ForEach(applicationData.filteredBooks) { book in
//                Text("\(book.title) - \(book.author)")
//                    .searchCompletion(book.title)
//            }
//        })
//        .onSubmit(of: .search) {
//            let sanitizedQuery = query.trimmingCharacters(in: .whitespaces)
//            applicationData.filterBooks(query: sanitizedQuery, searchScope: searchScope)
//        }
//        .onChange(of: query, initial: false) { _, new in
//            let sanitizedQuery = new.trimmingCharacters(in: .whitespaces)
//            applicationData.filterBooks(query: sanitizedQuery, searchScope: searchScope)
//        }
        .onChange(of: query, initial: false) { _, new in
            // Search token
            let sanitizedQuery = new.trimmingCharacters(in: .whitespaces)
            applicationData.filterBooksByAuthor(
                query: sanitizedQuery,
                author: searchTokens.first?.name ?? ""
            )
        }
        .onChange(of: searchScope) { _, _ in
            // Search token
            let sanitizedQuery = query.trimmingCharacters(in: .whitespaces)
            applicationData.filterBooksByAuthor(
                query: sanitizedQuery,
                author: searchTokens.first?.name ?? ""
            )
        }
    }
}

fileprivate struct SearchToken: Identifiable, Equatable {
    let id: UUID = UUID()
    let name: String
}

fileprivate struct CustomSearch: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch: DismissSearchAction

    var body: some View {
        List {
            if isSearching {
                Button("Dismiss") {
                    dismissSearch()
                }
            }
            ForEach(applicationData.filteredBooks) { book in
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
    SearchView()
        .environment(ApplicationData())
}
