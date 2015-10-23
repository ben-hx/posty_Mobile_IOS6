//
//  APIKeyRepository.swift
//  posty_Mobile
//
//  Created by admin on 01.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures

public class APIKeyRepository: ApiRepositoryBase
{
    func getByName(token: String) -> Future<APIKey> {
        return util.objectRequest(ResourceRouter.GetSingle(resource: "/api_keys/\(token)"))
    }
    
    func getAll() -> Future<[APIKey]> {
        return util.collectionRequest(ResourceRouter.GetAll(resource: "/api_keys"))
    }
    
    func create(apiKey: APIKey) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Create(resource: "/api_keys", params: apiKey.toDictionary()))
    }
    
    func update(token: String, apiKey: APIKey) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Update(resource: "/api_keys/\(token)", params: apiKey.toDictionary()))
    }
    
    func delete(token: String) -> Future<Bool> {
        return util.boolRequest(ResourceRouter.Destroy(resource: "/api_keys/\(token)"))
    }
}




