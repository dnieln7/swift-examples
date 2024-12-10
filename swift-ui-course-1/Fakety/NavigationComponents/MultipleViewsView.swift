//
//  MultipleViewsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 22/10/24.
//

import SwiftUI

struct MultipleViewsView: View {
    var body: some View {
        NavigationStack {
            ButtonsView()
                .navigationTitle("Buttons")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    MultipleViewsView()
        .environment(ApplicationData())
}
