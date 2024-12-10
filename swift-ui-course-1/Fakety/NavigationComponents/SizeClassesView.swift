//
//  SizeClassesView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 28/10/24.
//

import SwiftUI

struct SizeClassesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                Spacer()
                Text("This is a compact screen")
                    .font(.title)
                    .padding()
                Text("These texts are in a column")
                    .font(.title2)
                Spacer()
            }
        } else {
            HStack {
                Color(.red)
                    .frame(maxWidth: .infinity)
                Color(.yellow)
                    .frame(maxWidth: .infinity)
//                Spacer()
//                Text("This is a regular screen")
//                    .font(.title)
//                    .padding()
//                Text("These texts are in a row")
//                    .font(.title2)
//                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SizeClassesView()
}
