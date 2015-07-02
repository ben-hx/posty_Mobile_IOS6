//
//  Domains.swift
//  posty_Mobile
//
//  Created by admin on 26.05.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures


public class DomainApiManagerOld
{
  


}

class Domain3
{
    var id = 0
    var name = ""
    
    init(id: Int, name: String)
    {
        self.id = id
        self.name = name
    }
    
    internal static func fromJSON(json: JSON) -> Domain3 {
        
        return Domain3(id: json["id"].int!,
                      name: json["name"].stringValue)
    }
}


