//
//  APIKey.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import SwiftyJSON

final class APIKey: ResponseObjectSerializable, ResponseCollectionSerializable, Equatable {
    var id: Int
    var token: String
    var active: Bool
    
    @objc static func collection(representation: AnyObject) -> [APIKey] {
        var result = [APIKey]()
        let jsonList: Array<JSON> = JSON(representation).arrayValue
        for value in jsonList {
            result.append(APIKey(representation: value.object)!)
        }
        return result
    }
    
    @objc required init?(token: String) {
        self.id = 0;
        self.token = token;
        self.active = false;
    }
    
    @objc required init?(representation: AnyObject) {
        let json = JSON(representation)["api_key"]
        self.id = json["id"].int!
        self.token = json["access_token"].stringValue
        self.active = json["active"].boolValue
    }
    
    func toDictionary() -> [String: AnyObject] {
        var result = [String: AnyObject]()
        result["id"] = self.id
        result["token"] = self.token
        result["active"] = self.active
        return result
    }
}

func ==(lhs: APIKey, rhs: APIKey) -> Bool {
    return lhs.token == rhs.token
}