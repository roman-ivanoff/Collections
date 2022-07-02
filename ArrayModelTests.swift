//
//  ArrayModelTests.swift
//  CollectionsTests
//
//  Created by Roman Ivanov on 02.07.2022.
//

import XCTest
@testable import Collections

class ArrayModelTests: XCTestCase {

    var sut: ArrayModel!

    override func setUp() {
        sut = ArrayModel()
    }

    override func tearDown() {
        sut = nil
    }

    func test_generateArray() {
        let exp = expectation(description: "generateArray")
        sut.generateArray {

        } completion: {
            exp.fulfill()
        }

        wait(for: [exp], timeout: 8)
        XCTAssertTrue(self.sut.array.count == 10_000_000)
    }

    func test_perform() {
        let exp = expectation(description: "onStart")
        let exp2 = expectation(description: "completion")
        let operation = ArrayOperation(title: "test") {_ in
            var arrayCopy = [1, 2, 3]
            for i in 0 ..< 1000 {
                arrayCopy.insert(i, at: 0)
            }
        }

        sut.perform(operation: operation) {
            exp.fulfill()
        } completion: {
            exp2.fulfill()
        }

        wait(for: [exp, exp2], timeout: 5)
    }

}
