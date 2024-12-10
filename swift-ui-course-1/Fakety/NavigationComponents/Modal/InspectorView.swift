//
//  InspectorView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 24/10/24.
//

import SwiftUI

struct InspectorView: View {
    
    @State private var showInspector: Bool = false
    
    var body: some View {
        NavigationStack {
            ButtonsView()
                .navigationTitle("Buttons")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                showInspector.toggle()
                            },
                            label: {
                                Image(systemName: "gear")
                            }
                        )
                    }
                }
                .inspector(isPresented: $showInspector) {
                    ToggleSliderView()
                        .inspectorColumnWidth(500)
                }
        }
    }
}

#Preview {
    InspectorView()
}
