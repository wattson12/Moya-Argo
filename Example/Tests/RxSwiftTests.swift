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
    
    let provider: MoyaProvider<MappingTestTarget> = MoyaProvider(stubClosure: { _ in return .immediate })
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
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.invalidJSON).mapObject(type: TestModelClass.self).subscribe(onError: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ValidObjectWithRootKey
    func testSuccessfulDecodingOfObjectWithRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.validObjectWithRootKey).mapObject(type: TestModelClass.self, rootKey: "root_key").subscribe(onNext: { testModel in
            XCTAssertEqual(testModel.id, "test_id")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.MissingIDWithRootKey
    func testFailedDecodingOfObjectWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.missingIDWithRootKey).mapObject(type: TestModelClass.self, rootKey: "root_key").subscribe(onError: { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ValidArrayWithRootKey
    func testSuccessfulDecodingOfArrayWithRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.validArrayWithRootKey).mapArray(type: TestModelClass.self, rootKey: "root_key").subscribe(onNext: { testModelArray in
            XCTAssertEqual(testModelArray.count, 1)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ArrayWithInvalidObjectWithRootKey
    func testFailedDecodingOfArrayWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.arrayWithInvalidObjectWithRootKey).mapArray(type: TestModelClass.self, rootKey: "root_key").subscribe(onError: { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ValidObjectWithoutRootKey
    func testSuccessfulMappingWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.validObjectWithoutRootKey).mapObject(type: TestModelClass.self).subscribe(onNext: { testModel in
            XCTAssertEqual(testModel.id, "test_id")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.MissingIDWithoutRootKey
    func testFailedDecodingOfObjectWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.missingIDWithoutRootKey).mapObject(type: TestModelClass.self).subscribe(onError: { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ValidArrayWithoutRootKey
    func testSuccessfulMappingOfArrayWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.validArrayWithoutRootKey).mapArray(type: TestModelClass.self).subscribe(onNext: { modelArray in
            XCTAssertEqual(modelArray.count, 1)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    //.ArrayWithInvalidObjectWithoutRootKey
    func testFailedDecodingOfArrayWithoutRootKey() {
        
        let expectation = self.expectation(description: "subscribe callback called")
        provider.rx.request(.arrayWithInvalidObjectWithoutRootKey).mapArray(type: TestModelClass.self).subscribe(onError: { error in
            XCTAssertTrue(error is DecodeError)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
