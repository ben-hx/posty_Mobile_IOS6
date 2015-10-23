//
//  TransportRepository.swift
//  posty_Mobile
//
//  Created by admin on 01.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures

public class TransportRepository: ApiRepositoryBase
{
    func getByName(name: String) -> Future<Transport> {
        return util.objectRequest(ResourceRouter.GetSingle(resource: "/transports/\(name)"))
    }
    
    func getAll() -> Future<[Transport]> {
        return util.collectionRequest(ResourceRouter.GetAll(resource: "/transports"))
    }
    
    func create(tansport: Transport) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Create(resource: "/transports", params: tansport.toDictionary()))
    }
    
    func update(name: String, tansport: Transport) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Update(resource: "/transports/\(name)", params: tansport.toDictionary()))
    }
    
    func delete(name: String) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Destroy(resource: "/transports/\(name)"))
    }
}




