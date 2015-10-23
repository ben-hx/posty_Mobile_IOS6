//
//  ApiRepositoryBase.swift
//  posty_Mobile
//
//  Created by admin on 03.07.15.
//  Copyright (c) 2015 ben-hx. All rights reserved.
//

import Alamofire
import SwiftyJSON
import BrightFutures

public class ApiRepositoryBase
{
    let util: ApiManagerUtil
    var processDelegate: Processable? {
        didSet {
            util.processableDelegate = processDelegate
        }
    }
    
    init(manager: Manager)
    {
        self.util = ApiManagerUtil(manager: manager)
    }
}