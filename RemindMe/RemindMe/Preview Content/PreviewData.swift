//
//  PreviewData.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 11/12/24.
//

import CoreData
import Foundation
import UIKit

class PreviewData {
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? {
            let myList = MyList(context: viewContext)
            myList.name = "Test list"
            myList.color = UIColor.red

            return myList
        }()
    }
    
    static var reminder: Reminder {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = Reminder.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? {
            let reminder = Reminder(context: viewContext)
            reminder.title = "Test reminder"
            reminder.notes = "Test notes"
            reminder.isCompleted = false
            reminder.alertDate = Date()
            
            return reminder
        }()
    }
}
