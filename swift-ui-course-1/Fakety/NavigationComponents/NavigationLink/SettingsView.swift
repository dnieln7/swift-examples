//
//  SettingsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 10/12/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack {
            Text("Settings will be here...")
        }
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Close") {
                    navigationPath.removeLast()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(
                    value: Destinations.toggle,
                    label: {
                        Image(systemName: "pencil")
                    }
                )
            }
        }
    }
}
