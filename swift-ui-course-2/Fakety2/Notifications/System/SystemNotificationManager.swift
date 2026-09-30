//
//  SystemNotificationManager.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import Combine
import Observation
import SwiftUI

@Observable class SystemNotificationManager {
    var keyboardVisibleCount: Int = 0

    init() {
        Task(priority: .background) {
            await listenToKeyboardNotifications()
        }
        
        Task(priority: .background) {
            await listenToOrientationNotifications()
        }
    }

    @MainActor
    func listenToKeyboardNotifications() async {
        let notificationCenter = NotificationCenter.default
        let name = UIWindow.keyboardDidShowNotification

        for await _ in notificationCenter.notifications(named: name, object: nil) {
            debugPrint("Keyboard Notification received")

            keyboardVisibleCount += 1
        }
    }

    @MainActor
    func listenToOrientationNotifications() async {
        let notificationCenter = NotificationCenter.default
        let name = UIDevice.orientationDidChangeNotification

        for await _ in notificationCenter.notifications(named: name, object: nil) {
            debugPrint("Orientation Notification received")

            let device = UIDevice.current
            let orientation = device.orientation

            debugPrint("Orientation isLandscape: \(orientation.isLandscape)")
            debugPrint("Orientation isPortrait: \(orientation.isPortrait)")
        }
    }
}
