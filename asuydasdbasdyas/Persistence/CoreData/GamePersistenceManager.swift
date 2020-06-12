//
//  GamePersistentContainer.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 08/05/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import CoreData

class GamePersistenceManager : NSPersistentContainer {
   
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
   
    static var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "GameModel")
           container.loadPersistentStores { description, error in
               if let error = error {
                   fatalError("Unable to load persistent stores: \(error)")
               }
           }
           return container
       }()
    
    
    static func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = GamePersistenceManager.context
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
