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
            
            return try decodedValue(decodedObject(rootKey, JSON: JSON))
            
        } catch {
            
            throw error
        }
    }
    
    public func mapObjectWithRootKey<T:Decodable where T == T.DecodedType>(rootKey: String) throws -> T {
        
        return try mapObject(rootKey)
    }
    
    public func mapArray<T:Decodable where T == T.DecodedType>(rootKey: String? = nil) throws -> [T] {
        
        do {
            let JSON = try self.mapJSON()
            
            return try decodedValue(decodedArray(rootKey, JSON: JSON))
            
        } catch {
            
            throw error
        }
    }
    
    public func mapArrayWithRootKey<T:Decodable where T == T.DecodedType>(rootKey: String) throws -> [T] {
        
        return try mapArray(rootKey)
    }
    
    private func decodedValue<T>(decoded: Decoded<T>) throws -> T {
        
        switch decoded {
        case .Success(let value):
            return value
        case .Failure(let error):
            throw error
        }
    }
    
    private func decodedObject<T:Decodable where T == T.DecodedType>(rootKey: String?, JSON: AnyObject) -> Decoded<T> {
        if let rootKey = rootKey {
            return decodeWithRootKey(rootKey, JSON)
        } else {
            return decode(JSON)
        }
    }
    
    private func decodedArray<T:Decodable where T == T.DecodedType>(rootKey: String?, JSON: AnyObject) -> Decoded<[T]> {
        if let rootKey = rootKey {
            return decodeWithRootKey(rootKey, JSON)
        } else {
            return decode(JSON)
        }
    }
}
