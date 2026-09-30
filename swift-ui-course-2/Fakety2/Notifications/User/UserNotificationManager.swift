//
//  UserNotificationManager.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 27/12/24.
//

import SwiftUI

class UserNotificationManager {
    private var notificationCenter: UNUserNotificationCenter {
        UNUserNotificationCenter.current()
    }

    func sendNotification(message: String) {
        let messageToSend = message.trimmingCharacters(in: .whitespaces)

        if !messageToSend.isEmpty {
            Task(priority: .background) {
                let id = "Fakety2Notification-\(UUID())"

                let content = UNMutableNotificationContent()
                content.title = "Fakety2"
                content.body = messageToSend
                content.sound = .default

                let trigger = UNTimeIntervalNotificationTrigger(
                    timeInterval: 5,
                    repeats: false
                )

                let request = UNNotificationRequest(
                    identifier: id,
                    content: content,
                    trigger: trigger
                )

                await send(request: request)
            }
        }
    }

    func sendMediaNotification(message: String) {
        let messageToSend = message.trimmingCharacters(in: .whitespaces)

        if !messageToSend.isEmpty {
            Task(priority: .background) {
                let id = "Fakety2Notification-\(UUID())"

                let content = UNMutableNotificationContent()
                content.title = "Fakety2"
                content.body = messageToSend
                content.sound = .default

                if let astolfoURL = await getThumbnail(name: "astolfo") {
                    if let astolfoAttachment = try? UNNotificationAttachment(identifier: "astolfo", url: astolfoURL) {
                        content.attachments = [astolfoAttachment]
                    }
                }

                let trigger = UNTimeIntervalNotificationTrigger(
                    timeInterval: 5,
                    repeats: false
                )

                let request = UNNotificationRequest(
                    identifier: id,
                    content: content,
                    trigger: trigger
                )

                await send(request: request)
            }
        }
    }

    private func getThumbnail(name: String) async -> URL? {
        let fileManager = FileManager.default

        if let docsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = docsDirectoryURL.appendingPathComponent("\(name).png")
            let image = UIImage.astolfo

            if let thumbnail = await image.byPreparingThumbnail(ofSize: CGSize(width: 100, height: 100)) {
                if let thumbnailData = thumbnail.pngData() {
                    if let _ = try? thumbnailData.write(to: fileURL) {
                        return fileURL
                    }
                }
            }
        }

        return nil
    }

    func sendGroupedNotifications(message: String) {
        let messageToSend = message.trimmingCharacters(in: .whitespaces)

        if !messageToSend.isEmpty {
            Task(priority: .background) {
                for i in 1 ... 2 {
                    let content = UNMutableNotificationContent()
                    content.title = "Fakety2 - \(i)"
                    content.body = messageToSend
                    content.sound = .default
                    content.threadIdentifier = "Fakety-\(i)"

                    let trigger = UNTimeIntervalNotificationTrigger(
                        timeInterval: 5,
                        repeats: false
                    )

                    let request = UNNotificationRequest(
                        identifier: "Fakety2Notification-\(UUID())",
                        content: content,
                        trigger: trigger
                    )

                    await send(request: request)
                }
            }
        }
    }

    func sendNotificationSummary(message: String) {
        let messageToSend = message.trimmingCharacters(in: .whitespaces)
        let categoryID = "Fakety2GroupedID"

        let myNotificationCategory = UNNotificationCategory(
            identifier: categoryID,
            actions: [],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "%u Notifications",
            categorySummaryFormat: "%u new messages",
            options: []
        )

        notificationCenter.setNotificationCategories([myNotificationCategory])

        if !messageToSend.isEmpty {
            Task(priority: .background) {
                for i in 1 ... 3 {
                    let content = UNMutableNotificationContent()
                    content.title = "Fakety2Grouped"
                    content.body = "\(i) - \(messageToSend)"
                    content.sound = .default
                    content.categoryIdentifier = categoryID

                    let trigger = UNTimeIntervalNotificationTrigger(
                        timeInterval: 5,
                        repeats: false
                    )

                    let request = UNNotificationRequest(
                        identifier: "Fakety2Notification-\(UUID())",
                        content: content,
                        trigger: trigger
                    )

                    await send(request: request)
                }
            }
        }
    }

    func sendActionNotification(message: String) {
        let messageToSend = message.trimmingCharacters(in: .whitespaces)
        let categoryID = "Fakety2Actions"

        let deleteAction = UNNotificationAction(
            identifier: "delete",
            title: "Delete Now",
            options: .destructive
        )
        let inputAction = UNTextInputNotificationAction(
            identifier: "input",
            title: "Answer",
            options: []
        )

        let actionsNotificationCategory = UNNotificationCategory(
            identifier: categoryID,
            actions: [deleteAction, inputAction],
            intentIdentifiers: [],
            options: []
        )

        notificationCenter.setNotificationCategories([actionsNotificationCategory])

        if !messageToSend.isEmpty {
            Task(priority: .background) {
                let content = UNMutableNotificationContent()
                content.title = "Fakety2"
                content.body = messageToSend
                content.sound = .default
                content.categoryIdentifier = categoryID

                let trigger = UNTimeIntervalNotificationTrigger(
                    timeInterval: 5,
                    repeats: false
                )

                let request = UNNotificationRequest(
                    identifier: "Fakety2Notification-\(UUID())",
                    content: content,
                    trigger: trigger
                )

                await send(request: request)
            }
        }
    }

    private func send(request: UNNotificationRequest) async {
        let authorized = await checkNotificationAuthorization()

        if authorized {
            do {
                try await notificationCenter.add(request)
            } catch {
                debugPrint("Error adding notification: \(error)")
            }
        } else {
            debugPrint("Notification authorization denied")
        }
    }

    func checkNotificationAuthorization() async -> Bool {
        let authorizationStatus = (await notificationCenter.notificationSettings()).authorizationStatus

        return authorizationStatus == .authorized
    }

    func requestNotificationAuthorization() async throws -> Bool {
        let authorized = try await notificationCenter.requestAuthorization(
            options: [.alert, .sound]
        )

        return authorized
    }
}
