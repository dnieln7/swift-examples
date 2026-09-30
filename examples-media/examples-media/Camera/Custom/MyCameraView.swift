//
//  CustomCameraView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 07/05/25.
//

import SwiftUI

struct MyCameraView: View {
    @State private var viewModel = MyCameraViewModel()
    
    var body: some View {
        VStack {
            if viewModel.picture != nil {
                Image(uiImage: viewModel.picture!)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
            Button("Take Picture") {
                viewModel.showCameraUI = true
            }
        }
        .sheet(isPresented: $viewModel.showCameraUI) {
            ZStack{
                viewModel.myCameraPreview
                VStack {
                    Spacer()
                    HStack {
                        Button("Close") {
                            viewModel.showCameraUI = false
                        }
                        Spacer()
                        Button("Capture") {
                            viewModel.takePicture()
                        }
                    }
                    .padding()
                    .background(.regularMaterial)
                }
            }
            .task {
                await viewModel.requestCameraPermission()
            }
            .onDisappear {
                viewModel.cameraData.rotationObserver = nil
            }
        }
    }
}

#Preview {
    MyCameraView()
}
