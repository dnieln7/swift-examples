//
//  ReminderService.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 11/12/24.
//

import CoreData
import Foundation
import UIKit

class ReminderService {
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistentContainer.viewContext
    }

    static func saveMyList(name: String, color: UIColor) throws {
        let myList = MyList(context: viewContext)

        myList.name = name
        myList.color = color

        try viewContext.save()
    }

    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)

        reminder.title = reminderTitle

        myList.addToReminders(reminder)

        try viewContext.save()
    }

    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let fetchRequest = Reminder.fetchRequest()
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "owner == %@ AND isCompleted == false", myList)

        return fetchRequest
    }

    static func getRemindersByQuery(query: String) -> NSFetchRequest<Reminder> {
        let fetchRequest = Reminder.fetchRequest()
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)

        return fetchRequest
    }

    static func remindersByStatType(reminderStatType: ReminderStatType) -> NSFetchRequest<Reminder> {
        let fetchRequest = Reminder.fetchRequest()
        fetchRequest.sortDescriptors = []

        switch reminderStatType {
        case .today:
            let today = Date().atStartOfDay()
            let tomorrow = today.plusDays(1)

            let dateFrom: NSDate = today as NSDate
            let dateTo: NSDate = tomorrow as NSDate

            let predicate1 = NSPredicate(format: "alertDate BETWEEN {%@, %@}", dateFrom, dateTo)
            let predicate2 = NSPredicate(format: "alertTime BETWEEN {%@, %@}", dateFrom, dateTo)

            fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])
        case .scheduled:
            fetchRequest.predicate = NSPredicate(format: "(alertDate != nil OR alertTime != nil) AND isCompleted == false")
        case .completed:
            fetchRequest.predicate = NSPredicate(format: "isCompleted == true")
        case .all:
            fetchRequest.predicate = NSPredicate(format: "isCompleted == false")
        }

        return fetchRequest
    }

    static func updateReminder(reminder: Reminder, reminderEditConfig: ReminderEditConfig) throws -> Bool {
        let reminderToUpdate = reminder

        reminderToUpdate.title = reminderEditConfig.title
        reminderToUpdate.notes = reminderEditConfig.notes
        reminderToUpdate.isCompleted = reminderEditConfig.isCompleted

        reminderToUpdate.alertDate = reminderEditConfig.hasDate ? reminderEditConfig.alertDate : nil
        reminderToUpdate.alertTime = reminderEditConfig.hasTime ? reminderEditConfig.alertTime : nil

        try viewContext.save()

        return true
    }

    static func deleteReminder(reminder: Reminder) throws {
        viewContext.delete(reminder)
        try viewContext.save()
    }
}
