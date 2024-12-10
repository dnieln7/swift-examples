//
//  EnvsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 14/10/24.
//

import SwiftUI

struct EnvsView: View {
    @Environment(ApplicationData.self) private var applicationData
    
    var body: some View {
        VStack {
            Text(applicationData.string)
            TextField("Insert string", text: Bindable(applicationData).string)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
}

#Preview {
    // ApplicationData is bnot available in this view hierarchy so we need to add it
    EnvsView()
        .environment(ApplicationData())
}
