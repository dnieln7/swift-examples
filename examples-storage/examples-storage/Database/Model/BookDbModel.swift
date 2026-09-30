//
//  BookDbModel.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 08/05/25.
//

import Foundation
import SwiftData

@Model
class BookDbModel: Identifiable {
    #Unique<BookDbModel>([\.title, \.year]) // This is heavy as a search it's done with every insert
    #Index<BookDbModel>([\.title, \.year]) // Indexing those fields increases performance
    
    @Attribute(.unique) var id: UUID
    var title: String
    // relationships are automatically created when a model references another model to customize it use the @Relationship macro
    @Relationship(deleteRule: .nullify, inverse: \AuthorDbModel.books)
    var author: AuthorDbModel?
    var coverUrl: String?
    var year: Int

    @Transient
    var displayYear: String {
        return year > 0 ? String(year) : "Unknown"
    }

   init(id: UUID, title: String, author: AuthorDbModel?, coverUrl: String? = nil, year: Int) {
        self.id = id
        self.title = title
        self.author = author
        self.coverUrl = coverUrl
        self.year = year
    }
}
