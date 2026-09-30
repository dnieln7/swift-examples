//
//  SystemListenerView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct SystemListenerView: View {
    @State private var manager: SystemNotificationManager = SystemNotificationManager()

    @FocusState private var focused: Bool
    @State private var input: String = ""

    var body: some View {
        VStack {
            Image(systemName: "clock")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Times the keyboard has been shown: \(manager.keyboardVisibleCount)")
            HStack {
                TextField("Input", text: $input)
                    .textFieldStyle(.roundedBorder)
                    .focused($focused)
                Button("Focus") { focused.toggle() }
            }
        }
    }
}

#Preview {
    SystemListenerView()
}
