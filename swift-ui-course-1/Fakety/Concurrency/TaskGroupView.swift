//
//  TaskGroupView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 31/10/24.
//

import SwiftUI

struct TaskGroupView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .task(priority: .background) {
            await withTaskGroup(of: String.self) { group in
                group.addTask(priority: .background) {
                    let imageName = await loadImage(name: "image1")
                    return imageName
                }
                group.addTask(priority: .background) {
                    let imageName = await loadImage(name: "image2")
                    return imageName
                }
                group.addTask(priority: .background) {
                    let imageName = await loadImage(name: "image3")
                    return imageName
                }

                for await result in group {
                    print(result)
                }
            }
        }
    }

    func loadImage(name: String) async -> String {
        print("Loading image...")
        try? await Task.sleep(nanoseconds: 3 * NANOSECONDS_IN_A_SECOND)
        return "Image: \(name)"
    }
}

#Preview {
    TaskGroupView()
}
