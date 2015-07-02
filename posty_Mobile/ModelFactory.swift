//
//  ModelFactory.swift
//  posty_Mobile
//
//  Created by admin on 01.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire

class ModelFactory {
    
    class var sharedAPIRepositoryInstance: APIRepository
    {
        struct Singleton
        {
            static let instance = APIRepository()
        }
        
        return Singleton.instance
    }
    
    
    static func getDomainRepository() -> DomainRepository {
        return DomainRepository(manager: Alamofire.Manager.sharedInstance)
    }
    
    static func getDomainAliasRepository(domain: Domain) -> DomainAliasRepository {
        return DomainAliasRepository(manager: Alamofire.Manager.sharedInstance, domain: domain)
    }
    
    static func getDomainUserRepository(domain: Domain) -> DomainUserRepository {
        return DomainUserRepository(manager: Alamofire.Manager.sharedInstance, domain: domain)
    }

}
