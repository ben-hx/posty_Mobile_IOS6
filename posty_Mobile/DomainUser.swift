//
//  DomainUser.swift
//  posty_Mobile
//
//  Created by admin on 29.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import SwiftyJSON

final class DomainUser: ResponseObjectSerializable, ResponseCollectionSerializable, Equatable {
    var id: Int
    var name: String
    var password: String
    var quota: Double
    
    @objc static func collection(representation: AnyObject) -> [DomainUser] {
        var result = [DomainUser]()
        let jsonList: Array<JSON> = JSON(representation).arrayValue
        for value in jsonList {
            result.append(DomainUser(representation: value.object)!)
        }
        return result
    }
    
    @objc required init?(name: String, password: String, quota: Double) {
        self.id = 0
        self.name = name
        self.password = password
        self.quota = quota
    }
    
    @objc required init?(representation: AnyObject) {
        let json = JSON(representation)["virtual_user"]
        self.id = json["id"].int!
        self.name = json["name"].stringValue
        self.password = json["password"].stringValue
        self.quota = json["quota"].doubleValue
    }
    
    func toDictionary() -> [String: AnyObject] {
        var result = [String: AnyObject]()
        result["id"] = self.id
        result["name"] = self.name
        result["password"] = self.password
        result["quota"] = self.quota
        return result
    }
}

func ==(lhs: DomainUser, rhs: DomainUser) -> Bool {
    return lhs.name == rhs.name
}