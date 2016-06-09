//
//  HashTests.swift
//  Vapor
//
//  Created by Tanner Nelson on 2/22/16.
//  Copyright © 2016 Tanner Nelson. All rights reserved.
//

import Foundation
import XCTest
@testable import Vapor

class HashTests: XCTestCase {
    static var allTests: [(String, (HashTests) -> () throws -> Void)] {
        return [
            ("testHash", testHash)
        ]
    }

    func testHash() {

        let string = "vapor"
        let defaultExpected = "97ce9a45eaf0b1ceafc3bba00dfec047526386bbd69241e4a4f0c9fde7c638ea"
        let defaultKey = "123"

        //test app facade
        let config = Config(seed: JSON([
            "key": defaultKey
        ]))
        let app = Application(config: config)
        let result = app.hash.make(string)
        XCTAssert(defaultExpected == result, "Hash did not match")

        //test Hash by itself
        let hash = Hash(key: defaultKey, driver: SHA2Hasher(variant: .sha256))
        XCTAssert(defaultExpected == hash.make(string), "Hash did not match")

        //test all variants of manually
        var expected: [SHA2Hasher.Variant: String] = [:]
        expected[.sha256] = "97ce9a45eaf0b1ceafc3bba00dfec047526386bbd69241e4a4f0c9fde7c638ea"
        expected[.sha384] = "3977579292ed6c50588c5e2e345e84470a8e7f2635ecd89cacedb9d747d05bddb767c2c6943f7ed8ae3abf8c8000bd89"
        expected[.sha512] = "9215c98b5ea5826961395de57f8e4cd2baf3d08c429d4db0f4e2d83feb12e989ffbc7dbf8611ed65ef13e6e8d5f370a803065708f38fd73a349f0869b7891bc6"

        for (variant, expect) in expected {
            let hasher = SHA2Hasher(variant: variant)
            let result = hasher.hash(string, key: defaultKey)
            XCTAssert(result == expect, "Hash for \(variant) did not match")
        }
        
    }

}
