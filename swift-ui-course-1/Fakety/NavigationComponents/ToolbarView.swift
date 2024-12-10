//
//  ToolbarView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 22/10/24.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        NavigationStack {
            ButtonsView()
                .navigationTitle(Text("Buttons"))
                .toolbar {
                    Menu(
                        content: {
                            Button("Option 1") { print("Option 1") }
                            Button("Option 2") { print("Option 2") }
                            Button("Option 3") { print("Option 3") }
                        },
                        label: {
//                            Image(systemName: "filemenu.and.selection")
                            HStack {
                                Text("Options")
                                Image(systemName: "filemenu.and.selection")
                            }
                        }
                    )
                }
        }
    }
}

fileprivate struct TopAndBottomToolbar: View {
    var body: some View {
        NavigationStack {
            ButtonsView()
                .navigationTitle(Text("Buttons"))
                .toolbar(.visible, for: .navigationBar)
                .toolbar {
                    // can use ToolbarItem for a single action
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(
                            action: {
                                print("Create element")
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                        Button(
                            action: {
                                print("Delete element")
                            },
                            label: {
                                Image(systemName: "trash")
                            }
                        )
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button(
                            action: {
                                print("Create element")
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                    }
                    ToolbarItemGroup(placement: .secondaryAction) {
                        Button(
                            action: {
                                print("Delete element")
                            },
                            label: {
                                Label("Delete", systemImage: "trash")
                            }
                        )
                    }
                }
                .toolbarTitleDisplayMode(.inline)
        }
    }
}

fileprivate struct CustomizableToolbar: View {
    var body: some View {
        NavigationStack {
            ButtonsView()
                .navigationTitle(Text("Buttons"))
                .toolbar(id: "toolbar") {
                    // can use ToolbarItem for a single action
                    ToolbarItem(id: "create", placement: .secondaryAction) {
                        Button(
                            action: {
                                print("Create element")
                            },
                            label: {
                                Label("Create", systemImage: "plus")
                            }
                        )
                    }
                    ToolbarItem(id: "delete", placement: .secondaryAction) {
                        Button(
                            action: {
                                print("Delete element")
                            },
                            label: {
                                Label("Delete", systemImage: "trash")
                            }
                        )
                    }
                    ToolbarItem(id: "folder", placement: .secondaryAction) {
                        Button(
                            action: {
                                print("folder element")
                            },
                            label: {
                                Label("Delete", systemImage: "folder.fill.badge.plus")
                            }
                        )
                    }
                }
                .toolbarRole(.editor)
        }
    }
}

#Preview {
    ToolbarView()
}
