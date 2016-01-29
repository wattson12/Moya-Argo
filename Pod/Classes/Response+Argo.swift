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

/// Extension on Moya response to map to an object(s) decodable with Argo
public extension Response {
    
    /**
     Maps Moya response to decodable type
     
     - parameter rootKey: Optional root key of JSON to begin mapping
     
     - throws: Throws errors from either mapping to JSON, or Argo decoding
     
     - returns: returns a decoded object
     */
    public func mapObject<T:Decodable where T == T.DecodedType>(rootKey: String? = nil) throws -> T {
        
        do {
            //map to JSON
            let JSON = try self.mapJSON()
            
            //decode with Argo
            let decodedObject:Decoded<T>
            if let rootKey = rootKey {
                decodedObject = decodeWithRootKey(rootKey, JSON)
            } else {
                decodedObject = decode(JSON)
            }
            
            //return decoded value, or throw decoding error
            return try decodedValue(decodedObject)
            
        } catch {
            
            throw error
        }
    }
    
    /// Convenience method for mapping an object with a root key
    public func mapObjectWithRootKey<T:Decodable where T == T.DecodedType>(rootKey: String) throws -> T {
        
        return try mapObject(rootKey)
    }
    
    /**
     Maps Moya response to an array of decodable type
     
     - parameter rootKey: Optional root key of JSON to begin mapping
     
     - throws: Throws errors from either mapping to JSON, or Argo decoding
     
     - returns: returns an array of decoded object
     */
    public func mapArray<T:Decodable where T == T.DecodedType>(rootKey: String? = nil) throws -> [T] {
        
        do {
            //map to JSON
            let JSON = try self.mapJSON()
            
            //decode with Argo
            let decodedArray:Decoded<[T]>
            if let rootKey = rootKey {
                decodedArray = decodeWithRootKey(rootKey, JSON)
            } else {
                decodedArray = decode(JSON)
            }
            
            //return array of decoded objects, or throw decoding error
            return try decodedValue(decodedArray)
            
        } catch {
            
            throw error
        }
    }
    
    /// Convenience method for mapping an array with a root key
    public func mapArrayWithRootKey<T:Decodable where T == T.DecodedType>(rootKey: String) throws -> [T] {
        
        return try mapArray(rootKey)
    }
    
    /**
     Helper function which takes a decoded value and returns a value, or throws an error
     
     - parameter decoded: result of Argo decoding
     
     - throws: throws Argo error from decoding process
     
     - returns: returns the decoded value if decoding was successful
     */
    private func decodedValue<T>(decoded: Decoded<T>) throws -> T {
        
        switch decoded {
        case .Success(let value):
            return value
        case .Failure(let error):
            throw error
        }
    }
}
