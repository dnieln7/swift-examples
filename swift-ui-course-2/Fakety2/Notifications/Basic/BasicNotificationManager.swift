//
//  BasicNotificationManager.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import Combine
import Observation
import SwiftUI

@Observable class BasicNotificationManager {
    var total: Int = 0
    @ObservationIgnored private var titles: [String] = []

    init() {
        Task(priority: .background) {
            await listenToNotifications()
        }
    }

    func sendTitle(_ title: String) {
        titles.append(title)

        let notificationCenter = NotificationCenter.default
        notificationCenter.post(
            name: Notification.Name("Update Data"),
            object: nil,
            userInfo: ["title": title]
        )
    }

    func listenToNotifications() async {
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name("Update Data")

        for await notification in notificationCenter.notifications(named: name, object: nil) {
            debugPrint("Notification received")
            debugPrint("Notification name: \(notification.name.rawValue)")
            debugPrint("Notification userInfo: \(notification.userInfo ?? [:])")

            await MainActor.run {
                total = titles.count
            }
        }
    }
}
