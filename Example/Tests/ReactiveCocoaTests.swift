//
//  ReactiveCocoaTests.swift
//  Moya-Argo
//
//  Created by Sam Watts on 25/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Moya_Argo
import Moya
import Argo
import ReactiveCocoa

class ReactiveCocoaTests: XCTestCase {
    
    let provider:ReactiveCocoaMoyaProvider<MappingTestTarget> = ReactiveCocoaMoyaProvider(stubClosure: { _ in return .Immediate })
    
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
        provider.request(.InvalidJSON)
            .mapObject(TestModelClass)
            .startWithFailed { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .dispose()
        waitForExpectationsWithTimeout(0.1, handler: nil)

    }
    
    //.ValidObjectWithRootKey
    func testSuccessfulDecodingOfObjectWithRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidObjectWithRootKey)
            .mapObject(TestModelClass.self, rootKey: "root_key")
            .startWithResult { testModelResult in
                XCTAssertNil(testModelResult.error)
                if let testModel = testModelResult.value {
                    XCTAssertEqual(testModel.id, "test_id")
                }
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    //.MissingIDWithRootKey
    func testFailedDecodingOfObjectWithRootKeyThrowsError() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.MissingIDWithRootKey)
            .mapObject(TestModelClass.self, rootKey: "root_key")
            .startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    //.ValidArrayWithRootKey
    func testSuccessfulDecodingOfArrayWithRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidArrayWithRootKey)
            .mapArray(TestModelClass.self, rootKey: "root_key")
            .startWithResult { testModelArrayResult in
                XCTAssertNil(testModelArrayResult.error)
                if let testModelArray = testModelArrayResult.value {
                    XCTAssertEqual(testModelArray.count, 1)
                }
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    //.ArrayWithInvalidObjectWithRootKey
    func testFailedDecodingOfArrayWithRootKeyThrowsError() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ArrayWithInvalidObjectWithRootKey)
            .mapArray(TestModelClass.self, rootKey: "root_key")
            .startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    //.ValidObjectWithoutRootKey
    func testSuccessfulMappingWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidObjectWithoutRootKey)
            .mapObject(TestModelClass)
            .startWithResult { testModelResult in
                XCTAssertNil(testModelResult.error)
                if let testModel = testModelResult.value {
                    XCTAssertEqual(testModel.id, "test_id")
                    expectation.fulfill()
                }
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

    //.MissingIDWithoutRootKey
    func testFailedDecodingOfObjectWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.MissingIDWithoutRootKey)
            .mapObject(TestModelClass)
            .startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ValidArrayWithoutRootKey
    func testSuccessfulMappingOfArrayWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ValidArrayWithoutRootKey)
            .mapArray(TestModelClass)
            .startWithResult { modelArrayResult in
                XCTAssertNil(modelArrayResult.error)
                if let modelArray = modelArrayResult.value {
                    XCTAssertEqual(modelArray.count, 1)
                    expectation.fulfill()
                }
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }
    
    //.ArrayWithInvalidObjectWithoutRootKey
    func testFailedDecodingOfArrayWithoutRootKey() {
        
        let expectation = expectationWithDescription("subscribe callback called")
        provider.request(.ArrayWithInvalidObjectWithoutRootKey)
            .mapArray(TestModelClass).startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectationsWithTimeout(0.1, handler: nil)
    }

}
