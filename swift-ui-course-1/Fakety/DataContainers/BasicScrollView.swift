//
//  BasicScrollView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 14/10/24.
//

import SwiftUI

struct BasicScrollView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    @State private var bookID: Book.ID? = nil

    var body: some View {
        ScrollViewReader { _ in
            VStack {
                Text("Scrolled ID: \(bookID?.uuidString ?? "")")
                ScrollView {
                    LazyVStack {
                        ForEach(applicationData.books) { book in
                            GenericBookListTile(book: book)
                        }
                    }
                    .scrollTargetLayout()
                }
//                .scrollDismissesKeyboard(.immediately)
//                .scrollIndicatorsFlash(onAppear: false) // Show the scroll bar when the view appears
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $bookID)
            }
        }
    }
}

#Preview {
    BasicScrollView()
        .environment(ApplicationData())
}
