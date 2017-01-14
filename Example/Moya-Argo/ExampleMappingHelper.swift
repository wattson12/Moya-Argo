//
//  ExampleMappingHelper.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import Foundation
import Moya
import Moya_Argo

extension Response {
    
    func mapUsers() throws -> [ArgoUser] {
        
        return try mapArrayWithRootKey(rootKey: "users")
    }
    
    func mapUser() throws -> ArgoUser {
        
        return try mapObject()
    }
}
