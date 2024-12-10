//
//  ModelView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 11/10/24.
//

import SwiftUI
import Observation

struct ModelView: View {
    private var data: ModelData = ModelData()
    @Bindable private var viewData: ModelViewData = ModelViewData()

    // Can also initialize in onAppear of the VStack
    init() {
        viewData.titleInput = data.title
    }

    var body: some View {
        VStack {
            Text(data.title)
                .padding()
            TextField("Insert title", text: $viewData.titleInput) // @Bindable is required for this, can also be wrapped with Bindable(viewData)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Save") {
                data.title = viewData.titleInput
                viewData.savePressedCounter += 1
            }
        }
    }
}

#Preview {
    ModelView()
}
