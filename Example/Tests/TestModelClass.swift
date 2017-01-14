//
//  TestModelClass.swift
//  Moya-Argo
//
//  Created by Sam Watts on 26/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

class TestModelClass: Decodable {
    
    let id: String
    
    required init(id: String) {
        self.id = id
    }
    
    static func decode(_ json: JSON) -> Decoded<TestModelClass> {
        return curry(self.init)
            <^> json <| "id"
    }
}
