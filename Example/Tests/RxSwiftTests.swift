//
//  RxSwiftTests.swift
//  Moya-Argo
//
//  Created by Sam Watts on 25/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Moya_Argo
import Moya
import Argo
import RxSwift

class RxSwiftTests: XCTestCase {
    
    let provider:RxMoyaProvider<MappingTestTarget> = RxMoyaProvider(stubClosure: { _ in return .Immediate })
    let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //.InvalidJSON
    func testErrorThrownByMapJSONIsThrown() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.InvalidJSON).mapObject(TestModelClass).subscribeError { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ValidObjectWithRootKey
    func testSuccessfulDecodingOfObjectWithRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidObjectWithRootKey).mapObject(TestModelClass.self, rootKey: "root_key").subscribeNext { testModel in
            XCTAssertEqual(testModel.id, "test_id")
            expectation.fulfill()
        }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.MissingIDWithRootKey
    func testFailedDecodingOfObjectWithRootKeyThrowsError() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.MissingIDWithRootKey).mapObject(TestModelClass.self, rootKey: "root_key").subscribeError { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ValidArrayWithRootKey
    func testSuccessfulDecodingOfArrayWithRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidArrayWithRootKey).mapArray(TestModelClass.self, rootKey: "root_key").subscribeNext { testModelArray in
            XCTAssertEqual(testModelArray.count, 1)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ArrayWithInvalidObjectWithRootKey
    func testFailedDecodingOfArrayWithRootKeyThrowsError() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ArrayWithInvalidObjectWithRootKey).mapArray(TestModelClass.self, rootKey: "root_key").subscribeError { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ValidObjectWithoutRootKey
    func testSuccessfulMappingWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidObjectWithoutRootKey).mapObject(TestModelClass).subscribeNext { testModel in
            XCTAssertEqual(testModel.id, "test_id")
            expectation.fulfill()
            }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.MissingIDWithoutRootKey
    func testFailedDecodingOfObjectWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.MissingIDWithoutRootKey).mapObject(TestModelClass).subscribeError { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ValidArrayWithoutRootKey
    func testSuccessfulMappingOfArrayWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidArrayWithoutRootKey).mapArray(TestModelClass).subscribeNext { modelArray in
            XCTAssertEqual(modelArray.count, 1)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ArrayWithInvalidObjectWithoutRootKey
    func testFailedDecodingOfArrayWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ArrayWithInvalidObjectWithoutRootKey).mapArray(TestModelClass).subscribeError { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
            }.addDisposableTo(disposeBag)
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
}
