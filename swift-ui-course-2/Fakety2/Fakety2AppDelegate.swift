//
//  Fakety2AppDelegate.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 31/12/24.
//

import UIKit

class Fakety2AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        debugPrint("app launched")
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(
            name: "Delegate",
            sessionRole: connectingSceneSession.role
        )

        if connectingSceneSession.role == .windowApplication {
            sceneConfiguration.delegateClass = Fakety2SceneDelegate.self
        }

        return sceneConfiguration
    }
}
