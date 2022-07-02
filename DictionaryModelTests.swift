//
//  DictionaryModelTests.swift
//  CollectionsTests
//
//  Created by Roman Ivanov on 02.07.2022.
//

import XCTest
@testable import Collections

class DictionaryModelTests: XCTestCase {

    var sut: DictionaryModel!

    override func setUp() {
        sut = DictionaryModel()
    }

    override func tearDown() {
        sut = nil
    }

    func test_generateData() {
        let exp = expectation(description: "generateData")
        sut.generateData {
        } completion: {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 20)
        XCTAssertTrue(self.sut.array.count == 10_000_000)
        XCTAssertTrue(self.sut.dictionary.count == 10_000_000)
    }

    func test_perform() {
        let exp = expectation(description: "onStart")
        let exp2 = expectation(description: "completion")
        let dictionaryOperation = DictionaryOperation(title: "test") { _, _ in
            let array = [(name: "Name0", phone: "0"), (name: "Name1", phone: "1")]
            return array.first { $0.0 == "Name0" }?.1
        }
        sut.perform(operation: dictionaryOperation) {
            exp.fulfill()
        } completion: {
            exp2.fulfill()
        }
        wait(for: [exp, exp2], timeout: 3)
    }

}
