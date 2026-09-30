//
//  UserSenderView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 27/12/24.
//

import SwiftUI

struct UserSenderView: View {
    @State private var manager: UserNotificationManager = UserNotificationManager()

    @State private var input: String = ""
    @State private var sendButtonEnabled: Bool = false
    @State private var notificationType: NotificationType = .basic

    var body: some View {
        VStack {
            HStack {
                Text("Message: ")
                TextField("Enter your message", text: $input)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            Picker("Notification Type", selection: $notificationType) {
                Text("Basic").tag(NotificationType.basic)
                Text("Media").tag(NotificationType.media)
                Text("Grouped").tag(NotificationType.grouped)
                Text("Summary").tag(NotificationType.summary)
                Text("Actions").tag(NotificationType.actions)
            }
            .pickerStyle(.wheel)
            .padding([.trailing, .bottom, .leading])
            HStack {
                Spacer()
                Button("Send") {
                    sendNotification()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!sendButtonEnabled)
                Spacer()
            }
        }
        .task(priority: .background) {
            sendButtonEnabled = (try? await manager.requestNotificationAuthorization()) ?? false
        }
    }

    func sendNotification() {
        switch notificationType {
        case .basic:
            manager.sendNotification(message: input)
        case .media:
            manager.sendMediaNotification(message: input)
        case .grouped:
            manager.sendGroupedNotifications(message: input)
        case .summary:
            manager.sendNotificationSummary(message: input)
        case .actions:
            manager.sendActionNotification(message: input)
        }
    }
}

#Preview {
    UserSenderView()
}
