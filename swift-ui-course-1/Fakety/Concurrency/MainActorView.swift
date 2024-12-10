//
//  MainActorView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 30/10/24.
//

import SwiftUI

struct MainActorView: View {
    @State private var myText: String = "Hey!"

    var body: some View {
        VStack {
            Text(myText)
                .padding()
        }
        .task(priority: .background) {
//            await loadImage(name: "Image!")
//            await loadImage2(name: "Image2!")
            await loadImage3(name: "Image3!")
        }
    }

    @MainActor func loadImage(name: String) async {
        myText = name
    }

    func loadImage2(name: String) async {
        await MainActor.run {
            myText = name
        }
    }

    func loadImage3(name: String) async {
        let result: String = await MainActor.run {
            myText = name

            return "name: \(name)"
        }

        print(result)
    }
}

#Preview {
    MainActorView()
}
