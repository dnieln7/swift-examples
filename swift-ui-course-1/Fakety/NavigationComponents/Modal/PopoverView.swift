//
//  PopoverView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 24/10/24.
//

import SwiftUI

struct PopoverView: View {
    
    @State private var showPopover: Bool = false
    
    var body: some View {
        VStack {
            Button("Show popover") {
                showPopover.toggle()
            }
            .popover(isPresented: $showPopover) {
                Text("This is a button")
                    .padding()
            }
        }
    }
}

#Preview {
    PopoverView()
}
