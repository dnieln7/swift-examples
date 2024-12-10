//
//  ConcurrencyView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 30/10/24.
//

import SwiftUI

struct ConcurrencyView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding()
        }
        .task(priority: .background) {
            let currentTime = Date()
             
            // Create 3 parallel tasks
            async let image1 = loadImage(name: "image1")
            async let image2 = loadImage(name: "image2")
            async let image3 = loadImage(name: "image3")
            
            // Run 3 parallel tasks
            let listNames = await [image1,image2, image3]
            
            print(listNames)
            print("Total time: \(Date().timeIntervalSince(currentTime))")
        }
    }
    
    func loadImage(name: String) async -> String {
        print("Loading image...")
        
        try? await Task.sleep(nanoseconds: 3 * NANOSECONDS_IN_A_SECOND)
        
        return if Task.isCancelled {
            "Nothing"
        } else {
            "Image: \(name)"
        }
    }
}

#Preview {
    ConcurrencyView()
}
