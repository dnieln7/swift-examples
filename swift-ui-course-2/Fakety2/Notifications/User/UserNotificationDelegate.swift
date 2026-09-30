//
//  UserNotificationDelegate.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 31/12/24.
//

import Observation
import SwiftUI

@Observable class UserNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    @ObservationIgnored private lazy var userNotificationCenter: UNUserNotificationCenter = {
        UNUserNotificationCenter.current()
    }()

    override init() {
        super.init()
        userNotificationCenter.delegate = self
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        print("willPresent")
        return [.banner]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("didReceive")

        if response.actionIdentifier == "delete" {
            print("Delete was tapped")
        }
        
        if response.actionIdentifier == "input" {
            let input = (response as! UNTextInputNotificationResponse).userText
            print("Input was provided: \(input)")
        }
    }
}
