//
//  GeometryReaderView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 28/10/24.
//

import SwiftUI

struct GeometryReaderView: View {
    @State private var imageSize: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            let isPortrait = geometry.isPortrait()
            let message = isPortrait ? "Portrait" : "Landscape"

            // Local coordinates are of the GeometryReader view
            // Global coordinates are the position of the GeometryReader view relative to the screen
            let globalX = Int(geometry.frame(in: .global).origin.x)
            let globalY = Int(geometry.frame(in: .global).origin.y)

            VStack {
                Text("Coordinates: X = \(globalX), Y = \(globalY)")
                Text(message)
                    .padding()
                Image(.myAstolfo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width / 2)
                    .padding()
                    .background(
                        GeometryReader { geo in
                            // imageSize is not updated correctly because is changed on the onAppear
                            // To solve this we need to take the value of geo.size up to the hierarchy using preferences
//                            Color.white
//                                .onAppear {
//                                    imageSize = geo.size
//                                }
                            Color.white
                                .preference(key: ImageSizePreference.self, value: geo.size)
                        }
                    )
                Text("Image size: \(Int(imageSize.width)) X \(Int(imageSize.height))")
            }
            .onPreferenceChange(ImageSizePreference.self) { newValue in
                imageSize = newValue
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
        }
        .background(.yellow)
//        .frame(width: 200, height: 400)
    }
}

extension GeometryProxy {
    func isPortrait() -> Bool {
        return size.height > size.width
    }
}

fileprivate struct ImageSizePreference: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue: CGSize = .zero

    // Value: old value container
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    GeometryReaderView()
}
