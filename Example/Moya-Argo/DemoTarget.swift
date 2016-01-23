//
//  DemoTarget.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Moya

enum DemoTarget: TargetType {
    
    case AllUsers
    case User(userID: String)
    
    var baseURL: NSURL {
        return NSURL(string: "https://localhost:1234")! //point to local host, this example will return sample data for everything
    }
    
    var path: String {
        
        switch self {
        case .AllUsers:
            return "/users"
        case .User(let userID):
            return "/users/\(userID)"
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var sampleData: NSData {
        
        let sampleResponseName:String
        
        switch self {
        case .AllUsers:
            sampleResponseName = "all_users.json"
        case .User:
            sampleResponseName = "user.json"
        }
        
        let sampleResponsePath = NSBundle.mainBundle().pathForResource(sampleResponseName, ofType: nil)!
        
        return NSData(contentsOfFile: sampleResponsePath)!
    }
}