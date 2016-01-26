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
import Curry

class TestModelClass: Decodable {
    
    let id: String
    
    required init(id: String) {
        self.id = id
    }
    
    static func decode(json: JSON) -> Decoded<TestModelClass> {
        return curry(self.init)
            <^> json <| "id"
    }
}

enum MappingTestTarget: TargetType {
    
    case InvalidJSON
    
    case ValidObjectWithRootKey
    case MissingIDWithRootKey
    
    case ValidArrayWithRootKey
    case ArrayWithInvalidObjectWithRootKey
    
    case ValidObjectWithoutRootKey
    case MissingIDWithoutRootKey
    
    case ValidArrayWithoutRootKey
    case ArrayWithInvalidObjectWithoutRootKey
    
    var baseURL: NSURL {
        return NSURL(string: "http://localhost:1234/")!
    }
    
    var path: String {
        return "/test"
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var sampleData: NSData {
        
        switch self {
        case .InvalidJSON:
            let invalidJSONString = "{/sdf:}"
            return invalidJSONString.dataUsingEncoding(NSUTF8StringEncoding)!
        case .ValidObjectWithRootKey:
            let response = [
                "root_key": [
                    "id": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .MissingIDWithRootKey:
            let response = [
                "root_key": [
                    "id2": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ValidArrayWithRootKey:
            let response = [
                "root_key": [
                    [
                        "id": "test_id"
                    ]
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ArrayWithInvalidObjectWithRootKey:
            let response = [
                "root_key": [
                    [
                        "id2": "test_id"
                    ]
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ValidObjectWithoutRootKey:
            let response = [
                "id": "test_id"
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .MissingIDWithoutRootKey:
            let response = [
                "id2": "test_id"
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ValidArrayWithoutRootKey:
            let response = [
                [
                    "id": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
        case .ArrayWithInvalidObjectWithoutRootKey:
            let response = [
                [
                    "id2": "test_id"
                ]
            ]
            return try! NSJSONSerialization.dataWithJSONObject(response, options: [])
            
        }
    }
}

class MoyaMappingTests: XCTestCase {
    
    let provider:MoyaProvider<MappingTestTarget> = MoyaProvider(stubClosure: { _ in return .Immediate })
    
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
        
        let expectation = expectationWithDescription("provider callback run")
        self.provider.request(.InvalidJSON) { response in
            
            switch response {
            case .Failure:
                XCTFail("should not get a failure here")
            case .Success(let response):
                
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
        
        waitForExpectationsWithTimeout(0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ValidObjectWithRootKey
    func testSuccessfulDecodingOfObjectWithRootKey() {
        
        let expectation = expectationWithDescription("provider callback run")
        self.provider.request(.ValidObjectWithRootKey) { response in
            
            switch response {
            case .Failure:
                XCTFail("should not get a failure here")
            case .Success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let mapped:TestModelClass = try response.mapObject("root_key")
                    XCTAssertEqual(mapped.id, "test_id")
                } catch {
                    XCTFail("should not get a failure here")
                }
            }
        }
        
        waitForExpectationsWithTimeout(0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.MissingIDWithRootKey
    func testFailedDecodingOfObjectWithRootKeyThrowsError() {
        
        let expectation = expectationWithDescription("provider callback run")
        self.provider.request(.MissingIDWithRootKey) { response in
            
            switch response {
            case .Failure:
                XCTFail("should not get a failure here")
            case .Success(let response):
                
                defer {
                    expectation.fulfill()
                }
                
                do {
                    let _:TestModelClass = try response.mapObject("root_key")
                    XCTFail("exception should be thrown")
                } catch DecodeError.MissingKey(let missingKey) {
                    XCTAssertEqual(missingKey, "id")
                } catch {
                    XCTFail("wrong error: \(error)")
                }
            }
        }
        
        waitForExpectationsWithTimeout(0.1) { error in
            XCTAssertNil(error)
        }
    }
    
    //.ValidArrayWithRootKey
    func testSuccessfulDecodingOfArrayWithRootKey() {
        XCTFail("stubbed")
    }
    
    //.ArrayWithInvalidObjectWithRootKey
    func testFailedDecodingOfArrayWithRootKeyThrowsError() {
        XCTFail("stubbed")
    }
    
    //.ValidObjectWithoutRootKey
    func testSuccessfulMappingWithoutRootKey() {
        XCTFail("stubbed")
    }
    
    //.MissingIDWithoutRootKey
    func testFailedDecodingOfObjectWithoutRootKey() {
        XCTFail("stubbed")
    }
    
    //.ValidArrayWithoutRootKey
    func testSuccessfulMappingOfArrayWithoutRootKey() {
        XCTFail("stubbed")
    }
    
    //.ArrayWithInvalidObjectWithoutRootKey
    func testFailedDecodingOfArrayWithoutRootKey() {
        XCTFail("stubbed")
    }
}
