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
        
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: context){
            
            super.init(entity: entityDescription, insertInto: context)
            
            // parse title
            self.title = dic["title"] as? String
            
            // parse external url
            self.externalUrlString = dic["external_url"] as? String
            
            // parse content text
            self.contentText = dic["content_text"] as? String
            
            //parse banner img url
            self.bannerImageUrlString = dic["banner_image"] as? String
            
            // parse date
            if let dateString = dic["date_published"] as? String {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = Constants.DATE_FORMAT
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                if let date = dateFormatter.date(from: dateString){
                    self.datePublished = date as NSDate
                }
     
           
            }
            
            // parse author
            if let authorDict = dic["author"] as? NSDictionary{
                
                let author = Author(withDictionary: authorDict, andContext: context)
                author.addToArticles(self)
                
            }
            
        }
        else{
            fatalError("Couldn't get entity description for Article! Can't continue.. RIP")
        }
    
        
        
    }

}
