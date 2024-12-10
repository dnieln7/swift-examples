//
//  GenericBookListTile.swift
//  Fakety
//
//  Created by Daniel Nolasco on 24/10/24.
//

import Foundation
import SwiftUI

struct GenericBookListTile: View {
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
