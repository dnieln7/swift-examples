//
//  ListOutlinedView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 15/10/24.
//

import SwiftUI

struct ListOutlinedView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    var body: some View {
//        List(applicationData.items, children: \.options) { item in
//            Text(item.name)
//        }
        List {
            ForEach(applicationData.items) { item in
                Section(header: Text(item.name)) {
                    OutlineGroup(item.options ?? [], children: \.options) { option in
                        Text(option.name)
                    }
                }
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
    ListOutlinedView()
        .environment(ApplicationData())
}
