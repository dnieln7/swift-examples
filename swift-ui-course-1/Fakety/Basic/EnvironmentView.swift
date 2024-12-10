//
//  EnvironmentView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 09/10/24.
//

import SwiftUI

struct EnvironmentView: View {
    @Environment(\.colorScheme) var mode
    
    var body: some View {
        VStack {
            Color(.my)
                .frame(width: 100, height: 100)
            Image(systemName: "trash")
                .font(.system(size: 100))
                .foregroundColor(mode == .dark ? .red : .green)
        }
    }
}

#Preview {
    EnvironmentView()
    //        .environment(\.colorScheme, .light)
}
