//
//  ResponseType.swift
//  jsonfeed
//
//  Created by Ivan Liljeqvist on 2017-06-20.
//  Copyright © 2017 Ivan. All rights reserved.
//

import Foundation

enum ResponseType {
    
    case articleRequestSucceeded(response:[NSDictionary])
    
    case requestFailed
    case invalidResponse
    
}
