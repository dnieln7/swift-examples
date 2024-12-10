//
//  TextsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 02/10/24.
//

import SwiftUI

struct TextsView: View {
    // Computed property: Getter
    var body: some View {
        get {
            // Expands along it's contents
            VStack {
                Text("Hello, world!")
                    .font(.custom("WorkSans-Regular", size: 40))
                    .underline()
                    .frame(maxWidth: .infinity)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
                    .frame(height: 12)
                Text("Not registered? \(Text("Sign Up").underline())")
                    .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/)
                Text("This is a very large text that will be truncated")
                    .font(.largeTitle)
                    .lineLimit(1)
                    .truncationMode(.middle)
                Text("This is another very large text that will be truncated, This is another very large text that will be truncated, This is another very large text that will be truncated")
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                Text("verbatim")
                    .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/)
                    .frame(alignment: .leading)
                Text("Colored background")
                    .font( .title)
                    .padding(20) // Order of modifiers matter
                    .background(Color.gray)
                    .padding(20) // padding outside the colored area
            }
        }
        set {
        }
    }
}

#Preview {
    TextsView()
}
