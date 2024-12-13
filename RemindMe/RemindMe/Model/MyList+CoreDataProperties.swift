//
//  MyList+CoreDataProperties.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 10/12/24.
//

import CoreData
import Foundation
import UIKit

extension MyList {
    @NSManaged public var name: String
    @NSManaged public var color: UIColor

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }
}

extension MyList: Identifiable {
    
}
