//
//  ProgressAndStepperView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 11/10/24.
//

import SwiftUI

struct ProgressAndStepperView: View {
    @State private var progress: Float = 0.5
    @State private var step: Int = 0

    @State private var step2: Int = 0
    @State private var goingUp: Bool = false

    var body: some View {
        VStack {
            Slider(value: $progress, in: 0.0 ... 1, step: 0.1)
            ProgressView(value: progress, total: 1)
                .padding()
            ProgressView()
            Stepper("Counter: \(step)", value: $step, in: 0 ... 100, step: 7)
                .padding()
            Stepper(
                label: {
                    HStack {
                        Text("Counter: \(step2)")
                        Image(systemName: goingUp ? "arrow.up" : "arrow.down")
                            .foregroundColor(goingUp ? .green : .red)
                    }
                },
                onIncrement: {
                    step2 += 7
                    goingUp = true
                },
                onDecrement: {
                    step2 -= 7
                    goingUp = false
                }
            )
            .padding()
        }
    }
}

#Preview {
    ProgressAndStepperView()
}
