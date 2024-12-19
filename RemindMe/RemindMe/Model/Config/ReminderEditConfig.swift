//
//  ReminderEditConfig.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 16/12/24.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasDate: Bool = false
    var hasTime: Bool = false
    var alertDate: Date?
    var alertTime: Date?

    init() {}

    init(reminder: Reminder) {
        title = reminder.title ?? ""
        notes = reminder.notes
        isCompleted = reminder.isCompleted
        hasDate = reminder.alertDate != nil
        hasTime = reminder.alertTime != nil
        alertDate = reminder.alertDate
        alertTime = reminder.alertTime
    }
}
