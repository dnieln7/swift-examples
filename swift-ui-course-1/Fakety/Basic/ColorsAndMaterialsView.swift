//
//  ColorsAndMaterialsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 02/10/24.
//

import SwiftUI

struct ColorsAndMaterialsView: View {
    var body: some View {
        VStack {
            Color.accentColor
                .frame(width: 250, height: 100)
                .overlay(Color.white.opacity(0.4))
            Color.red
                .frame(width: 250, height: 100)
                .overlay(Color.white.opacity(0.4))
            Color("MyColor")
                .frame(width: 250, height: 100)
                .border(Color.yellow, width: 10.0)
                .cornerRadius(12)
            Text("Fancy!")
                .font(.title)
                .foregroundColor(Color.white)
                .frame(width: 250, height: 100)
                .background(Color.blue.gradient)
            Text("Blured background!")
                .font(.title)
                .frame(width: 250, height: 50)
                .background(Material.thickMaterial)
            Text("Blured foreground!")
                .font(.title)
                .frame(width: 250, height: 50)
                .background(.yellow)
                .foregroundStyle(Material.thin)
        }
    }
}

#Preview {
    ColorsAndMaterialsView()
}
