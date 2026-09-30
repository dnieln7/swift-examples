//
//  BasicListenerView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct BasicListenerView: View {
    @Environment(BasicNotificationManager.self) private var manager: BasicNotificationManager

    var body: some View {
        NavigationStack {
            VStack {
                Text("Total: \(manager.total)")
                    .padding()
                NavigationLink("Go to sender") {
                    BasicSenderView()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .navigationTitle("Listener")
        }
    }
}

#Preview {
    BasicListenerView()
        .environment(BasicNotificationManager())
}
