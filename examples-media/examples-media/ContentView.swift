//
//  ContentView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Menu")
                Spacer()
                NavigationButtonView("Camera") {
                    CameraView()
                }
                NavigationButtonView("Custom Camera") {
                    MyCameraView()
                }
                NavigationButtonView("Photos Picker") {
                    PhotosPickerView()
                }
                NavigationButtonView("Video Player") {
                    VideoPlayerView()
                }
                NavigationButtonView("Custom Video Player") {
                    MyVideoPlayerView()
                }
                NavigationButtonView("Color Picker") {
                    ColorPickerView()
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
