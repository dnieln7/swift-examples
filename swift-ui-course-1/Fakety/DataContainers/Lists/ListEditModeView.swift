//
//  ListEditModeView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 15/10/24.
//

import SwiftUI

struct ListEditModeView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

//    @State private var selectionMode: Bool = false
//    @State private var editActive:Bool = false
    @State private var selectedRow: Book.ID? = nil
    @State private var selectedRows: Set<Book.ID> = []

    var body: some View {
        VStack {
//            if selectionMode {
//                Button("Remove selected", action: removeSelected)
//                    .buttonStyle(.borderedProminent)
//                    .disabled(selectedRows.count == 0 ? true : false)
//                Button("Disable selection mode", action: { selectionMode.toggle() })
//                    .buttonStyle(.bordered)
//                    .padding()
//            } else {
//                Button("Enable selection mode", action: { selectionMode.toggle() })
//                    .buttonStyle(.borderedProminent)
//                    .padding()
//            }
            EditButton()
//            Button(editActive ? "Done" : "Edit") {
//                editActive.toggle()
            }
            List(
                selection: $selectedRow // If not dependen on ternary could be used with edit button
            ) {
                ForEach(applicationData.books) { book in
                // Using the bindable struct we can change the state of each book
//                ForEach(Bindable(applicationData).books) { $book in
                    BookListTile(book: book)
                }
                .onDelete { indexSet in
                    applicationData.books.remove(atOffsets: indexSet)
//                    editActive = false
                }
                .onMove { source, destination in
                    applicationData.books.move(fromOffsets: source, toOffset: destination)
                }
            }
            .onChange(of: selectedRow) { old, new in
                print("old: \(old), new: \(new)")
            }
//            .environment(\.editMode, .constant(editActive ? EditMode.active : EditMode.inactive))
//        }
    }

//    func removeSelected() {
//        if let index = applicationData.books.firstIndex(where: { $0.id == selectedRow }) {
//            applicationData.books.remove(at: index)
//            selectedRow = nil
//        }
//    }

    func removeSelected() {
        var indexes = IndexSet()

        for selectedRow in selectedRows {
            if let index = applicationData.books.firstIndex(where: { $0.id == selectedRow }) {
                indexes.insert(index)
            }
        }

        applicationData.books.remove(atOffsets: indexes)
        selectedRows = []
    }
}

fileprivate struct BookListTile: View {
    let book: Book

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(
                url: URL(string: book.cover),
                content: { image in
                    image.resizable()
                },
                placeholder: { Color.white }
            )
            .scaledToFit()
            .frame(width: 80, height: 100)
            VStack(alignment: .leading, spacing: 2) {
                Text(book.title)
                    .bold()
                Text(book.author)
                Text(book.displayYear)
                    .font(.caption)
            }
            .padding(.top, 5)
            Spacer()
        }
    }
}

#Preview {
    ListEditModeView()
        .environment(ApplicationData())
}
