//
//  ImagesView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 05/10/24.
//

import SwiftUI

struct ImagesView: View {
    
    // Size changes with user's font size
    @ScaledMetric var customSize: CGFloat = 100
    
    var body: some View {
        VStack {
            
            //            Image(.myAstolfo)
            //                .resizable()
            //                .frame(width: customSize, height: customSize * 2)
            
            Image(.myAstolfo)
                .resizable()
                .scaledToFit()
                .background(Color.yellow)
                .cornerRadius(25)
                .padding(24)
                .shadow(radius: 5)
            //                .scaleEffect(CGSize(width: 0.5, height: 0.5)) // scale to half size
            //                .blur(radius: 5)
            
            //            Image("MyAstolfo")
            //                .resizable()
            //                .aspectRatio(contentMode: .fit)
            //                .frame(width: .infinity, height: 500)
            
            //            Image("MyAstolfo")
            //                .resizable()
            //                .aspectRatio(contentMode: .fill)
            //                .frame(width: .infinity, height: 500)
            //                .clipped()
        }.background(Color.pink.opacity(0.5))
    }
}

#Preview {
    ImagesView()
}
