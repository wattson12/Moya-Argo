//
//  ExampleRxSwiftMappingHelper.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Argo

extension ObservableType where E == Moya.Response {
    
    func mapUsers() -> Observable<[ArgoUser]> {
        
        return mapArray(type: ArgoUser.self, rootKey: "users")
    }
    
    func mapUser() -> Observable<ArgoUser> {
        
        return mapObject(type: ArgoUser.self)
    }
}
