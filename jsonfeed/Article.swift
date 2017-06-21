//
//  Article.swift
//  
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//
//

import Foundation
import UIKit
import CoreData

public class Article: NSManagedObject {
    
    // need init() this to fetch from Core Data
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    // init from dictionary
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
                
                
                if let date = Utils.dateFormatter().date(from: dateString){
                    self.datePublished = date as NSDate
                }
     
           
            }
            
            // parse author
            if let authorDict = dic["author"] as? NSDictionary{
                
                let author = Author(withDictionary: authorDict, andContext: context)
                author.addToArticles(self)
                
            }
            
            // save the article
            do{
               try context.save()
            }
            catch _{
                print("couldn't save article to core data!")
            }
            
            
        }
        else{
            fatalError("Couldn't get entity description for Article! Can't continue.. RIP")
        }
    
        
        
    }

}


// functionality for loading articles
extension Article{
    
    
    // load from the Internet
    class func fetchOnline(completion:@escaping ([Article])->Void){
        
        var articles:[Article] = []
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            
            let context = appDelegate.persistentContainer.viewContext
            
            // do network request
            NetworkHelper.fetchArticleJSON(completion: { (response) in
                
                switch(response){
                    
                case ResponseType.articleRequestSucceeded(let articlesDicts):
                    
                    // parse articles
                    for articleDict in articlesDicts{
                        articles.append(Article(withDictionary: articleDict, andContext: context))
                    }
                    
                    articles = Article.sortArticles(articles: articles)
                    completion(articles)
                    
                    
                    break
                    
                // failed to fetch articles from the network
                default:
                    completion(articles)
                    break
                    
                }
            })
        }
        else{
            completion(articles)
        }
    
    }
    
    
    // load from Core Data
    class func fetchOffline(completion:@escaping ([Article])->Void){
        
        var articles:[Article] = []
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<Article>(entityName:"Article")
            request.returnsObjectsAsFaults = false
            
            do{
                articles = try context.fetch(request)
                completion(articles)
            }
            catch _{
                // couldn't fetch from core data
                completion(articles)
            }
        
        }
        else{
            completion(articles)
        }
        
        
    }
    
}


// util functions for manipulating Article objects
extension Article{
    
    class func sortArticles(articles:[Article]) -> [Article]{
        
        let calendar = Calendar.current
        
        return articles.sorted {
            
            // try to unwrap dates
            if let dateA = $0.datePublished as Date?,
                let dateB = $1.datePublished as
                    Date?{
                
                let elapsed0 = dateA.timeIntervalSince(calendar.startOfDay(for: dateA))
                let elapsed1 = dateB.timeIntervalSince(calendar.startOfDay(for: dateB))
                return elapsed0 < elapsed1
                
            }
                // if can't unrap date
            else{
                return true
            }
            
            
        }
    }
    
}
