//
//  FaketyApp.swift
//  Fakety
//
//  Created by Daniel Nolasco on 25/09/24.
//

import SwiftUI

@main
struct FaketyApp: App {
    @State private var applicationData: ApplicationData = ApplicationData()

    // Scene: Window
    var body: some Scene {
        // Manage all windows of an instance of the application
        WindowGroup {
            TripleColumnView()
                .environment(applicationData)
        }
    }
}
