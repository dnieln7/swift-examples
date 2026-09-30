//
//  PhotosPickerView.swift
//  examples-media
//
//  Created by Daniel Nolasco on 05/05/25.
//

import PhotosUI
import SwiftUI

struct PhotosPickerView: View {
    @State private var selection: PhotosPickerItem?
    @State private var picture: UIImage?

    @State private var selections: [PhotosPickerItem] = []
    @State private var pictures: [UIImage] = []

    var body: some View {
        VStack {
            if picture != nil {
                Image(uiImage: picture!)
                    .resizable()
                    .scaledToFit()
            }
            if pictures.count > 0 {
                ScrollView {
                    LazyVStack {
                        ForEach(pictures, id: \.self) { pic in
                            Image(uiImage: pic)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .frame(height: 400)
                .background(.gray)
            }
            Spacer()
//            PhotosPicker(selection: $selection, matching: .images, photoLibrary: .shared()) {
//                Text("Choose a photo")
//            }
//            .buttonStyle(.borderedProminent)
//            .photosPickerStyle(.inline) // Default
//            .photosPickerDisabledCapabilities([.collectionNavigation, .search])
//            .photosPickerAccessoryVisibility(.hidden) // Hide cancel/add options
            PhotosPicker(selection: $selections, selectionBehavior: .continuous, matching: .images, photoLibrary: .shared()) {
                Text("Choose some photos")
            }
            .buttonStyle(.borderedProminent)
            .photosPickerStyle(.presentation) // Default
        }
        .onChange(of: selection, initial: false) { _, new in
            Task(priority: .background) {
                debugPrint(new?.itemIdentifier ?? "nil identifier")

                if let data = try? await new?.loadTransferable(type: Data.self) {
                    picture = UIImage(data: data)
                }
            }
        }
        .onChange(of: selections, initial: false) { _, new in
            Task(priority: .background) {
                pictures = []

                for selection in new {
                    if let data = try? await selection.loadTransferable(type: Data.self) {
                        pictures.append(UIImage(data: data)!)
                    }
                }
            }
        }
    }
}

#Preview {
    PhotosPickerView()
}
