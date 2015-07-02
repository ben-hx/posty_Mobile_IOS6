//
//  API.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

class API
{
    var caption = ""
    var url = ""
    var authKey = ""
    
    init(caption: String, url: String, authKey: String)
    {
        self.caption = caption
        self.url = url
        self.authKey = authKey
    }
    
}