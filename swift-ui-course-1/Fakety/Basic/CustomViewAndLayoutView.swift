//
//  CustomViewAndLayoutView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 08/10/24.
//

import SwiftUI

struct CustomViewAndLayoutView: View {
    @State private var useCustomLayout: Bool = true

    var body: some View {
        
        // Using an AnyLayout allows for the views to not be re-created when the wrapper layout changes
        let SelectedLayout = useCustomLayout ? AnyLayout(MyLayout()) : AnyLayout(VStackLayout())

        VStack {
            Toggle(isOn: $useCustomLayout, label: { Text(useCustomLayout ? "Using MyLayout" : "Using VStack") }).padding(.bottom)
            SelectedLayout {
                Text("First")
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
                Text("First Second")
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
                Text("First Second Third")
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
            }.background(.gray)
        }

//        MyLayout {
//                Text("First")
//                    .padding()
//                    .background(.red)
//                    .cornerRadius(10)
//                Text("First Second")
//                    .padding()
//                    .background(.red)
//                    .cornerRadius(10)
//                Text("First Second Third")
//                    .padding()
//                    .background(.red)
//                    .cornerRadius(10)
//        }.background(.gray)
    }
}

struct MyLayout: Layout {
    // Use size each view to calculate the layout size
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var totalWidth: CGFloat = 0
        var totalHeight: CGFloat = 0

        for (index, view) in subviews.enumerated() {
            if index > 0 {
                totalHeight += 10 // Each view will have a bottom spacing of 10
            }

            // Get each view size, passing the proposed size as unspecified
            let viewSize = view.sizeThatFits(.unspecified)

            // Each view will have a right spacing of 10 multiplied by it's index
            totalWidth += viewSize.width + CGFloat(10 * index)
            totalHeight += viewSize.height
        }

        return CGSize(width: totalWidth, height: totalHeight)
    }

    // Calculate and asign the position of each view
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var posX: CGFloat = bounds.origin.x
        var posY: CGFloat = bounds.origin.y

        for (index, view) in subviews.enumerated() {
            if index > 0 {
                posX += CGFloat(10 * index) // Each view will have a right spacing of 10
                posY += 10 // Each view will have a bottom spacing of 10
            }

            view.place(at: CGPoint(x: posX, y: posY), proposal: .unspecified)

            // Increment the position to account for the alreay placed view
            posY += view.sizeThatFits(.unspecified).height
        }
    }
}

struct Greeting: View {
    var body: some View {
        HStack {
            Image(systemName: "hand.raised.fill")
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    CustomViewAndLayoutView()
}
