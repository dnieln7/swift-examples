//
//  ReminderListView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 13/12/24.
//

import SwiftUI

struct ReminderListView: View {
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false

    let reminders: FetchedResults<Reminder>

    var body: some View {
        List(reminders) { reminder in
            ReminderListTileView(
                reminder: reminder,
                isSelected: isReminderSelected(reminder: reminder),
                onAction: { action in
                    switch action {
                    case let .onCheckChanged(reminder, isChecked):
                        reminderCheckChanged(reminder: reminder, isCompleted: isChecked)
                    case let .onClick(reminder):
                        selectedReminder = reminder
                    case .onInfoClick:
                        showReminderDetail = true
                    }
                }
            )
            .swipeActions(edge: .leading) {
                Button(
                    role: .destructive,
                    action: {
                        deleteReminder(reminder: reminder)
                    },
                    label: {
                        Image(systemName: "trash")
                    }
                )
            }
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }

    private func isReminderSelected(reminder: Reminder) -> Bool {
        return selectedReminder?.objectID == reminder.objectID
    }

    private func reminderCheckChanged(reminder: Reminder, isCompleted: Bool) {
        var reminderEditConfig = ReminderEditConfig(reminder: reminder)

        reminderEditConfig.isCompleted = isCompleted

        do {
            let success = try ReminderService.updateReminder(reminder: reminder, reminderEditConfig: reminderEditConfig)

            print("Reminder updated: \(success)")
        } catch {
            print("Error updating reminder: \(error)")
        }
    }
    
    private func deleteReminder(reminder: Reminder) {
        do {
            try ReminderService.deleteReminder(reminder: reminder)
        } catch {
            print("Error deleting reminder: \(error)")
        }
    }
}

// #Preview {
//    ReminderListView()
// }
