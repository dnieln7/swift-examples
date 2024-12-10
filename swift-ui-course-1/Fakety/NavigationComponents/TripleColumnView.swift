//
//  TripleColumnView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 28/10/24.
//

import SwiftUI

struct TripleColumnView: View {
    @State private var visibility: NavigationSplitViewVisibility = .automatic

    @State private var optionsToColors: Dictionary<String, [Color]> = [
        "One": [Color.red, Color.blue],
        "Two": [Color.green, Color.yellow, Color.orange],
        "Three": [Color.gray],
    ]
    @State private var options: [String] = [
        "One",
        "Two",
        "Three",
    ]

    @State private var selectedOption: String? = nil
    @State private var selectedColor: Color? = nil

    var body: some View {
        NavigationSplitView(
            columnVisibility: $visibility,
            sidebar: {
                List(options, id: \.self, selection: $selectedOption) { option in
                    NavigationLink(
                        value: option,
                        label: {
                            Text(option)
                        }
                    )
                }
                .listStyle(.sidebar)
                .navigationTitle("Options")
            },
            content: {
                if let option = selectedOption {
                    List(optionsToColors[option]!, id: \.self, selection: $selectedColor) { option in
                        NavigationLink(
                            value: option,
                            label: {
                                Text(option.description.capitalized)
                            }
                        )
                    }
                    .listStyle(.sidebar)
                    .navigationTitle("Colors")
                } else {
                    Text("Select an option")
                }
            },
            detail: {
                if let color = selectedColor {
                    VStack {
                        Spacer()
                        Text(color.description.capitalized)
                            .font(.largeTitle)
                        Spacer()
                    }
                    .background(color)
                    .navigationTitle("Detail")
                } else { 
                    Text("Select a color")
                }
            }
        )
        .navigationSplitViewStyle(.prominentDetail)
//        .onChange(of: selectedColor) { _, _ in
//            visibility = .detailOnly
//        }
    }
}

#Preview {
    TripleColumnView()
}
