//
//  ReminderStatsBuilder.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 19/12/24.
//

import Foundation
import SwiftUI

struct ReminderStatsBuilder {
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        let reminders = myListResults.map { list in
            list.remindersAsArray
        }.reduce([], +)

        return ReminderStatsValues(
            todayCount: calculateTodayCount(reminders: reminders),
            scheduledCount: calculateScheduledCount(reminders: reminders),
            completedCount: calculateCompletedCount(reminders: reminders),
            allCount: calculateAllCount(reminders: reminders)
        )
    }

    private func calculateTodayCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { count, reminder in
            let isToday = reminder.alertDate?.isToday ?? false
            let isTodayTime = reminder.alertTime?.isToday ?? false

            return (isToday || isTodayTime) ? count + 1 : count
        }
    }

    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { count, reminder in
            let isScheduled = reminder.alertDate != nil || reminder.alertTime != nil

            return isScheduled && !reminder.isCompleted ? count + 1 : count
        }
    }

    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { count, reminder in
            reminder.isCompleted ? count + 1 : count
        }
    }

    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { count, reminder in
            !reminder.isCompleted ? count + 1 : count
        }
    }
}

struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var completedCount: Int = 0
    var allCount: Int = 0
}

enum ReminderStatType {
    case today
    case scheduled
    case completed
    case all
}
