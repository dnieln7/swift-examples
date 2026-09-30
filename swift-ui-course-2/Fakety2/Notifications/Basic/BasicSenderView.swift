//
//  BasicSenderView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct BasicSenderView: View {
    @Environment(BasicNotificationManager.self) private var manager: BasicNotificationManager
    
    @State private var input:String = ""
    
    var body: some View {
        VStack {
            TextField("Title", text: $input)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Send") {
                if !input.isEmpty {
                    manager.sendTitle(input)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Sender")
    }
}

#Preview {
    BasicSenderView()
        .environment(BasicNotificationManager())
}
