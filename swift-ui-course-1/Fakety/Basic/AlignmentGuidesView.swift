//
//  AlignmentGuidesView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 07/10/24.
//

import SwiftUI

struct AlignmentGuidesView: View {
    var body: some View {
        HStack(alignment: VerticalAlignment.alignPlayer) {
            Image(systemName: "play")
                .symbolVariant(.fill)
                .font(.system(size: 100))
                .alignmentGuide(VerticalAlignment.alignPlayer) { dimensions in
                    dimensions[VerticalAlignment.center] + 50
                }
            Image(systemName: "pause")
                .symbolVariant(.fill)
                .font(.system(size: 150))
            Image(systemName: "stop")
                .symbolVariant(.fill)
                .font(.system(size: 50))
        }.border(.red, width: 4)
    }
}

extension VerticalAlignment {
    struct PlayerAlignmentID: AlignmentID {
        static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
            return dimensions[VerticalAlignment.center]
        }
    }

    static let alignPlayer = VerticalAlignment(PlayerAlignmentID.self) // reference to the definition of PlayerAlignmentID
}

#Preview {
    AlignmentGuidesView()
}
