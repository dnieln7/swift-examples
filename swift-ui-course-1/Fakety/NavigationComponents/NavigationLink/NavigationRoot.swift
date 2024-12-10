//
//  NavigationRoot.swift
//  Fakety
//
//  Created by Daniel Nolasco on 23/10/24.
//

import SwiftUI

struct NavigationRoot: View {
    var body: some View {
        WithNavigationPath()
    }
}

fileprivate struct WithNavigationPath: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData
    
    // Can also be in the model and used with the Bindable wrapper
    @State private var navigationPath: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(applicationData.books) { book in
                NavigationLink(
                    value: book,
                    label: {
                        GenericBookListTile(book: book)
                    }
                )
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        value: Destinations.toggle,
                        label: {
                            Image(systemName: "pencil")
                        }
                    )
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        value: Destinations.settings,
                        label: {
                            Image(systemName: "gear")
                        }
                    )
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .navigationDestination(for: Destinations.self) { destination in
                switch destination {
                case .toggle:
                    ToggleSliderView()
                case .settings:
                    SettingsView(navigationPath: $navigationPath)
                }
            }
        }
    }
}

fileprivate struct WithList: View {
    @Environment(ApplicationData.self) private var applicationData: ApplicationData

    var body: some View {
        NavigationStack {
            List(applicationData.books) { book in
                NavigationLink(
                    destination: {
                        BookDetailView(book: book)
                    },
                    label: {
                        GenericBookListTile(book: book)
                    }
                )
            }
            .navigationTitle("Books")
        }
    }
}

fileprivate struct WithToolbar: View {
    var body: some View {
        NavigationStack {
            ButtonsView()
                .navigationTitle("Buttons")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(
                            destination: ToggleSliderView(),
                            label: {
                                Image(systemName: "pencil")
                            }
                        )
                    }
                }
        }
    }
}

#Preview {
    NavigationRoot()
        .environment(ApplicationData())
}
