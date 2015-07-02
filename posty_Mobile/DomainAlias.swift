//
//  DomainAlias.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import SwiftyJSON

final class DomainAlias: ResponseObjectSerializable, ResponseCollectionSerializable {
    var id: Int
    var name: String
    
    @objc static func collection(representation: AnyObject) -> [DomainAlias] {
        var result = [DomainAlias]()
        let jsonList: Array<JSON> = JSON(representation).arrayValue
        for value in jsonList {
            result.append(DomainAlias(representation: value.object)!)
        }
        return result
    }
    
    @objc required init?(name: String) {
        self.id = 0;
        self.name = name;
    }
    
    @objc required init?(representation: AnyObject) {
        let json = JSON(representation)["virtual_domain_alias"]
        self.id = json["id"].int!
        self.name = json["name"].stringValue
    }
    
    func toDictionary() -> [String: AnyObject] {
        var result = [String: AnyObject]()
        result["id"] = self.id
        result["name"] = self.name
        return result
    }
}