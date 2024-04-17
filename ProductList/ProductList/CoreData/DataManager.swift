//
//  DataManager.swift
//  ProductList
//
//  Created by u2233825 on 07/04/24.
//

import Foundation
import CoreData

enum StorageType {
    case persistent, inMemory
}

class DataManager {
    var storageType: StorageType = .persistent
    init(_ storageType: StorageType = .persistent) {
        self.storageType = storageType
    }
    // .inMemory  writes data to /dev/null/ instead of an actual SQLite file. This will help us in unit testing.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductList")
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Core Data Saving support
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
