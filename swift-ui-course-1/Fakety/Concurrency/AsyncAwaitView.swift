//
//  AsyncAwaitView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 30/10/24.
//

import SwiftUI

struct AsyncAwaitView: View {
    // Computed properties can also be async
    var thumbnail: String {
        get async {
            try? await Task.sleep(nanoseconds: 3 * NANOSECONDS_IN_A_SECOND)
            return "myThumbnail"
        }
    }

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding()
        }
        // Started when the view appears and stopped on dissapear
//        .task(priority: .background) {
//            let imageName = await loadImage(name: "hello")
//            let imageName2 = await loadImage(name: "hello2")
//            let imageName3 = await loadImage(name: "hello3")
//
//            print(imageName)
//            print(imageName2)
//            print(imageName3)
//        }
        // Manually managing task
//        .onAppear {
//            let task = Task(priority: .background) {
//                let imageName = await loadImage(name: "hello task")
//
//                print(imageName)
//            }
//
//            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
//                print("Stop tasks")
//                task.cancel()
//            }
//        }
        .task(priority: .background) {
            let imageName = await loadImage2(name: "hello task")
            let thumb = await thumbnail

            do {
                let riskyImageName = try await loadRiskyImage(name: "danger!")
                print(riskyImageName)
            } catch ImageError.noData {
                print("No data available")
            } catch ImageError.noImage {
                print("No image available")
            } catch {
                print("Unknown error")
            }

            print(imageName)
            print(thumb)
        }
    }

    func loadImage(name: String) async -> String {
        print("Loading image...")

        try? await Task.sleep(nanoseconds: 3 * NANOSECONDS_IN_A_SECOND)

        return if Task.isCancelled {
            "Nothing"
        } else {
            "Image: \(name)"
        }
    }

    func loadImage2(name: String) async -> String {
        let result = Task(priority: .background) {
            let imageMetadata = await getMetadata()

            return "Name: \(name) Size: \(imageMetadata)"
        }

        let message = await result.value

        return message
    }

    func getMetadata() async -> Int {
        try? await Task.sleep(nanoseconds: 3 * NANOSECONDS_IN_A_SECOND)

        return 5000
    }

    func loadRiskyImage(name: String) async throws -> String {
        try? await Task.sleep(nanoseconds: 3 * NANOSECONDS_IN_A_SECOND)

        throw ImageError.noImage
    }
}

fileprivate enum ImageError: Error {
    case noData
    case noImage
}

#Preview {
    AsyncAwaitView()
}
