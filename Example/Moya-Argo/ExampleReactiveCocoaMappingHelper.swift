//
//  ExampleReactiveCocoaMappingHelper.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Moya
import Argo

extension SignalProducerType where Value == Moya.Response, Error == Moya.Error {
    
    func mapUsers() -> SignalProducer<[ArgoUser], Error> {
        
        return mapArray(ArgoUser.self, rootKey: "users")
    }
    
    func mapUser() -> SignalProducer<ArgoUser, Error> {
        
        return mapObject(ArgoUser)
    }
}