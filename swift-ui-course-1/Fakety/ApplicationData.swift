//
//  ApplicationData.swift
//  Fakety
//
//  Created by Daniel Nolasco on 11/10/24.
//

import Observation
import SwiftUI

@Observable class ApplicationData {
    var string: String = "default"
    var books: [Book] = []
    var items: [MainItems] = []
    var listOfItems: [ConsumableItem] = []

    @ObservationIgnored var filteredBooks: [Book] = []
    var staticBooks: [Book] {
        didSet {
            filterBooks(query: "", searchScope: .title)
        }
    }

    init() {
        books = dataSet1
        items = dataSet2
        listOfItems = dataSet3
        staticBooks = dataSet1

        filterBooks(query: "", searchScope: .title)
    }

    func filterBooks(query: String, searchScope: SearchScope) {
        if query.isEmpty {
            filteredBooks = staticBooks.sorted(by: { $0.title < $1.title })
        } else {
            let newBooks: [Book] = switch searchScope {
            case .title:
                staticBooks.filter({
                    $0.title.localizedStandardContains(query)
                })
            case .author:
                staticBooks.filter({
                    $0.author.localizedStandardContains(query)
                })
            }

            filteredBooks = newBooks.sorted(by: { $0.title < $1.title })
        }
    }

    func filterBooksByAuthor(query: String, author: String) {
        if query.isEmpty {
            filteredBooks = staticBooks.sorted(by: { $0.title < $1.title })
        } else {
            let newBooks: [Book] = staticBooks.filter({
                var valid = true
                
                if !author.isEmpty && author != $0.author {
                    valid = false
                }
                
                if valid && !query.isEmpty && !$0.title.localizedStandardContains(query) {
                    valid = false
                }
                
                return valid
            })

            filteredBooks = newBooks.sorted(by: { $0.title < $1.title })
        }
    }
}

fileprivate var dataSet1: [Book] = [
    Book(title: "1984", author: "George Orwell", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1949", selected: false),
    Book(title: "To Kill a Mockingbird", author: "Harper Lee", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1960", selected: false),
    Book(title: "Pride and Prejudice", author: "Jane Austen", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1813", selected: false),
    Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1954", selected: false),
    Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1979", selected: false),
    Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1925", selected: false),
    Book(title: "The Catcher in the Rye", author: "J.D. Salinger", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1951", selected: false),
    Book(title: "Harry Potter and the Philosopher's Stone", author: "J.K. Rowling", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1997", selected: false),
    Book(title: "The Alchemist", author: "Paulo Coelho", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1988", selected: false),
    Book(title: "The Little Prince", author: "Antoine de Saint-Exupéry", cover: "https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png", year: "1943", selected: false),
]

fileprivate var dataSet2: [MainItems] = [
    MainItems(
        name: "Food",
        options: [
            MainItems(name: "Oatmeal", options: nil),
            MainItems(name: "Bagels", options: nil),
            MainItems(name: "Brownies", options: nil),
            MainItems(
                name: "Cheese",
                options: [
                    MainItems(name: "Roquefort", options: nil),
                    MainItems(name: "Mozzarella", options: nil),
                    MainItems(name: "Cheddar", options: nil),
                ]
            ),
            MainItems(name: "Cookies", options: nil),
            MainItems(name: "Donuts", options: nil),
        ]
    ),
    MainItems(
        name: "Beverages",
        options: [
            MainItems(name: "Coffee", options: nil),
            MainItems(name: "Juice", options: nil),
            MainItems(name: "Lemonade", options: nil),
        ]
    ),
]

fileprivate var dataSet3: [ConsumableItem] = [
    ConsumableItem(name: "Bagels", category: "Baked", calories: 250, included: false),
    ConsumableItem(name: "Borwnies", category: "Baked", calories: 466, included: false),
    ConsumableItem(name: "Butter", category: "Dairy", calories: 717, included: false),
    ConsumableItem(name: "Cheese", category: "Dairy", calories: 402, included: false),
    ConsumableItem(name: "Juice", category: "Beverages", calories: 23, included: false),
    ConsumableItem(name: "Lemonade", category: "Beverages", calories: 40, included: false),
]

struct Book: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var author: String
    var cover: String
    var year: String
    var selected: Bool

    var displayYear: String {
        String(year)
    }
}

enum SearchScope {
    case title
    case author
}

struct MainItems: Identifiable {
    var id: UUID = UUID()
    var name: String
    var options: [MainItems]?
}

struct ConsumableItem: Identifiable {
    let id: UUID = UUID()
    var name: String
    var category: String
    var calories: Int
    var included: Bool
}
