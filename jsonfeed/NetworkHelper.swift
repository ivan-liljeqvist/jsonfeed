//
//  NetworkHelper.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//  Copyright © 2017 Ivan. All rights reserved.
//



import Foundation
import Alamofire

class NetworkHelper{
    
    static var articleUrl = "https://applefocus.com/feed.json"
    
    /*
        Try to get the url from the Settings app
     */
    class func initFromSettings(){
        
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
       
        if let feedUrl = UserDefaults.standard.string(forKey: "feed_url"){
            articleUrl = feedUrl
        }
        
    }
    
    /*
    
     Fetch articles from the network and return an array of articles as NSDictionaries
    if everything went as planned, return error responses otherwise.
     
     */
    class func fetchArticleJSON(completion:@escaping (ResponseType)->Void){
        
        // do a network request to fetch the article data
        Alamofire.request(NetworkHelper.articleUrl).responseJSON { response in
            
            if(response.response?.statusCode == 200){
                
                if let rawJson = response.result.value,
                   let jsonDic = rawJson as? NSDictionary{
                    
                    // strip the "header data" like the version, feed_url etc
                    if let articlesDicts = jsonDic["items"] as? [NSDictionary]{
                                                
                        // JSON retrieved
                        completion(.articleRequestSucceeded(response: articlesDicts))
                    }
                    else{
                        completion(.invalidResponse)
                    }
                    
                    
                }
                else{
                    // couldn't retrieve JSON
                    completion(.invalidResponse)
                }
                
            }
            else{
                
                // request failed
                completion(.requestFailed)
                
            }
            

        }
        
    }
    
}
