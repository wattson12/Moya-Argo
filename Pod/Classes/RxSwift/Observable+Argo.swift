//
//  Observable+Argo.swift
//  Pods
//
//  Created by Sam Watts on 23/01/2016.
//
//

import Foundation
import Moya
import RxSwift
import Argo

/// Extension on ObservableTypes containing Moya responses
/// used to map to stream of objects decoded with Argo
public extension ObservableType where E == Moya.Response {
    
    /**
     Map stream of responses into stream of objects decoded via Argo
     
     - parameter type:    Type used to make mapping more explicit. This isnt required, but means type needs to be specified at use
     - parameter rootKey: optional root key of JSON used for mapping
     
     - returns: returns Observable of mapped objects
     */
    public func mapObject<T: Decodable>(type: T.Type, rootKey: String? = nil) -> Observable<T> where T == T.DecodedType {
        
        return Observable.create { observer in
            
            // subscribe to self and map each event to an object with Argo
            self.subscribe { event in
                
                switch event {
                case .next(let response):
                    observer.onNextOrError { try response.mapObject(rootKey: rootKey) }
                case .error(let error):
                    observer.onError(error)
                case .completed:
                    observer.onCompleted()
                }
            }
        }
    }
    
    /// Alternative for mapping object without specifying type as argument
    /// This means type needs to be specified at use
    public func mapObject<T: Decodable>(rootKey: String? = nil) -> Observable<T> where T == T.DecodedType {
        return mapObject(type: T.self, rootKey: rootKey)
    }
    
    /// Convenience method for mapping object with root key, accepts non optional root key for some type checking
    public func mapObjectWithRootKey<T: Decodable>(type: T.Type, rootKey: String) -> Observable<T> where T == T.DecodedType {
        return mapObject(type: type, rootKey: rootKey)
    }
    
    /**
     Map stream of responses into stream of object array decoded via Argo
     
     - parameter type:    Type used to make mapping more explicit. This isnt required, but means type needs to be specified at use
     - parameter rootKey: optional root key of JSON used for mapping
     
     - returns: returns Observable of mapped object array
     */
    public func mapArray<T: Decodable>(type: T.Type, rootKey: String? = nil) -> Observable<[T]> where T == T.DecodedType {
        
        return Observable.create { observer in
            
            // subscribe to self and map each event to an array of objects with Argo
            self.subscribe { event in
                
                switch event {
                case .next(let response):
                    observer.onNextOrError { try response.mapArray(rootKey: rootKey) }
                case .error(let error):
                    observer.onError(error)
                case .completed:
                    observer.onCompleted()
                }
            }
        }
    }
    
    /// Alternative for mapping object array without specifying type as argument
    /// This means type needs to be specified at use
    public func mapArray<T: Decodable>(rootKey: String? = nil) -> Observable<[T]> where T == T.DecodedType {
        return mapArray(type: T.self, rootKey: rootKey)
    }
    
    /// Convenience method for mapping object array with root key, accepts non optional root key for some type checking
    public func mapArrayWithRootKey<T: Decodable>(type: T.Type, rootKey: String) -> Observable<[T]> where T == T.DecodedType {
        return mapArray(type: type, rootKey: rootKey)
    }

}

fileprivate extension AnyObserver {
    
    /// convenience method calling either on(.Next) or on(.Error) depending if a function throws an error or returns a value
    fileprivate func onNextOrError(function: () throws -> Element) {
        do {
            let value = try function()
            self.onNext(value)
        } catch {
            self.onError(error)
        }
    }
}
