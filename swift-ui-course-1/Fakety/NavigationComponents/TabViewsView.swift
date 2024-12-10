//
//  TabViewsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 24/10/24.
//

import SwiftUI

struct TabViewsView: View {
    @State private var selectedTabIndex: Int = 1

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            ButtonsView()
                .tabItem({
                    Label("Buttons", systemImage: "button.programmable")
                })
                .tag(0)
            ToggleSliderView()
                .tabItem({
                    Label("Toggle", systemImage: "hand.draw")
                })
                .tag(1)
                .badge(12)
        }
//        .tabViewStyle(.page)
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    TabViewsView()
}
