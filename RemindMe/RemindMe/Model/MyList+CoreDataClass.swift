//
//  MyList+CoreDataClass.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 10/12/24.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    
    var remindersAsArray: [Reminder] {
        reminders.allObjects.compactMap { object in
            (object as! Reminder)
        }
    }
}

