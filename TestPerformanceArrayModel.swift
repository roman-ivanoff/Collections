//
//  TestPerformanceArrayModel.swift
//  CollectionsTests
//
//  Created by Roman Ivanov on 02.07.2022.
//

import XCTest
@testable import Collections

class TestPerformanceArrayModel: XCTestCase {

    var sut: ArrayModel!

    override func setUp() {
        sut = ArrayModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testGenerateArray() {
        measure {
            sut.generateArray {

            } completion: {

            }
        }
    }

    func testPerform() {
        sut.generateArray {

        } completion: {

        }

        measure {
            let operation = ArrayOperation(title: "test") { array in
                var arrayCopy = array
                for i in 0 ..< 1000 {
                    arrayCopy.insert(i, at: 0)
                }
            }
            sut.perform(operation: operation) {

            } completion: {

            }

        }
    }

}
