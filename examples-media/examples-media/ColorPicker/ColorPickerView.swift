//
//  ColorPickerView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 08/05/25.
//

import SwiftUI

struct ColorPickerView: View {
    @State private var selectedColor: Color = .blue
    
    var body: some View {
        VStack {
            ColorPicker("Choose a color", selection: $selectedColor)
            Spacer()
        }
        .background(selectedColor)
        .padding()
    }
}

#Preview {
    ColorPickerView()
}
