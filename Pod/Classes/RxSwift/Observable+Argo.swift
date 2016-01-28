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
        
        return Observable.create { observer in
            
            self.subscribe { event in
                
                switch event {
                case .Next(let response):
                    do {
                        let mappedObject:T = try response.mapObject(rootKey)
                        observer.onNext(mappedObject)
                    } catch {
                        observer.onError(error)
                    }
                case .Error(let error):
                    observer.onError(error)
                case .Completed:
                    observer.onCompleted()
                }
            }
        }
    }
    
    public func mapObjectWithRootKey<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String) -> Observable<T> {
        return mapObject(type, rootKey: rootKey)
    }
    
    public func mapArray<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String? = nil) -> Observable<[T]> {
        
        return Observable.create { observer in
            
            self.subscribe { event in
                
                switch event {
                case .Next(let response):
                    do {
                        let mappedObject:[T] = try response.mapArray(rootKey)
                        observer.onNext(mappedObject)
                    } catch {
                        observer.onError(error)
                    }
                case .Error(let error):
                    observer.onError(error)
                case .Completed:
                    observer.onCompleted()
                }
            }
        }
    }
    
    public func mapArrayWithRootKey<T: Decodable where T == T.DecodedType>(type: T.Type, rootKey: String) -> Observable<[T]> {
        return mapArray(type, rootKey: rootKey)
    }

}
