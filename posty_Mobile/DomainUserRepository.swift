//
//  DomainUserRepository.swift
//  posty_Mobile
//
//  Created by admin on 29.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures

public class DomainUserRepository: ApiRepositoryBase
{
    let domain: Domain
    var baseUrl: String {
        get {
            return "/domains/\(domain.name)/users"
        }
    }
    
    init(manager: Manager, domain: Domain)
    {
        self.domain = domain
        super.init(manager: manager)
    }
    
    func getByName(name: String) -> Future<DomainUser> {
        return util.objectRequest(ResourceRouter.GetSingle(resource: "\(baseUrl)/\(name)"))
    }
    
    func getAll() -> Future<[DomainUser]> {
        return util.collectionRequest(ResourceRouter.GetAll(resource: "\(baseUrl)"))
    }
    
    func create(user: DomainUser) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Create(resource: "\(baseUrl)", params: user.toDictionary()))
    }
    
    func update(name: String, user: DomainUser) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Update(resource: "\(baseUrl)/\(name)", params: user.toDictionary()))
    }
    
    func delete(name: String) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Destroy(resource: "\(baseUrl)/\(name)"))
    }
}