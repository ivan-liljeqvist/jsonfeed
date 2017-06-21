//
//  Constants.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-21.
//  Copyright © 2017 Ivan. All rights reserved.
//

import Foundation

class Utils{
    
    static let DATE_FORMAT = "EEE, dd MMM yyyy HH:mm:ss -zzzz"
    
    // date formatter used in several places in the app
    class func dateFormatter()->DateFormatter{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Utils.DATE_FORMAT
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
        
    }
    
    
}

