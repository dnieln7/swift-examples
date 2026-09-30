//
//  VideoPlayerView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 05/05/25.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    @State private var player: AVPlayer

    init() {
        let localVideoURL = Bundle.main.url(forResource: "local", withExtension: "mp4")!
        player = AVPlayer(url: localVideoURL)
    }

    var body: some View {
        VStack {
            VideoPlayer(
                player: player,
                videoOverlay: {
                    Text("hello")
                }
            )
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
            .frame(height: 400)
        }
    }
}

#Preview {
    VideoPlayerView()
}
