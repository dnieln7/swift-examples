//
//  MyVideoPreview.swift
//  examples-media
//
//  Created by Daniel Nolasco on 08/05/25.
//

import AVFoundation
import SwiftUI

struct MyVideoPreview: UIViewRepresentable {
    let uiView = MyVideoPreviewUIView()

    func makeUIView(context: Context) -> some UIView {
        return uiView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

class MyVideoPreviewUIView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
