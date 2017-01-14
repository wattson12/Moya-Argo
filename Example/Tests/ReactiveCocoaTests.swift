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
import ReactiveSwift

class ReactiveCocoaTests: XCTestCase {
    
    let provider:ReactiveSwiftMoyaProvider<MappingTestTarget> = ReactiveSwiftMoyaProvider(stubClosure: { _ in return .immediate })
    
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
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.invalidJSON)
            .mapObject(type: TestModelClass.self)
            .startWithFailed { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .dispose()
        waitForExpectations(timeout: 0.1, handler: nil)

    }
    
    //.ValidObjectWithRootKey
    func testSuccessfulDecodingOfObjectWithRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.validObjectWithRootKey)
            .mapObject(type: TestModelClass.self, rootKey: "root_key")
            .startWithResult { testModelResult in
                XCTAssertNil(testModelResult.error)
                if let testModel = testModelResult.value {
                    XCTAssertEqual(testModel.id, "test_id")
                }
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.MissingIDWithRootKey
    func testFailedDecodingOfObjectWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.missingIDWithRootKey)
            .mapObject(type: TestModelClass.self, rootKey: "root_key")
            .startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.ValidArrayWithRootKey
    func testSuccessfulDecodingOfArrayWithRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.validArrayWithRootKey)
            .mapArray(type: TestModelClass.self, rootKey: "root_key")
            .startWithResult { testModelArrayResult in
                XCTAssertNil(testModelArrayResult.error)
                if let testModelArray = testModelArrayResult.value {
                    XCTAssertEqual(testModelArray.count, 1)
                }
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.ArrayWithInvalidObjectWithRootKey
    func testFailedDecodingOfArrayWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.arrayWithInvalidObjectWithRootKey)
            .mapArray(type: TestModelClass.self, rootKey: "root_key")
            .startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.ValidObjectWithoutRootKey
    func testSuccessfulMappingWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.validObjectWithoutRootKey)
            .mapObject(type: TestModelClass.self)
            .startWithResult { testModelResult in
                XCTAssertNil(testModelResult.error)
                if let testModel = testModelResult.value {
                    XCTAssertEqual(testModel.id, "test_id")
                    expectation.fulfill()
                }
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.MissingIDWithoutRootKey
    func testFailedDecodingOfObjectWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.missingIDWithoutRootKey)
            .mapObject(type: TestModelClass.self)
            .startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ValidArrayWithoutRootKey
    func testSuccessfulMappingOfArrayWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.validArrayWithoutRootKey)
            .mapArray(type: TestModelClass.self)
            .startWithResult { modelArrayResult in
                XCTAssertNil(modelArrayResult.error)
                if let modelArray = modelArrayResult.value {
                    XCTAssertEqual(modelArray.count, 1)
                    expectation.fulfill()
                }
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ArrayWithInvalidObjectWithoutRootKey
    func testFailedDecodingOfArrayWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.request(.arrayWithInvalidObjectWithoutRootKey)
            .mapArray(type: TestModelClass.self).startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

}
