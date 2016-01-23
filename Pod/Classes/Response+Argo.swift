//
//  Response+Argo.swift
//  Pods
//
//  Created by Sam Watts on 23/01/2016.
//
//

import Foundation
import Moya
import Argo

public extension Response {
    
    public func mapObject<T:Decodable where T == T.DecodedType>(rootKey: String? = nil) throws -> T {
        
        do {
            let JSON = try self.mapJSON()
            
            let decodedObject:Decoded<T>
            if let rootKey = rootKey {
                decodedObject = decodeWithRootKey(rootKey, JSON)
            } else {
                decodedObject = decode(JSON)
            }
            
            return try decodedValue(decodedObject)
            
        } catch {
            
            throw error
        }
    }
    
    public func mapArray<T:Decodable where T == T.DecodedType>(rootKey: String? = nil) throws -> [T] {
        
        do {
            let JSON = try self.mapJSON()
            
            let decodedObject:Decoded<[T]>
            if let rootKey = rootKey {
                decodedObject = decodeWithRootKey(rootKey, JSON)
            } else {
                decodedObject = decode(JSON)
            }
            
            return try decodedValue(decodedObject)
            
        } catch {
            
            throw error
        }
    }
    
    private func decodedValue<T>(decoded: Decoded<T>) throws -> T {
        
        switch decoded {
        case .Success(let value):
            return value
        case .Failure(let error):
            throw error
        }
    }
}
