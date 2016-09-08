//
//  MappingTestTarget.swift
//  Moya-Argo
//
//  Created by Sam Watts on 27/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Moya

enum MappingTestTarget: TargetType {
    
    case InvalidJSON
    
    case ValidObjectWithRootKey
    case MissingIDWithRootKey
    
    case ValidArrayWithRootKey
    case ArrayWithInvalidObjectWithRootKey
    
    case ValidObjectWithoutRootKey
    case MissingIDWithoutRootKey
    
    case ValidArrayWithoutRootKey
    case ArrayWithInvalidObjectWithoutRootKey
    
    var baseURL: NSURL {
        return NSURL(string: "http://localhost:1234/")!
    }
    
    var path: String {
        return "/test"
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var sampleData: NSData {
        
        switch self {
        case .InvalidJSON:
            let invalidJSONString = "{/sdf:}"
            return invalidJSONString.dataUsingEncoding(NSUTF8StringEncoding)!
        case .ValidObjectWithRootKey:
            let response = [
                "root_key": [
                    "id": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .MissingIDWithRootKey:
            let response = [
                "root_key": [
                    "id2": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ValidArrayWithRootKey:
            let response = [
                "root_key": [
                    [
                        "id": "test_id"
                    ]
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ArrayWithInvalidObjectWithRootKey:
            let response = [
                "root_key": [
                    [
                        "id2": "test_id"
                    ]
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ValidObjectWithoutRootKey:
            let response = [
                "id": "test_id"
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .MissingIDWithoutRootKey:
            let response = [
                "id2": "test_id"
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ValidArrayWithoutRootKey:
            let response = [
                [
                    "id": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ArrayWithInvalidObjectWithoutRootKey:
            let response = [
                [
                    "id2": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
            
        }
    }

    var multipartBody: [MultipartFormData]? { return nil }

}
