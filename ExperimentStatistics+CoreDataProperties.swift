//
//  ExperimentStatistics+CoreDataProperties.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 29/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//
//

import Foundation
import CoreData


extension ExperimentStatistics {

    @nonobjc public class func getFetchRequest() -> NSFetchRequest<ExperimentStatistics> {
        return NSFetchRequest<ExperimentStatistics>(entityName: "ExperimentStatistics")
    }

    @NSManaged public var name: String?
    @NSManaged public var completed: Bool
    
    static func fetchAll() -> [ExperimentStatistics]{
        let request = getFetchRequest()
        
        do{
            let fetchResults = try PersistenceManager.context.fetch(request)
            if fetchResults.count > 0{
                return fetchResults
            }
        }catch{
            print("Couldn't fetch experiment statistics")
            print(error.localizedDescription)
        }
        
        return []
    }
    
    static func fetchByName(_ name : String) -> ExperimentStatistics?{
        let request = getFetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do{
            let fetchResults = try PersistenceManager.context.fetch(request)
            return fetchResults.first
        }catch{
            print("Couldn't fetch experiment statistics with name \(name)")
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func populate(){
        let context = PersistenceManager.context
        
        guard let properties = ExperimentPersistence.fetchAllExperimentProperties() else{
            fatalError("MISSING EXPERIMENT PROPERTIES DATA")
        }

        for prop in properties{
            let stat = ExperimentStatistics(context: context)
            stat.name = prop.storedName
            stat.completed = false
            //print(stat.name ?? "no name")
            //print(stat.completed)
        }
        
        PersistenceManager.saveContext()
    }
}
