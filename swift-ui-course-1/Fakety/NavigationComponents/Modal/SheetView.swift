//
//  SheetView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 24/10/24.
//

import SwiftUI

struct SheetView: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    @State private var showSheet: Bool = false
    @State private var editBook: Book? = nil

    var body: some View {
        NavigationStack {
            List(applicationData.books) { book in
                GenericBookListTile(book: book)
                    .onTapGesture {
                        editBook = book
                    }
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        action: {
                            showSheet = true
                        },
                        label: {
                            Image(systemName: "plus")
                        }
                    )
                }
            }
            .sheet(isPresented: $showSheet) {
                AddBookSheet()
                    .presentationDragIndicator(.visible)
                    .presentationBackground(.thinMaterial)
//                    .presentationDetents([.medium])
//                    .presentationDetents([.height(250)])
                    .presentationDetents([.fraction(0.75)])
            }
            .sheet(item: $editBook) { book in
                EditBookSheet(book: book)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

fileprivate struct AddBookSheet: View {
    @Environment(\.dismiss) private var dismissSheet: DismissAction

    var body: some View {
        VStack {
            Text("Book will be added here...")
                .font(.largeTitle)
                .padding()
            Button("Close") {
                dismissSheet()
            }
        }
        .padding()
    }
}

fileprivate struct EditBookSheet: View {
    @Environment(\.dismiss) private var dismissSheet: DismissAction

    let book: Book

    var body: some View {
        VStack {
            Text("Book will be edited here...")
                .font(.largeTitle)
                .padding()
            Text(String(describing: book))
                .font(.largeTitle)
                .padding()
        }
        .padding()
    }
}

#Preview {
    SheetView()
        .environment(ApplicationData())
}
