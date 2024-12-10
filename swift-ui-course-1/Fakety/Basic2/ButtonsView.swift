//
//  ButtonsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 10/10/24.
//

import SwiftUI

struct ButtonsView: View {
    @State private var withColor: Bool = false

    var body: some View {
        VStack {
            Button("Toggle color", action: changeColor)
                .buttonStyle(JumpStyle())
//                .buttonStyle(.borderedProminent)
//                .disabled(true)
            if withColor {
                Text("Using color!")
            }
            Button(
                role: .destructive,
                action: removeColor,
                label: {
                    HStack {
                        Image(systemName: "trash")
                            .imageScale(.large)
                        Text("Remove color")
                    }
                }
            )
            .buttonStyle(.bordered)
            .controlSize(.large)
            Spacer()
        }.background(withColor ? .yellow : .clear)
    }

    func changeColor() {
        withColor.toggle()
    }

    func removeColor() {
        withColor = false
    }
}

struct JumpStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed

        return configuration.label
            .padding()
            .border(.green, width: 5)
            .scaleEffect(pressed ? 1.5 : 1.0)
    }
}

#Preview {
    ButtonsView()
}
