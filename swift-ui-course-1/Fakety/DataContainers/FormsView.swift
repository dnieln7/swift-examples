//
//  FormsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 18/10/24.
//

import SwiftUI

struct FormsView: View {
    @State private var active: Bool = false
    @State private var showPictures: Bool = false

    @State private var valueExpanded: Bool = true
    @State private var total: Int = 10

    var body: some View {
        Form {
            Section(
                header: Text("Options"),
                footer: Text("Activate the options you want to see")
            ) {
                Toggle("Active", isOn: $active)
                Toggle("Show pictures", isOn: $showPictures)
            }
            DisclosureGroup("Values", isExpanded: $valueExpanded) {
                LabeledContent("Total") {
                    Text(String(describing: total))
                    Stepper("", value: $total, in: 0 ... 10)
                        .labelsHidden()
                }
                HStack {
                    Text("Total:")
                    Text(String(describing: total))
                    Spacer()
                    Stepper("", value: $total, in: 0 ... 10)
                        .labelsHidden()
                }
            }
        }
    }
}

#Preview {
    FormsView()
}
