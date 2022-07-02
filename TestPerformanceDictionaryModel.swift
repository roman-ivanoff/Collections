//
//  TestPerformanceDictionaryModel.swift
//  CollectionsTests
//
//  Created by Roman Ivanov on 02.07.2022.
//

import XCTest
@testable import Collections

class TestPerformanceDictionaryModel: XCTestCase {

    var sut: DictionaryModel!

    override func setUp() {
        sut = DictionaryModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testGenerateData() {
        measure {
            sut.generateData {

            } completion: {

            }
        }
    }

    func testPerformArrayOperation() {
        sut.generateData {
        } completion: {
        }
        let dictionaryOperation = DictionaryOperation(title: "test") { array, _ in
            return array.first { $0.0 == "Name0" }?.1
        }

        measure {
            sut.perform(operation: dictionaryOperation) {

            } completion: {

            }

        }
    }

    func testPerformDictionaryOperation() {
        sut.generateData {
        } completion: {
        }
        let dictionaryOperation = DictionaryOperation(title: "test") { _, dictionary in
            return dictionary["Name0"]
        }

        measure {
            sut.perform(operation: dictionaryOperation) {

            } completion: {

            }

        }
    }

}
