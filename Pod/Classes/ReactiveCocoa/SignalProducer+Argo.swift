//
//  SignalProducer+Argo.swift
//  Pods
//
//  Created by Sam Watts on 23/01/2016.
//
//

import Foundation
import ReactiveCocoa
import Moya
import Argo

public extension SignalProducerType where Value == Moya.Response, Error == Moya.Error {
    
    public func mapObject<T:Decodable where T == T.DecodedType>(type: T.Type, rootKey: String? = nil) -> SignalProducer<T, Error> {
        
        return producer.flatMap(.Latest) { response -> SignalProducer<T, Error> in
            
            do {
                return SignalProducer(value: try response.mapObject(rootKey))
            } catch let error as Moya.Error {
                return SignalProducer(error: error)
            } catch {
                return SignalProducer(error: Error.Underlying(error))
            }
        }
    }
    
    public func mapArray<T:Decodable where T == T.DecodedType>(type: T.Type, rootKey: String? = nil) -> SignalProducer<[T], Error> {
        
        return producer.flatMap(.Latest) { response -> SignalProducer<[T], Error> in
            
            do {
                return SignalProducer(value: try response.mapArray(rootKey))
            } catch let error as Moya.Error {
                return SignalProducer(error: error)
            } catch {
                return SignalProducer(error: Error.Underlying(error))
            }
        }
    }
}
