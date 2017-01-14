//
//  DemoTarget.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import Foundation
import Moya

enum DemoTarget: TargetType {

    
    case allUsers
    case user(userID: String)
    
    var baseURL: URL {
        return URL(string: "https://localhost:1234")! //point to local host, this example will return sample data for everything
    }
    
    var path: String {
        
        switch self {
        case .allUsers:
            return "/users"
        case .user(let userID):
            return "/users/\(userID)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        
        let sampleResponseName:String
        
        switch self {
        case .allUsers:
            sampleResponseName = "all_users.json"
        case .user:
            sampleResponseName = "user.json"
        }
        
        let sampleResponsePath = Bundle.main.path(forResource: sampleResponseName, ofType: nil)!
        
        return (try! Data(contentsOf: URL(fileURLWithPath: sampleResponsePath)))
    }

}
