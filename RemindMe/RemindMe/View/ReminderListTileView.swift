//
//  ReminderListTileView.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 13/12/24.
//

import SwiftUI

struct ReminderListTileView: View {

    @State private var checked: Bool = false

    let reminder: Reminder
    let isSelected: Bool
    let onAction: (ReminderListTileAction) -> Void
    
    let delay = Delay()

    var body: some View {
        HStack {
            Image(systemName: checked ? "circle.inset.filled" : "circle")
                .font(.title2)
                .opacity(0.4)
                .onTapGesture {
                    checked.toggle()
                    delay.cancel()
                    delay.doWork {
                        onAction(.onCheckChanged(reminder, checked))
                    }
                }
            VStack(alignment: .leading) {
                Text(reminder.title ?? "")
                if let notes = reminder.notes, !notes.isEmptyOrWhitespace {
                    Text(notes)
                        .font(.caption)
                        .opacity(0.4)
                }
                HStack {
                    if let date = reminder.alertDate {
                        Text(formatDate(date))
                    }
                    if let time = reminder.alertTime {
                        Text(time.formatted(date: .omitted, time: .shortened))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
                .opacity(0.4)
            }
            Spacer()
            Image(systemName: "info.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
                .onTapGesture {
                    onAction(.onInfoClick)
                }
        }
        .contentShape(Rectangle()) // Needeed to make the entire HStack clickable
        .onTapGesture {
            onAction(.onClick(reminder))
        }
    }

    private func formatDate(_ date: Date) -> String {
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
}

enum ReminderListTileAction {
    case onCheckChanged(Reminder, Bool)
    case onClick(Reminder)
    case onInfoClick
}

#Preview {
    ReminderListTileView(
        reminder: PreviewData.reminder,
        isSelected: false,
        onAction: { _ in }
    )
}
