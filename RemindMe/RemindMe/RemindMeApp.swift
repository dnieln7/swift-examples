//
//  RemindMeApp.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 10/12/24.
//

import SwiftUI

@main
struct RemindMeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext,
                              CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
