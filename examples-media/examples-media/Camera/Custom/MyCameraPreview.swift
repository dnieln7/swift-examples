//
//  MyCameraPreviewUIView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 07/05/25.
//

import AVFoundation
import SwiftUI

struct MyCameraPreview: UIViewRepresentable {
    let uiView = MyCameraPreviewUIView()
    
    func makeUIView(context: Context) -> some UIView {
        return uiView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

class MyCameraPreviewUIView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
