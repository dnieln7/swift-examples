//
//  LayoutStacksView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 07/10/24.
//

import SwiftUI

/// Stacks: Size is defined by its content

struct LayoutStacksView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Hello")
            Text("World")
            HStack(alignment: .bottom) {
                Text("This is a large text")
                    .font(.title)
                    .lineLimit(1)
                    .layoutPriority(1) // more space is given
                Image(systemName: "play")
                    .symbolVariant(.fill)
                    .font(.title)
                Text("This is another large text")
                    .font(.title)
                    .lineLimit(1)
//                    .fixedSize() // Ignores priority
            }
            Spacer()
            HStack(alignment: .bottom) {
                Image(systemName: "cloud")
                    .font(.system(size: 100))
                Text("Cloud")
            }
            ZStack(alignment: .top) {
                Text("Cloud")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .zIndex(1)
                Color.red
                    .frame(width: 100, height: 100)
                Image(systemName: "cloud")
                    .font(.system(size: 100))
            }
            ZStack(alignment: .center) {
                Image(systemName: "cloud")
                    .font(.system(size: 100))
                Text("Cloud")
            }.foregroundColor(.red) // Applies to all child views
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                Text("Bottom bar")
                    .padding([.top], 20)
                    .font(.largeTitle.bold())
                Spacer()
            }.background(.yellow)
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    LayoutStacksView()
}
