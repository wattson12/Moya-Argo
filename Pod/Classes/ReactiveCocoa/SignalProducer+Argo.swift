//
//  SignalProducer+Argo.swift
//  Pods
//
//  Created by Sam Watts on 23/01/2016.
//
//

import ReactiveSwift
import Moya
import Argo

public extension SignalProducerProtocol where Value == Moya.Response, Error == MoyaError {
    
    /**
     Map stream of responses into stream of objects decoded via Argo
     
     - parameter type:    Type used to make mapping more explicit. This isnt required, but means type needs to be specified at use
     - parameter rootKey: optional root key of JSON used for mapping
     
     - returns: returns Observable of mapped objects
     */
    public func mapObject<T: Argo.Decodable>(type: T.Type, rootKey: String? = nil) -> SignalProducer<T, Error> where T == T.DecodedType {
        
        return producer.flatMap(.latest) { response -> SignalProducer<T, Error> in
            
            do {
                return SignalProducer(value: try response.mapObject(rootKey: rootKey))
            } catch let error as MoyaError {
                return SignalProducer(error: error)
            } catch let error as NSError {
                return SignalProducer(error: Error.underlying(error, response))
            }
        }
    }
    
    /// convenience for mapping object without passing in decodable type as argument
    public func mapObject<T: Argo.Decodable>(rootKey: String? = nil) -> SignalProducer<T, Error> where T == T.DecodedType {
        return mapObject(type: T.self, rootKey: rootKey)
    }
    
    /**
     Map stream of responses into stream of object array decoded via Argo
     
     - parameter type:    Type used to make mapping more explicit. This isnt required, but means type needs to be specified at use
     - parameter rootKey: optional root key of JSON used for mapping
     
     - returns: returns Observable of mapped object array
     */
    public func mapArray<T: Argo.Decodable>(type: T.Type, rootKey: String? = nil) -> SignalProducer<[T], Error> where T == T.DecodedType {
        
        return producer.flatMap(.latest) { response -> SignalProducer<[T], Error> in
            
            do {
                return SignalProducer(value: try response.mapArray(rootKey: rootKey))
            } catch let error as MoyaError {
                return SignalProducer(error: error)
            } catch let error as NSError {
                return SignalProducer(error: Error.underlying(error, response))
            }
        }
    }
    
    /// Convenience method for mapping array without passing in decodable type as argument
    public func mapArray<T: Argo.Decodable>(rootKey: String? = nil) -> SignalProducer<[T], Error> where T == T.DecodedType {
        return mapArray(type: T.self, rootKey: rootKey)
    }
}
