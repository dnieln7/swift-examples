//
//  AsyncSequencesView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 30/10/24.
//

import SwiftUI

struct AsyncSequencesView: View {
    private let images:[String] = ["image1", "image2", "image3", "image4"]
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .task(priority: .background) {
            let loader = ImageLoader(imageList: images)
            
            for await image in loader {
                print(image)
            }
        }
    }
}

struct ImageIterator: AsyncIteratorProtocol {
    let imageList: [String]
    var currentIndex = 0

    mutating func next() async -> String? {
        guard currentIndex < imageList.count else {
            return nil
        }

        try? await Task.sleep(nanoseconds: 3 * NANOSECONDS_IN_A_SECOND)

        let image = imageList[currentIndex]

        currentIndex += 1

        return image
    }
}

struct ImageLoader: AsyncSequence {
    typealias AsyncIterator = ImageIterator
    typealias Element = String

    let imageList: [String]

    func makeAsyncIterator() -> ImageIterator {
        AsyncIterator(imageList: imageList)
    }
}

#Preview {
    AsyncSequencesView()
}
