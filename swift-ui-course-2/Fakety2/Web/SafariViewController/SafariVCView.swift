//
//  SafariVCView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 20/02/25.
//

import SwiftUI

struct SafariVCView: View {
    @State private var searchURL = URL(string: "https://www.google.com")!
    @State private var hasOpened = false
    @State private var showSheet = false

    var body: some View {
        VStack {
            if hasOpened {
                Text("Browser was opened")
            }
            Button("Open in app browser") {
                showSheet = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .sheet(isPresented: $showSheet) {
            SafariBrowser(searchURL: $searchURL, hasOpened: $hasOpened)
        }
    }
}

#Preview {
    SafariVCView()
}
