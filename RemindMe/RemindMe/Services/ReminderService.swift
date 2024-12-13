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
}
