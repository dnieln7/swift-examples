//
//  HomeView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 10/12/24.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>

    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                MyListView(myList: myListResults)
                Spacer()
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
        .padding()
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext,
                     CoreDataProvider.shared.persistentContainer.viewContext)
}
