//
//  LazyGridView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 14/10/24.
//

import SwiftUI

struct LazyGridView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    private let guides: [GridItem] = [
        GridItem(GridItem.Size.flexible(minimum: 75), alignment: .center),
        GridItem(GridItem.Size.flexible(minimum: 75), alignment: .center),
        GridItem(GridItem.Size.flexible(minimum: 75), alignment: .center),
    ]
    
    private let guidesAdaptive: [GridItem] = [
        GridItem(GridItem.Size.adaptive(minimum: 150)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: guidesAdaptive) {
                ForEach(applicationData.books) { book in
                    AsyncImage(
                        url: URL(string: book.cover),
                        content: { image in
                            image.resizable()
                        },
                        placeholder: { Color.white }
                    )
                    .scaledToFit()
//                    .frame(width: 75, height: 75)
                    .border(.black, width: 1)
                }
            }
        }
    }
}

#Preview {
    LazyGridView()
        .environment(ApplicationData())
}
