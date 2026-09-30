//
//  Untitled.swift
//  examples-media
//
//  Created by Daniel Nolasco on 07/05/25.
//

@preconcurrency import AVFoundation
import SwiftUI

class CameraData {
    var captureDevice: AVCaptureDevice?
    var captureSession: AVCaptureSession?
    var rotationCoordinator: AVCaptureDevice.RotationCoordinator?
    var rotationObserver: NSKeyValueObservation?
    var output: AVCapturePhotoOutput?
}

@Observable
class MyCameraViewModel {
    var picture: UIImage?
    var showCameraUI: Bool = false

    var myCameraPreview: MyCameraPreview!

    @ObservationIgnored var cameraData: CameraData
    @ObservationIgnored private var cameraPhotoCaptureDelegate: CameraPhotoCaptureDelegate!

    init() {
        cameraData = CameraData()
        cameraPhotoCaptureDelegate = CameraPhotoCaptureDelegate(
            onPictureTaken: {
                self.picture = $0
                self.showCameraUI = false
            },
            requestRotationAngle: {
                self.cameraData.rotationCoordinator!.videoRotationAngleForHorizonLevelCapture
            }
        )

        Task { @MainActor in // await MainActor.run
            myCameraPreview = MyCameraPreview()
        }
    }

    func requestCameraPermission() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        debugPrint("Authorization status: \(status)")

        let granted = await AVCaptureDevice.requestAccess(for: .video)

        guard granted else { return }

        await MainActor.run {
            prepareCamera()
        }
    }

    private func prepareCamera() {
        cameraData.captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        cameraData.captureSession = AVCaptureSession()

        if let _ = try? cameraData.captureDevice?.lockForConfiguration() {
            // Monitor orientation changes
            cameraData.captureDevice?.isSubjectAreaChangeMonitoringEnabled = true
            cameraData.captureDevice?.unlockForConfiguration()
        }

        guard let captureDevice = cameraData.captureDevice else { return }

        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        cameraData.captureSession?.addInput(input)
        
        let output = AVCapturePhotoOutput()

        cameraData.output = output
        cameraData.captureSession?.addOutput(output)
        
        if let maxPhotoDimension = captureDevice.activeFormat.supportedMaxPhotoDimensions.last {
            output.maxPhotoDimensions = maxPhotoDimension
        }

        showCameraPreview()
    }

    private func showCameraPreview() {
        Task {
            await MainActor.run {
                guard let previewLayer = myCameraPreview.uiView.layer as? AVCaptureVideoPreviewLayer else { return }
                previewLayer.session = cameraData.captureSession

                guard let captureDevice = cameraData.captureDevice else { return }
                let rotationCoordinator = AVCaptureDevice.RotationCoordinator(device: captureDevice, previewLayer: previewLayer)

                cameraData.rotationCoordinator = rotationCoordinator

                previewLayer.connection?.videoRotationAngle = rotationCoordinator.videoRotationAngleForHorizonLevelPreview

                cameraData.rotationObserver = rotationCoordinator.observe(
                    \.videoRotationAngleForHorizonLevelPreview,
                    changeHandler: { coordinator, newRotation in
                        debugPrint("coordinator: \(coordinator), newRotation: \(newRotation)")
                        
                        previewLayer.connection?.videoRotationAngle = rotationCoordinator.videoRotationAngleForHorizonLevelPreview
                    }
                )
            }

            cameraData.captureSession?.startRunning()
        }
    }

    func takePicture() {
        let captureSettings = AVCapturePhotoSettings()

        if let maxPhotoDimension = cameraData.captureDevice?.activeFormat.supportedMaxPhotoDimensions.last {
            captureSettings.maxPhotoDimensions = maxPhotoDimension
        }

        captureSettings.flashMode = AVCaptureDevice.FlashMode.on

        cameraData.output?.capturePhoto(with: captureSettings, delegate: cameraPhotoCaptureDelegate)
    }
}

class CameraPhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    let onPictureTaken: (UIImage) -> Void
    let requestRotationAngle: () -> CGFloat

    init(onPictureTaken: @escaping (UIImage) -> Void, requestRotationAngle: @escaping () -> CGFloat) {
        self.onPictureTaken = onPictureTaken
        self.requestRotationAngle = requestRotationAngle
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        Task { @MainActor in
            let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let currentSceneScale = currentScene?.screen.scale ?? 1

            var pictureOrientation: UIImage.Orientation

            let rotationAngle = requestRotationAngle()

            switch rotationAngle {
            case 90.0:
                pictureOrientation = .right
            case 270.0:
                pictureOrientation = .left
            case 0.0:
                pictureOrientation = .up
            case 180.0:
                pictureOrientation = .down
            default:
                pictureOrientation = .right
            }

            if let pictureCGImage = photo.cgImageRepresentation() {
                onPictureTaken(UIImage(cgImage: pictureCGImage, scale: currentSceneScale, orientation: pictureOrientation))
            }
        }
    }
}
