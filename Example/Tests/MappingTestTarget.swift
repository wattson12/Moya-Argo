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
    
    case invalidJSON
    
    case validObjectWithRootKey
    case missingIDWithRootKey
    
    case validArrayWithRootKey
    case arrayWithInvalidObjectWithRootKey
    
    case validObjectWithoutRootKey
    case missingIDWithoutRootKey
    
    case validArrayWithoutRootKey
    case arrayWithInvalidObjectWithoutRootKey
    
    var baseURL: URL {
        return URL(string: "http://localhost:1234/")!
    }
    
    var path: String {
        return "/test"
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
        
        switch self {
        case .invalidJSON:
            let invalidJSONString = "{/sdf:}"
            return invalidJSONString.data(using: String.Encoding.utf8)!
        case .validObjectWithRootKey:
            let response = [
                "root_key": [
                    "id": "test_id"
                ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        case .missingIDWithRootKey:
            let response = [
                "root_key": [
                    "id2": "test_id"
                ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        case .validArrayWithRootKey:
            let response = [
                "root_key": [
                    [
                        "id": "test_id"
                    ]
                ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        case .arrayWithInvalidObjectWithRootKey:
            let response = [
                "root_key": [
                    [
                        "id2": "test_id"
                    ]
                ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        case .validObjectWithoutRootKey:
            let response = [
                "id": "test_id"
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        case .missingIDWithoutRootKey:
            let response = [
                "id2": "test_id"
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        case .validArrayWithoutRootKey:
            let response = [
                [
                    "id": "test_id"
                ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
        case .arrayWithInvalidObjectWithoutRootKey:
            let response = [
                [
                    "id2": "test_id"
                ]
            ]
            return try! JSONSerialization.data(withJSONObject: response, options: [])
            
        }
    }

    var multipartBody: [MultipartFormData]? { return nil }

}
