//
//  SetModelTests.swift
//  CollectionsTests
//
//  Created by Roman Ivanov on 02.07.2022.
//

import XCTest
@testable import Collections

class SetModelTests: XCTestCase {

    var sut: SetModel!

    override func setUp() {
        sut = SetModel()
    }

    override func tearDown() {
        sut = nil
    }

    func test_getAllMatchingLetters() {
        let firstPhrase = "Qwerty"
        let secondPhrase = "Qazr"
        let expected = CharacterSet(charactersIn: "Qr")
        let result = sut.getAllMatchingLetters(firstPhrase, secondPhrase)
        XCTAssertTrue(expected == CharacterSet(charactersIn: result))
    }

    func test_getAllDifferentLetters() {
        let firstPhrase = "Qwerty"
        let secondPhrase = "Qazr"
        let expected = CharacterSet(charactersIn: "tzweay")
        let result = sut.getAllDifferentLetters(firstPhrase, secondPhrase)
        XCTAssertTrue(expected == CharacterSet(charactersIn: result))
    }

    func test_getAllUniqueDifferentLetters() {
        let firstPhrase = "Qwerty"
        let secondPhrase = "Qazr"
        let expected = CharacterSet(charactersIn: "ytew")
        let result = sut.getAllUniqueDifferentLetters(firstPhrase, secondPhrase)
        XCTAssertTrue(expected == CharacterSet(charactersIn: result))
    }


}
