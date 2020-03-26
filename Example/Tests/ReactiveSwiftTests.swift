//
//  ReactiveSwiftTests.swift
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

class ReactiveSwiftTests: XCTestCase {
    
    let provider: MoyaProvider<MappingTestTarget> = MoyaProvider(stubClosure: { _ in return .immediate })
    
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
        provider
            .reactive
            .request(.invalidJSON)
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
        provider
            .reactive
            .request(.validObjectWithRootKey)
            .mapObject(type: TestModelClass.self, rootKey: "root_key")
            .startWithResult { testModelResult in
                switch testModelResult {
                    case let .success(value):
                        XCTAssertEqual(value.id, "test_id")
                    case let .failure(error):
                        XCTAssertNil(error)
                }
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.MissingIDWithRootKey
    func testFailedDecodingOfObjectWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider
            .reactive
            .request(.missingIDWithRootKey)
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
        provider
            .reactive
            .request(.validArrayWithRootKey)
            .mapArray(type: TestModelClass.self, rootKey: "root_key")
            .startWithResult { testModelArrayResult in
                switch testModelArrayResult {
                    case let .success(value):
                        XCTAssertEqual(value.count, 1)
                        expectation.fulfill()
                    case let .failure(error):
                        XCTAssertNil(error)
                }
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.ArrayWithInvalidObjectWithRootKey
    func testFailedDecodingOfArrayWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider
            .reactive
            .request(.arrayWithInvalidObjectWithRootKey)
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
        provider
            .reactive
            .request(.validObjectWithoutRootKey)
            .mapObject(type: TestModelClass.self)
            .startWithResult { testModelResult in
                switch testModelResult {
                    case let .success(value):
                        XCTAssertEqual(value.id, "test_id")
                        expectation.fulfill()
                    case let .failure(error):
                        XCTAssertNil(error)
                }
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    //.MissingIDWithoutRootKey
    func testFailedDecodingOfObjectWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider
            .reactive
            .request(.missingIDWithoutRootKey)
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
        provider
            .reactive
            .request(.validArrayWithoutRootKey)
            .mapArray(type: TestModelClass.self)
            .startWithResult { modelArrayResult in
                switch modelArrayResult {
                    case let .success(value):
                        XCTAssertEqual(value.count, 1)
                        expectation.fulfill()
                    case let .failure(error):
                        XCTAssertNil(error)
                }
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ArrayWithInvalidObjectWithoutRootKey
    func testFailedDecodingOfArrayWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider
            .reactive
            .request(.arrayWithInvalidObjectWithoutRootKey)
            .mapArray(type: TestModelClass.self).startWithFailed { error in
                expectation.fulfill()
            }
            .dispose()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

}
