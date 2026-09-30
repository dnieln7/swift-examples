//
//  KeyValueObservationView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 31/12/24.
//

import SwiftUI

struct KeyValueObservationView: View {
    @State private var viewModel: KeyValueObservationViewModel = KeyValueObservationViewModel()

    var body: some View {
        VStack {
            Text(viewModel.currentValue)
                .padding()
            Button("Increase count") {
                viewModel.myObservedObject.count += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .onDisappear {
            viewModel.onDispose()
        }
    }
}

#Preview {
    KeyValueObservationView()
}
