//
//  PreviewData.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 11/12/24.
//

import Foundation
import CoreData
import UIKit

class PreviewData {
    static var myList:MyList {
        let viewContext = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? {
            let myList = MyList(context: viewContext)
            myList.name = "Test list"
            myList.color = UIColor.red
            
            return myList
        }()
    }
}
