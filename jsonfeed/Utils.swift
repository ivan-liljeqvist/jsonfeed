//
//  Constants.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-21.
//  Copyright © 2017 Ivan. All rights reserved.
//

import Foundation
import SystemConfiguration

class Utils{
    
    static let DATE_FORMAT = "EEE, dd MMM yyyy HH:mm:ss -zzzz"
    static let NORMAL_FONT = "Avenir Book"
    
    // date formatter used in several places in the app
    class func dateFormatter()->DateFormatter{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Utils.DATE_FORMAT
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
        
    }
    
    // check for internet https://stackoverflow.com/questions/38726100/best-approach-for-checking-internet-connection-in-ios
    class func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            
                
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
}

