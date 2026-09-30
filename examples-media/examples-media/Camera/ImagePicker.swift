//
//  ImagePicker.swift
//  examples-media
//
//  Created by Daniel Nolasco on 06/05/25.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    let onNewPicture: (UIImage) -> Void
    let onCancel: () -> Void

    init(onNewPicture: @escaping (UIImage) -> Void, onCancel: @escaping () -> Void) {
        self.onNewPicture = onNewPicture
        self.onCancel = onCancel
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePickerController = UIImagePickerController()

        imagePickerController.delegate = context.coordinator

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = ["public.image"]
            imagePickerController.allowsEditing = true
            imagePickerController.cameraCaptureMode = .photo
        }

        return imagePickerController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }

    func makeCoordinator() -> CameraCoordinator {
        return CameraCoordinator(onNewPicture: onNewPicture, onCancel: onCancel)
    }
}

class CameraCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let onNewPicture: (UIImage) -> Void
    let onCancel: () -> Void

    init(onNewPicture: @escaping (UIImage) -> Void, onCancel: @escaping () -> Void) {
        self.onNewPicture = onNewPicture
        self.onCancel = onCancel
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        onCancel()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let newPicture = info[.originalImage] as? UIImage {
            onNewPicture(newPicture)
        }
    }
}
