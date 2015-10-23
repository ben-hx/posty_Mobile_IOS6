//
//  ResourceRouter.swift
//  posty_Mobile
//
//  Created by admin on 22.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum ResourceRouter: URLRequestConvertible {
    static let baseURLString = ModelFactory.sharedAPIRepositoryInstance.currentAPI.url//APIRepository.sharedInstance.currentAPI.url
    
    case Create(resource: String, params: [String: AnyObject])
    case GetAll(resource: String)
    case GetSingle(resource: String)
    case Update(resource: String, params: [String: AnyObject])
    case Destroy(resource: String)
    
    var method: Alamofire.Method {
        switch self {
        case .Create:
            return .POST
        case .GetAll:
            return .GET
        case .GetSingle:
            return .GET
        case .Update:
            return .PUT
        case .Destroy:
            return .DELETE
        }
    }
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: ResourceRouter.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest()
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.addValue(ModelFactory.sharedAPIRepositoryInstance.currentAPI.authKey, forHTTPHeaderField: "auth_token")
        
        switch self {
        case .Create(let resource, let parameters):
            mutableURLRequest.URL = URL.URLByAppendingPathComponent(resource)
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .GetAll(let resource):
            mutableURLRequest.URL = URL.URLByAppendingPathComponent(resource)
            return mutableURLRequest
        case .GetSingle(let resource):
            mutableURLRequest.URL = URL.URLByAppendingPathComponent(resource)
            return mutableURLRequest
        case .Update(let resource, let parameters):
            mutableURLRequest.URL = URL.URLByAppendingPathComponent(resource)
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .Destroy(let resource):
            mutableURLRequest.URL = URL.URLByAppendingPathComponent(resource)
            return mutableURLRequest
        }
    }
}