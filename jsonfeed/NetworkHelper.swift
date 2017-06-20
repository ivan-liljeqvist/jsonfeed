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
    
    static let ARTICLE_URL = "https://applefocus.com/feed.json"
    
    /*
    
     Fetch articles from the network and return an array of articles as NSDictionaries
    if everything went as planned, return error responses otherwise.
     
     */
    class func fetchArticleJSON(completion:@escaping (ResponseType)->Void){
        
        // do a network request to fetch the article data
        Alamofire.request(NetworkHelper.ARTICLE_URL).responseJSON { response in
            
            if(response.response?.statusCode == 200){
                
                if let rawJson = response.result.value,
                   let jsonDic = rawJson as? NSDictionary{
                    
                    // strip the "header data" like the version, feed_url etc
                    if let articlesJson = jsonDic["items"] as? [NSDictionary]{
                                                
                        // JSON retrieved
                        completion(.articleRequestSucceeded(response: articlesJson))
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
