//
//  HomeView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 10/12/24.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListFetchedResults: FetchedResults<MyList>

    @FetchRequest(sortDescriptors: [])
    private var reminderSearchResults: FetchedResults<Reminder>

    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var isSearching: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    MyListView(myLists: myListFetchedResults)
                    Button(
                        action: { isPresented.toggle() },
                        label: {
                            Text("Add List")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.headline)
                        }
                    )
                    .padding()
                }
            }
            .navigationTitle("Reminders")
            .padding()
            .onChange(of: search) { _, query in
                isSearching = !query.isEmptyOrWhitespace
                reminderSearchResults.nsPredicate = ReminderService.getRemindersByQuery(
                    query: query
                ).predicate
            }
            .overlay(alignment: .center) {
                ReminderListView(reminders: reminderSearchResults)
                    .opacity(isSearching ? 1.0 : 0.0)
            }
            .sheet(isPresented: $isPresented) {
                NavigationView { // Needed for the toolbar to be displayed
                    AddNewListView(
                        onSave: { name, color in
                            do {
                                try ReminderService.saveMyList(name: name, color: color)
                            } catch {
                                print("Error saving list: \(error)")
                            }
                        }
                    )
                }
            }
        }
        .searchable(text: $search)
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext,
                     CoreDataProvider.shared.persistentContainer.viewContext)
}
