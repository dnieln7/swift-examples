//
//  UserDefaultsView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 25/12/24.
//

import SwiftUI

struct UserDefaultsView: View {
    @AppStorage("counter") var counter: Int = 0
    
    var body: some View {
        VStack{
            HStack {
                Stepper("Counter", value: $counter)
            }
            .padding()
            Text("Counter: \(counter)")
        }
    }
}

#Preview {
    UserDefaultsView()
}
