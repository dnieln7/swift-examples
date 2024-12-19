//
//  ReminderDetailView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 16/12/24.
//

import SwiftUI

struct ReminderDetailView: View {
    @Environment(\.dismiss) private var dismiss: DismissAction

    @State private var reminderEditConfig: ReminderEditConfig = ReminderEditConfig()

    @Binding var reminder: Reminder

    private var isFormValid: Bool {
        !reminderEditConfig.title.isEmptyOrWhitespace
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $reminderEditConfig.title)
                        TextField("Notes", text: $reminderEditConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $reminderEditConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        if reminderEditConfig.hasDate {
                            DatePicker(
                                "Select date",
                                selection: $reminderEditConfig.alertDate ?? Date(),
                                displayedComponents: .date
                            )
                        }
                        Toggle(isOn: $reminderEditConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        if reminderEditConfig.hasTime {
                            DatePicker(
                                "Select time",
                                selection: $reminderEditConfig.alertTime ?? Date(),
                                displayedComponents: .hourAndMinute
                            )
                        }
                        Section {
                            NavigationLink(
                                destination: {
                                    ListSelectorView(selectedList: $reminder.owner)
                                },
                                label: {
                                    HStack {
                                        Text("List")
                                        Spacer()
                                        Text(reminder.owner?.name ?? "owner")
                                    }
                                }
                            )
                        }
                    }
                    .onChange(of: reminderEditConfig.hasDate) { _, hasDate in
                        if hasDate {
                            reminderEditConfig.alertDate = Date()
                        }
                    }
                    .onChange(of: reminderEditConfig.hasTime) { _, hasTime in
                        if hasTime {
                            reminderEditConfig.alertTime = Date()
                        }
                    }
                }
            }
            .onAppear {
                reminderEditConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        do {
                            let success = try ReminderService.updateReminder(
                                reminder: reminder,
                                reminderEditConfig: reminderEditConfig
                            )

                            print("Reminder updated: \(success)")
                        } catch {
                            print("Error updating reminder: \(error)")
                        }
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
