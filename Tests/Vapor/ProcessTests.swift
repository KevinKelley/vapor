//
//  ProcessTests.swift
//  Vapor
//
//  Created by Logan Wright on 2/27/16.
//  Copyright © 2016 Tanner Nelson. All rights reserved.
//

import XCTest
@testable import Vapor

class ProcessTests: XCTestCase {

    static var allTests: [(String, (ProcessTests) -> () throws -> Void)] {
        return [
            ("testArgumentExtraction", testArgumentExtraction),
            ("testFixes", testFixes)
        ]
    }

    func testArgumentExtraction() {
        let testArguments = ["--ip=123.45.1.6", "--port=8080", "--workDir=WorkDirectory"]

        let ip = testArguments.value(for: "ip")
        XCTAssert(ip == "123.45.1.6")

        let port = testArguments.value(for: "port")
        XCTAssert(port == "8080")

        let workDir = testArguments.value(for: "workDir")
        XCTAssert(workDir == "WorkDirectory")
    }

    func testFixes() {
        let bytes: [UInt8] = [64, 64, 64]
        let string = String(data: bytes)
        XCTAssert(string == "@@@")
    }
}
