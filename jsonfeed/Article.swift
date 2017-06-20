//
//  Article.swift
//  
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//
//

import Foundation
import CoreData

public class Article: NSManagedObject {
    
    init(withDictionary dic:NSDictionary, andContext context:NSManagedObjectContext){
        
        super.init(entity: Article.entity(), insertInto: context)
        
        
        
    }

}
