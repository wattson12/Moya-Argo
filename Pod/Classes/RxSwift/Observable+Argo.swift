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

public extension ObservableType where E == Moya.Response {
    
    public func mapObject<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String? = nil) -> Observable<T> {
        
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
                    
                    observer.onForDecoded(decoded)
                    
                    observer.on(.Completed)
                    
                } catch {
                    
                    observer.on(.Error(error))
                }
                
                return AnonymousDisposable { }
            }
        }
    }
    
    public func mapObjectWithRootKey<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String) -> Observable<T> {
     
        return mapObject(type, rootKey: rootKey)
    }
    
    public func mapArray<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String? = nil) -> Observable<[T]> {
        
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
                    
                    observer.onForDecoded(decoded)
                    
                    observer.on(.Completed)
                } catch {
                    
                    observer.on(.Error(error))
                }
                
                return AnonymousDisposable { }
            }
        }
    }
    
    public func mapArrayWithRootKey<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String) -> Observable<[T]> {
        
        return mapArray(type, rootKey: rootKey)
    }

}

extension AnyObserver {
    
    private func onForDecoded(decoded: Decoded<Element>) {
        
        switch decoded {
        case .Success(let value):
            self.on(.Next(value))
        case .Failure(let error):
            self.on(.Error(error))
        }
    }

}
