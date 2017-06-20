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
    
    class func fetchArticleJSON(){
        
        Alamofire.request(NetworkHelper.ARTICLE_URL).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
    }
    
}
