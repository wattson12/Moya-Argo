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

extension ObservableType where E == Moya.Response {
    
    func mapObject<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String? = nil) -> Observable<T> {
        
        return flatMap { response in
            
            return Observable.create { observer in
                
                do {
                    let JSON = try NSJSONSerialization.JSONObjectWithData(response.data, options: [])
                    
                    let decoded:Decoded<T>
                    if let rootKey = rootKey {
                        decoded = decodeWithRootKey(rootKey, JSON)
                    } else {
                        decoded = decode(JSON)
                    }
                    
                    switch decoded {
                    case .Success(let mappedObject):
                        observer.on(.Next(mappedObject))
                    case .Failure(let error):
                        observer.on(.Error(error))
                    }
                    
                    observer.on(.Completed)
                    
                } catch {
                    
                    observer.on(.Error(error))
                }
                
                return AnonymousDisposable { }
            }
        }
    }
    
    func mapArray<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String? = nil) -> Observable<[T]> {
        
        return flatMap { response -> Observable<[T]> in
            
            return Observable.create { observer in
                
                do {
                    let JSON = try NSJSONSerialization.JSONObjectWithData(response.data, options: [])
                    
                    let decoded:Decoded<[T]>
                    if let rootKey = rootKey {
                        decoded = decodeWithRootKey(rootKey, JSON)
                    } else {
                        decoded = decode(JSON)
                    }
                    
                    switch decoded {
                    case .Success(let mappedObject):
                        observer.on(.Next(mappedObject))
                    case .Failure(let error):
                        observer.on(.Error(error))
                    }
                    
                    observer.on(.Completed)
                } catch {
                    
                    observer.on(.Error(error))
                }
                
                return AnonymousDisposable { }
            }
        }
    }
    
}
