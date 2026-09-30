//
//  AuthorBooksView.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 12/05/25.
//

import SwiftData
import SwiftUI

struct AuthorBooksView: View {
    @Query(sort: \AuthorDbModel.name, order: .forward) private var authors: [AuthorDbModel]

    var body: some View {
        List {
            ForEach(authors) { author in
                Section(author.name) {
                    ForEach(author.books) { book in
                        Text("\(book.title) - \(book.year)")
                    }
                }
                .headerProminence(.increased)
            }
            .id(UUID()) // SwiftUI does not update the views under a ForEach when the relationship proiperty is updated, using a new random value it forces to reset and update
        }
    }
}

#Preview(traits: .modifier(PreviewFakeData())) {
    AuthorBooksView()
}
