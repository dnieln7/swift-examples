//
//  ToggleSliderView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 10/10/24.
//

import SwiftUI

struct ToggleSliderView: View {
    @Environment(\.dismiss) private var dismissView: DismissAction

    @State private var number: Float = 5
    @State private var isOn: Bool = false

    var body: some View {
        VStack {
            Text("Current: \(number.formatted(.number.precision(.fractionLength(1))))")
            Slider(value: $number, in: 0 ... 10, step: 0.1) { isMoving in
                if isMoving {
                    print("Slider is moving")
                } else {
                    print("Slider stopped moving")
                }
            }
            .padding()
            Toggle(
                isOn: $isOn,
                label: {
                    Text(isOn ? "On" : "Off")
                    Text("Enable or disable")
                }
            )
            .padding()
//            .toggleStyle(MyToggleStyle())
//            .fixedSize()
//            .labelsHidden()
        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement:.topBarTrailing) {
//                Button("To previous view") {
//                    dismissView()
//                }
//            }
//        }
    }
}

struct MyToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.label
            Spacer()
            Image(systemName: "checkmark.rectangle.fill")
                .font(.largeTitle)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture {
                    configuration.$isOn.wrappedValue.toggle()
                }
        }
    }
}

#Preview {
    ToggleSliderView()
}
