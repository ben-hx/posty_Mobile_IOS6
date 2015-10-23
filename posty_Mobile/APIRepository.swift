//
//  Domains.swift
//  posty_Mobile
//
//  Created by admin on 26.05.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures

public class APIRepository: ApiRepositoryBase
{
    private struct Consts
    {
        static let CurrentAPIIndex = 0
    }
    
    // depricated: 
    // let apiList : [API] = [API(caption: "API Default", url: "http://78.46.85.252/posty_api/api/v1", authKey: "2643cec3ff101e8c7e0f8be2f5238982")]
    
    var apiList: [API] = [API(caption: "API Default", url: "", authKey: "")]
    
    var currentAPI: API {
        get {
            return apiList[Consts.CurrentAPIIndex]
        }
    }
    
    func setCurrentAPI(api: API) {
        apiList[Consts.CurrentAPIIndex] = api
    }
    
    func checkConnection(api: API) -> Future<Bool> {
        let promise: Promise<Bool> = util.getPromise()
        
        let domainPromise: Future<[Domain]> = util.collectionRequest(ResourceRouter.GetAll(resource: "/domains")).onSuccess{ result in
                promise.success(true)
            }.onFailure() { error in
                println(error)
                promise.success(false)
        }
        
        return promise.future
    }
    
}

