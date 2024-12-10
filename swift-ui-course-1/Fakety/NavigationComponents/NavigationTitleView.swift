//
//  NavigationTitleView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 22/10/24.
//

import SwiftUI

struct NavigationTitleView: View {
    var body: some View {
        NavigationStack {
            ButtonsView()
                .navigationTitle("Buttons")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    NavigationTitleView()
        .environment(ApplicationData())
}
