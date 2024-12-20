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

    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(reminderStatType: .today))
    private var todayReminders: FetchedResults<Reminder>

    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(reminderStatType: .scheduled))
    private var scheduledReminders: FetchedResults<Reminder>

    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(reminderStatType: .completed))
    private var completedReminders: FetchedResults<Reminder>

    @FetchRequest(fetchRequest: ReminderService.remindersByStatType(reminderStatType: .all))
    private var allReminders: FetchedResults<Reminder>

    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var isSearching: Bool = false
    @State private var reminderStatsValues: ReminderStatsValues = ReminderStatsValues()

    private var reminderStatsBuilder: ReminderStatsBuilder = ReminderStatsBuilder()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        NavigationLink(
                            destination: {
                                ReminderListView(reminders: todayReminders)
                            },
                            label: {
                                ReminderStatsView(
                                    icon: "calendar",
                                    iconColor: .red,
                                    title: "Today",
                                    count: reminderStatsValues.todayCount
                                )
                            }
                        )

                        NavigationLink(
                            destination: {
                                ReminderListView(reminders: allReminders)
                            },
                            label: {
                                ReminderStatsView(
                                    icon: "tray.circle.fill",
                                    iconColor: .yellow,
                                    title: "All",
                                    count: reminderStatsValues.allCount
                                )
                            }
                        )
                    }
                    HStack {
                        NavigationLink(
                            destination: {
                                ReminderListView(reminders: scheduledReminders)
                            },
                            label: {
                                ReminderStatsView(
                                    icon: "calendar.circle.fill",
                                    iconColor: .blue,
                                    title: "Scheduled",
                                    count: reminderStatsValues.scheduledCount
                                )
                            }
                        )
                        NavigationLink(
                            destination: {
                                ReminderListView(reminders: completedReminders)
                            },
                            label: {
                                ReminderStatsView(
                                    icon: "checkmark.circle.fill",
                                    iconColor: .green,
                                    title: "Completed",
                                    count: reminderStatsValues.completedCount
                                )
                            }
                        )
                    }
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
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
            .onAppear {
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListFetchedResults)
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
