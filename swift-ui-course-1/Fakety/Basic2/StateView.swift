//
//  StateView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 09/10/24.
//

import SwiftUI

struct StateView: View {
    @State private var title: String = "Default"
    @State private var isValid: Bool = true
    @State private var text: String = ""

    var body: some View {
        VStack {
            Text(isValid ? "valid" : "no valid")
            HeaderView(title: title, text: $text)
            Button(
                action: {
                    isValid.toggle()
                    title = text
//                    title = "New title: \(Int.random(in: 1 ... 100))"
                },
                label: { Text("Change") }
            )
            Spacer()
        }
    }
}

struct HeaderView: View {
    var title: String
    
    // Pass a reference to a state property
    @Binding var text: String

    var body: some View {
        VStack {
            Text(title)
                .padding()
            TextField("write here", text: $text)
                .padding()
                .border(.black, width: 2)
                .padding()
        }
    }
}

#Preview {
    StateView()
}
