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

public class DomainAliasRepository
{
    let util: ApiManagerUtil
    let domain: Domain
    var baseUrl: String {
        get {
            return "/domains/\(domain.name)/aliases"
        }
    }
    
    init(manager: Manager, domain: Domain)
    {
        self.util = ApiManagerUtil(manager: manager)
        self.domain = domain
    }
    
    func getByName(name: String) -> Future<DomainAlias> {
        return util.objectRequest(ResourceRouter.GetSingle(resource: "\(baseUrl)/\(name)"))
    }
    
    func getAll() -> Future<[DomainAlias]> {
        return util.collectionRequest(ResourceRouter.GetAll(resource: "\(baseUrl)"))
    }
    
    func create(alias: DomainAlias) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Create(resource: "\(baseUrl)", params: alias.toDictionary()))
    }
    
    func update(name: String, alias: DomainAlias) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Update(resource: "\(baseUrl)/\(name)", params: alias.toDictionary()))
    }
    
    func delete(name: String) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Destroy(resource: "\(baseUrl)/\(name)"))
    }
}




