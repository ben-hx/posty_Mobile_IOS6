//
//  TestAPI.swift
//  posty_Mobile
//
//  Created by admin on 01.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures

public class DomainRepository
{
    let util: ApiManagerUtil
    
    init(manager: Manager)
    {
        self.util = ApiManagerUtil(manager: manager)
    }
    
    func getByName(name: String) -> Future<Domain> {
        return util.objectRequest(ResourceRouter.GetSingle(resource: "/domains/\(name)"))
    }
    
    func getAll() -> Future<[Domain]> {
        return util.collectionRequest(ResourceRouter.GetAll(resource: "/domains"))
    }

    func create(domain: Domain) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Create(resource: "/domains", params: domain.toDictionary()))
    }
    
    func update(name: String, domain: Domain) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Update(resource: "/domains/\(name)", params: domain.toDictionary()))
    }
    
    func delete(name: String) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Destroy(resource: "/domains/\(name)"))
    }
}




