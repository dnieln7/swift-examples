//
//  EventsAndCustomModifiersView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 07/10/24.
//

import SwiftUI

struct EventsAndCustomModifiersView: View {
    var body: some View {
        VStack {
            Text("on Appear")
                .onAppear(
                    perform: {
                        print("Text has appeared")
                    }
                )
                .onDisappear(
                    perform: {
                        print("Text has disappeared")
                    }
                )
            Button(
                action: {},
                label: { Text("Button") }
            )
            .modifier(RedModifier(foreground: .black))
        }
    }
}

struct RedModifier: ViewModifier {
    private var foreground: Color
    
    init(foreground: Color) {
        self.foreground = foreground
    }
    
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(.red)
            .foregroundColor(foreground)
    }
}

#Preview {
    EventsAndCustomModifiersView()
}
