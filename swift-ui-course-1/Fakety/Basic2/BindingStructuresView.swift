//
//  BindingStructuresView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 10/10/24.
//

import SwiftUI

struct BindingStructuresView: View {
    @State private var title: String = "Default"
    @State private var input: String = ""

    init() {
        _title = State(initialValue: "Another default")
        _input = State(initialValue: "Hello")
    }

    var body: some View {
        VStack {
//            Text(_title.wrappedValue)
//                .padding()
//            TextField("write here", text: _input.projectedValue)
//                .padding()
//                .border(.black, width: 2)
//                .padding()
            HeaderView2(title: $title, input: $input)
            Button(
//                action: { _title.wrappedValue = _input.wrappedValue },
                action: { title = input },
                label: { Text("Change") }
            )
            Spacer()
        }
    }
}

struct HeaderView2: View {
    @Binding var title: String
    @Binding var input: String
    let counter: Int

    init(title: Binding<String>, input: Binding<String>) {
        _title = title
        _input = input

        counter = _title.wrappedValue.count
    }

    var body: some View {
        VStack {
            Text("\(title) (\(counter))")
                .padding()
            TextField("Insert title", text: $input)
                .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    BindingStructuresView()
}

#Preview("HeaderView2") {
    let previewTitle = Binding<String>(
        get: { "Preview title" },
        set: { value in print(value) }
    )
    
//    let previewInput = Binding<String>(
//        get: { "" },
//        set: { value in print(value) }
//    )

    HeaderView2(title: previewTitle, input: .constant("typed"))
}
