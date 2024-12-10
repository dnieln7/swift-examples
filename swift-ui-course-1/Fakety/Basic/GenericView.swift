//
//  GenericView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 08/10/24.
//

import SwiftUI

struct GenericView: View {
    
    var body: some View {
        getView2()
    }

    // Independently of the specific returned view this function always returns an AnyView
    func getView() -> AnyView {
        let valid = true
        var myView: AnyView

        if valid {
            myView = AnyView(Image(systemName: "keyboard"))
        } else {
            myView = AnyView(Text("The state is invalid"))
        }
        
        return myView
    }
    
    // Alternative so the view type is not lost
    @ViewBuilder
    func getView2() -> some View {
        let valid = false
        
        if valid {
            Image(systemName: "keyboard")
        } else {
//            Text("The state is invalid")
            EmptyView()
        }
    }
}

#Preview {
    GenericView()
}
