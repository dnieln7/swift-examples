//
//  examples_storageApp.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 05/05/25.
//

import SwiftData
import SwiftUI

let swiftDataModels: [any PersistentModel.Type] = [BookDbModel.self, AuthorDbModel.self, UserDbModel.self]

@main
struct ExamplesStorageApp: App {
    var body: some Scene {
        WindowGroup {
            BooksView()
                .modelContainer(for: swiftDataModels)
        }
    }
}

struct PreviewFakeData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(
            for: BookDbModel.self, AuthorDbModel.self, UserDbModel.self,
            configurations: modelConfiguration
        )
        
        let user = UserDbModel(id: UUID(), name: "Daniel", userInfo: nil, userInfo2: nil)
        modelContainer.mainContext.insert(user)
        
        let author = AuthorDbModel(id: UUID(), name: "Stephen King", picture: nil, books: [])
        modelContainer.mainContext.insert(author)
        
        let book1 = BookDbModel(id: UUID(), title: "Carrie", author: nil, year: 1999)
        let book2 = BookDbModel(id: UUID(), title: "The Shining", author: author, year: 1977)
        modelContainer.mainContext.insert(book1)
        modelContainer.mainContext.insert(book2)
        
        return modelContainer
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}
