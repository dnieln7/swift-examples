//
//  UIKitView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

struct UIKitView: UIViewRepresentable {
    @Binding var input: String

    func makeUIView(context: Context) -> some UIView {
        let view = UITextView()
        view.backgroundColor = .yellow
        view.font = .systemFont(ofSize: 17)
        view.delegate = context.coordinator

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> CoordinatorTextView {
        return CoordinatorTextView(input: $input)
    }
}


struct UIKitContainerView: View {
    @State private var input: String = ""

    var body: some View {
        VStack {
            Text("input: \(input)")
            UIKitView(input: $input)
        }
    }
}

#Preview {
    UIKitContainerView()
}
