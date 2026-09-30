//
//  AuthorDbModel.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 08/05/25.
//

import SwiftUI
import SwiftData

@Model
class AuthorDbModel: Identifiable {
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String
    @Attribute(.externalStorage)
    var picture: Data?
    @Relationship(deleteRule: .nullify)
    var books: [BookDbModel]

    var displayPicture: UIImage? {
        if let data = picture, let image = UIImage(data: data) {
            return image
        }

        return nil
    }

    init(id: UUID, name: String, picture: Data?, books: [BookDbModel]) {
        self.id = id
        self.name = name
        self.picture = picture
        self.books = books
    }
}
