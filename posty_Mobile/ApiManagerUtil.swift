//
//  ApiManagerUtil.swift
//  posty_Mobile
//
//  Created by admin on 08.06.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures

public class ApiManagerUtil {
    
    private struct Consts
    {
        struct ErrorStrings {
            static let HostUnreachable = "Host is unreachable!"
        }
    }
    
    let manager: Manager
    
    public init(manager: Manager)
    {
        self.manager = manager
    }
    
    private func getExtractedErrorFromErrorResponse(errorResponse: NSError, jsonResponse: AnyObject?) -> NSError {
        return NSError(domain: errorResponse.domain, code: errorResponse.code, userInfo: [NSLocalizedDescriptionKey: Consts.ErrorStrings.HostUnreachable])
    }
    
    private func getExtractedErrorFromErrorJSONResponse(errorResponse: NSError, jsonResponse: AnyObject?) -> NSError {
        if (jsonResponse != nil) {
            var errorDescription = JSON(jsonResponse!)["error"]["name"][0].stringValue
            if (errorDescription == "") {
                errorDescription = JSON(jsonResponse!)["error"].stringValue
            }
            return NSError(domain: errorResponse.domain, code: errorResponse.code, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        } else {
            return NSError(domain: errorResponse.domain, code: errorResponse.code, userInfo: [NSLocalizedDescriptionKey: Consts.ErrorStrings.HostUnreachable])
        }
    }
    
    func objectRequest <T: ResponseObjectSerializable>(URLRequest: URLRequestConvertible) -> Future<T> {
        let promise = Promise<T>()
        manager.request(URLRequest).validate().responseObject { (request, response,
            object: T?, error) in
            if error != nil {
                promise.failure(error!)
            } else {
                promise.success(object!)
            }
        }
        return promise.future
    }
    
    func collectionRequest<T: ResponseCollectionSerializable>(URLRequest: URLRequestConvertible) -> Future<[T]> {
        let promise = Promise<[T]>()
        manager.request(URLRequest).validate().responseCollection { (request, response,
            collection: [T]?, error) in
            if error != nil {
                promise.failure(error!)
            } else {
                promise.success(collection!)
            }
        }
        return promise.future
    }
    
    func boolRequest(URLRequest: URLRequestConvertible) -> Future<Bool> {
        let promise = Promise<Bool>()
        manager.request(URLRequest).validate().responseJSON{ (request, response,
            jsonResponse, error) in
            if error != nil {
                promise.failure(self.getExtractedErrorFromErrorJSONResponse(error!, jsonResponse: jsonResponse))
            } else {
                promise.success(true)
            }
        }
        return promise.future
    }
    
}

