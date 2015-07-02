//
//  Domains.swift
//  posty_Mobile
//
//  Created by admin on 26.05.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Foundation

public class APIRepository: NSObject
{
    public class var sharedInstance: APIRepository
    {
        struct Singleton
        {
            static let instance = APIRepository()
        }
        
        return Singleton.instance
    }
    
    let apiList : [API] = [API(caption: "API Default", url: "http://78.46.85.252/posty_api/api/v1", authKey: "2643cec3ff101e8c7e0f8be2f5238982")]
    
    var currentAPI: API {
        get {
            return apiList[0]
        }
    }
}

