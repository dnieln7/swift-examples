//
//  InputView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 10/10/24.
//

import SwiftUI

struct InputView: View {
    @FocusState private var focusType: FocusType?

    @State private var enabled: Bool = false

    @State private var title: String = ""
    @State private var titleInput: String = ""
    @State private var title2: String = ""
    @State private var titleInput2: String = ""

    @State private var password: String = ""
    @State private var bigText: String = ""

    var body: some View {
        VStack(spacing: 15) {
            Text(title)
                .lineLimit(1)
                .padding()
                .background(.yellow)
            Text(title2)
                .lineLimit(1)
                .padding()
                .background(.red)
            TextField("Insert title", text: $titleInput)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .submitLabel(.next)
                .focused($focusType, equals: .title)
                .onChange(of: titleInput, initial: false) { old, new in
                    /// initial: Whether the action should be run when this view initially appears.

                    print("old value: \(old)")

                    if new.count > 10 {
                        // If more than 10 chars return the first 10 chars
                        titleInput = String(new.prefix(10))
                    }
                }
                .padding()
                .background(focusType == .title ? .yellow : .clear)
                .onSubmit {
                    focusType = .title2
                }
            TextField("Insert title 2", text: $titleInput2, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.words)
                .keyboardType(.asciiCapableNumberPad)
                .lineLimit(2) // After this line the text field becomes scrollable (requires vertical axis)
                .submitLabel(.done)
                .focused($focusType, equals: .title2)
                .padding()
                .background(focusType == .title2 ? .red : .clear)
                .onSubmit {
                    updateText()
                    updateText2()
                }
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()
            Text(bigText)
            TextEditor(text: $bigText)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
                .autocorrectionDisabled(false)
                .padding(2)
                .background(.black)
                .padding()
            Button("Save") {
                updateText()
                updateText2()
            }.disabled(title.isEmpty || title2.isEmpty)
        }.background(enabled ? .gray : .clear)
    }

    func updateText() {
        title = titleInput
        titleInput = ""
    }

    func updateText2() {
        title2 = titleInput2
        titleInput2 = ""
    }
}

enum FocusType: Hashable {
    case title
    case title2
}

#Preview {
    InputView()
}
