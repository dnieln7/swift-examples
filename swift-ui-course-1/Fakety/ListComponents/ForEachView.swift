//
//  ForEachView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 14/10/24.
//

import Observation
import SwiftUI

struct ForEachView: View {
    let cities: [String] = ["Paris", "Tortonto", "Dublin"]
    var data: BasicListData = BasicListData()

    var body: some View {
        VStack {
            ForEach(cities, id: \.self) { value in
                Text("Value: \(value)")
                Divider()
            }
            ForEach(data.userData, id: \.self) { book in
                HStack(alignment: .top) {
                    Image(book.cover)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 100)
                        .border(.black, width: 1)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(book.title)
                            .bold()
                        Text(book.author)
                        Text(book.displayYear)
                            .font(.caption)
                    }.padding(.top, 5)
                    Spacer()
                }
                Divider()
            }
            Spacer()
        }
    }
}

@Observable class BasicListData {
    var userData: [Book] = []

    init() {
        userData = [
            Book(title: "To Kill a Mockingbird", author: "Harper Lee", cover: "cover1.jpg", year: "1960", selected: false),
            Book(title: "1984", author: "George Orwell", cover: "cover2.jpg", year: "1949", selected: true),
            Book(title: "Pride and Prejudice", author: "Jane Austen", cover: "cover3.jpg", year: "1813", selected: false),
            Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien", cover: "lord_of_the_rings.jpg", year: "1954", selected: false),
            Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", cover: "hitchhikers_guide.jpg", year: "1979", selected: false),
        ]
    }
}

#Preview {
    ForEachView()
}
