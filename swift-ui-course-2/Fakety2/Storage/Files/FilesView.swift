//
//  FilesView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 25/12/24.
//

import SwiftUI

struct FilesView: View {
    private let filesHelper: DummyFileManager = DummyFileManager.shared

    @State private var showSheet: Bool = false

    var body: some View {
        NavigationStack {
            List(filesHelper.dummyFiles) { file in
                NavigationLink(destination: FileView(fileName: file.name)) {
                    Text(file.name)
                }
                .swipeActions(edge: .leading) {
                    Button(
                        role: .destructive,
                        action: {
                            DummyFileManager.shared.delete(name: file.name)
                        },
                        label: {
                            Label("", systemImage: "trash")
                        }
                    )
                    .labelsHidden()
                }
            }
            .navigationTitle("Files")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New file") {
                        showSheet = true
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                NewFileSheetView()
            }
        }
    }
}

#Preview {
    FilesView()
}
