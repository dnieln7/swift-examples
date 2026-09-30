//
//  CameraView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 05/05/25.
//

import SwiftUI

struct CameraView: View {
    @State private var picture: UIImage? = nil
    @State private var showCameraUI: Bool = false

    var body: some View {
        VStack {
            if picture != nil {
                Image(uiImage: picture!)
                    .resizable()
                    .scaledToFit()
            }
            if picture != nil {
                Button("Save to gallery") {
                    UIImageWriteToSavedPhotosAlbum(picture!, nil, nil, nil)
                }
                .buttonStyle(.bordered)
            }
            if picture != nil {
                let photo = Image(uiImage: picture!)

                ShareLink("Share", item: photo, preview: SharePreview("Picture", image: photo))
            }
            Spacer()
            Button("Take Picture") {
                showCameraUI = true
            }
        }
        .sheet(isPresented: $showCameraUI) {
            ImagePicker(
                onNewPicture: {
                    picture = $0
                    showCameraUI = false
                },
                onCancel: {
                    showCameraUI = false
                }
            )
        }
    }
}

#Preview {
    CameraView()
}
