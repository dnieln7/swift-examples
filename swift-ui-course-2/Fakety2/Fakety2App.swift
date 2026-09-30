//
//  Fakety2App.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 23/12/24.
//

import SwiftUI

@main
struct Fakety2App: App {
    @UIApplicationDelegateAdaptor(Fakety2AppDelegate.self) var appDelegate: Fakety2AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(UserNotificationDelegate())
        }
//        DocumentGroup(
//            newDocument: TextDocument(),
//            editor: { fileDocumentConfiguration in
//                DocumentView(textDocument: fileDocumentConfiguration.$document)
//            }
//        )
    }
}
