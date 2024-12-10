//
//  AsyncImagesView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 30/10/24.
//

import SwiftUI

struct AsyncImagesView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            AsyncImage(
                url: URL(string: url),
                content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                },
                placeholder: { Color.red }
            )
            .frame(width: 200, height: 200) // required for the placeholder to be the same size
        }
    }
}

#Preview {
    AsyncImagesView()
}

fileprivate let url: String = "https://w7.pngwing.com/pngs/115/547/png-transparent-pink-haired-girl-anime-character-illustration-astolfo-discord-fate-grand-order-emoji-resetera-astolfo-mammal-face-destiny-thumbnail.png"
