//
//  CoreDataProvider.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 10/12/24.
//

import CoreData
import Foundation

class CoreDataProvider {
    let persistentContainer: NSPersistentContainer

    private init() {
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistentContainer = NSPersistentContainer(name: "RemindMeModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing RemindMeModel: \(error.localizedDescription)")
            }
            
             
        }
    }

    static let shared = CoreDataProvider()
}
