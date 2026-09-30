//
//  NavigationButtonView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 05/05/25.
//

import SwiftUI

struct NavigationButtonView<Destination: View>: View {
    let text: String
    let destination: () -> Destination

    init(_ text: String, destination: @escaping () -> Destination) {
        self.text = text
        self.destination = destination
    }

    var body: some View {
        NavigationLink(
            destination: destination,
            label: { Text(text) }
        )
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    NavigationButtonView("Navigate") {
        Text("Hello")
    }
}
