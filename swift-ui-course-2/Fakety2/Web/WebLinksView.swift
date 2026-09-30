//
//  WebLinksView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 19/02/25.
//

import SwiftUI

struct WebLinksView: View {
    @Environment(\.openURL) var openURL: OpenURLAction

    var body: some View {
        VStack {
            Link("Open link", destination: URL(string: "https://www.google.com")!)
                .padding([.bottom])
//                .buttonStyle(.bordered)
            Button("Open web") {
                let unencodedURLString = "https://www.bing.com"

                if let url = unencodedURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    openURL(URL(string: url)!)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding([.bottom])
            Button("Open incomplete") {
                let incompleteURLString = "www.facebook.com"

                var urlComponents = URLComponents(string: incompleteURLString)!
                urlComponents.scheme = "https"

                let completeURLString = urlComponents.string!

                if let url = completeURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    openURL(URL(string: url)!)
                }
            }
        }
        .padding()
    }
}

#Preview {
    WebLinksView()
}
