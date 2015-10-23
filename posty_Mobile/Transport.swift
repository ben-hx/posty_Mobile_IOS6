//
//  Transport.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import SwiftyJSON

final class Transport: ResponseObjectSerializable, ResponseCollectionSerializable, Equatable {
    var id: Int
    var name: String
    var destination: String
    
    @objc static func collection(representation: AnyObject) -> [Transport] {
        var result = [Transport]()
        let jsonList: Array<JSON> = JSON(representation).arrayValue
        for value in jsonList {
            result.append(Transport(representation: value.object)!)
        }
        return result
    }
    
    @objc required init?(name: String, destination: String) {
        self.id = 0;
        self.name = name;
        self.destination = destination;
    }
    
    @objc required init?(representation: AnyObject) {
        let json = JSON(representation)["virtual_transport"]
        self.id = json["id"].int!
        self.name = json["name"].stringValue
        self.destination = json["destination"].stringValue
    }
    
    func toDictionary() -> [String: AnyObject] {
        var result = [String: AnyObject]()
        result["id"] = self.id
        result["name"] = self.name
        result["destination"] = self.destination
        return result
    }
}

func ==(lhs: Transport, rhs: Transport) -> Bool {
    return lhs.name == rhs.name && lhs.destination == rhs.destination
}