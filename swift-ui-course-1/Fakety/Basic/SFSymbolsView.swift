//
//  SFSymbolsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 07/10/24.
//

import SwiftUI

struct SFSymbolsView: View {
    var body: some View {
        VStack {
            Image(systemName: "pencil")
                .font(.system(size: 50).weight(.semibold))
            Image(systemName: "envelope")
                .font(.system(size: 50).weight(.semibold))
                .symbolVariant(.fill)
            Image(systemName: "paperclip")
                .font(.system(size: 50))
                .symbolRenderingMode(.multicolor)
            Image(systemName: "paperclip")
                .font(.system(size: 50))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.red)
            Image(systemName: "dot.radiowaves.forward", variableValue: 0.6)
                .font(.system(size: 50))
            Label("message", systemImage: "envelope.circle")
                .font(.largeTitle)
                .labelStyle(.titleAndIcon)
                .imageScale(.large)
        }
    }
}

#Preview {
    SFSymbolsView()
}
