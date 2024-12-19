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
