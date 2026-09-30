//
//  MyVideoPlayerView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 08/05/25.
//

import SwiftUI

struct MyVideoPlayerView: View {
    @State private var viewModel = MyVideoPlayerViewModel()

    var body: some View {
        VStack {
            viewModel.myVideoPreview
                .scaledToFit()
                .background(.red)
            Spacer()
            Text("progress: \(viewModel.progress)")
            Text("time: \(viewModel.seconds)")
            HStack {
                Button("Back 2 sec") {
                    viewModel.backward()
                }
                .buttonStyle(.bordered)
                if viewModel.playing {
                    Button("Pause") {
                        viewModel.pause()
                    }
                    .buttonStyle(.bordered)
                } else {
                    Button("Play") {
                        viewModel.play()
                    }
                    .buttonStyle(.bordered)
                }
                Button("Forward 2 sec") {
                    viewModel.forward()
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    MyVideoPlayerView()
}
