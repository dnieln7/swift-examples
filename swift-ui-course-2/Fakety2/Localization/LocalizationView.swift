//
//  LocalizationView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 17/01/25.
//

import SwiftUI

struct LocalizationView: View {
    @State private var text = LocalizedStringResource("Hello")
//    @State private var text = String(localized: "Hello")
    @State private var count = 0

    var body: some View {
        VStack {
            Text("This is an english text")
            Text(
                "Hello to \(Locale.current.identifier)",
                comment: "This is a welcome message" // Context for translators
            )
            Spacer()
            Text(text)
            Text("\(count) item")
            Button("Change greeting") {
                text = LocalizedStringResource("Bye")
//                text = String(localized: "Bye")
                count = count + 1
            }
        }
    }
}

#Preview {
    LocalizationView()
        .environment(\.locale, Locale(identifier: "es"))
//        .environment(\.layoutDirection, .leftToRight)
}
