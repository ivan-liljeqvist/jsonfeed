//
//  Author.swift
//  
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//
//

import Foundation
import CoreData

public class Author: NSManagedObject {
    
    // need init() this to fetch from Core Data
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    // init from dictionary
    init(withDictionary dic:NSDictionary, andContext context:NSManagedObjectContext){
        
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Author", in: context){
            
            super.init(entity: entityDescription, insertInto: context)
            
            // parse name
            self.name = dic["name"] as? String
            
            
            
        }
        else{
            fatalError("Couldn't get entity description for Author! Can't continue.. RIP")
        }
    }

}
