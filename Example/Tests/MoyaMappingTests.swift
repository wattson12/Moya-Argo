//
//  MoyaMappingTests.swift
//  Moya-Argo
//
//  Created by Sam Watts on 25/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import Moya_Argo
import Moya
import Argo

class MoyaMappingTests: XCTestCase {
    
    let provider:MoyaProvider<MappingTestTarget> = MoyaProvider(stubClosure: { _ in return .immediate })
    
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
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.invalidJSON) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let _:TestModelClass = try response.mapObject()
                    XCTFail("exception should be thrown")
                } catch {
                    XCTAssertNotNil(error)
                    print(error)
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ValidObjectWithRootKey
    func testSuccessfulDecodingOfObjectWithRootKey() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.validObjectWithRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let mapped:TestModelClass = try response.mapObject(rootKey: "root_key")
                    XCTAssertEqual(mapped.id, "test_id")
                } catch {
                    XCTFail("should not get a failure here")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.MissingIDWithRootKey
    func testFailedDecodingOfObjectWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.missingIDWithRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let _:TestModelClass = try response.mapObject(rootKey: "root_key")
                    XCTFail("exception should be thrown")
                } catch DecodeError.missingKey(let missingKey) {
                    XCTAssertEqual(missingKey, "id")
                } catch {
                    XCTFail("wrong error: \(error)")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ValidArrayWithRootKey
    func testSuccessfulDecodingOfArrayWithRootKey() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.validArrayWithRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let mappedArray:[TestModelClass] = try response.mapArray(rootKey: "root_key")
                    XCTAssertEqual(mappedArray.count, 1)
                } catch {
                    XCTFail("wrong error: \(error)")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ArrayWithInvalidObjectWithRootKey
    func testFailedDecodingOfArrayWithRootKeyThrowsError() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.arrayWithInvalidObjectWithRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let _:[TestModelClass] = try response.mapArray(rootKey: "root_key")
                    XCTFail("exception should be thrown")
                } catch DecodeError.missingKey {
                    XCTAssertTrue(true)
                } catch {
                    XCTFail("wrong error: \(error)")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ValidObjectWithoutRootKey
    func testSuccessfulMappingWithoutRootKey() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.validObjectWithoutRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let mapped:TestModelClass = try response.mapObject()
                    XCTAssertEqual(mapped.id, "test_id")
                } catch {
                    XCTFail("should not get a failure here")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.MissingIDWithoutRootKey
    func testFailedDecodingOfObjectWithoutRootKey() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.missingIDWithoutRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let _:TestModelClass = try response.mapObject()
                    XCTFail("exception should be thrown")
                } catch DecodeError.missingKey(let missingKey) {
                    XCTAssertEqual(missingKey, "id")
                } catch {
                    XCTFail("wrong error: \(error)")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ValidArrayWithoutRootKey
    func testSuccessfulMappingOfArrayWithoutRootKey() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.validArrayWithoutRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let mappedArray:[TestModelClass] = try response.mapArray()
                    XCTAssertEqual(mappedArray.count, 1)
                } catch {
                    XCTFail("wrong error: \(error)")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ArrayWithInvalidObjectWithoutRootKey
    func testFailedDecodingOfArrayWithoutRootKey() {
        
        let expectation = self.expectation(description: "provider callback run")
        self.provider.request(.arrayWithInvalidObjectWithRootKey) { response in
            
            switch response {
            case .failure:
                XCTFail("should not get a failure here")
            case .success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let _:[TestModelClass] = try response.mapArray()
                    XCTFail("exception should be thrown")
                } catch DecodeError.typeMismatch {
                    XCTAssertTrue(true)
                } catch {
                    XCTFail("wrong error: \(error)")
                }
            }
        }
        
        waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error)
        }
    }
}
