//
//  SetModel.swift
//  Collections
//
//  Created by Roman Ivanov on 28.06.2022.
//

import UIKit

class SetModel {
    func getAllMatchingLetters(_ string1: String, _ string2: String) -> String {
        let set1 = Set(string1)
        let set2 = Set(string2)
        return String(set1.intersection(set2))
    }

    func getAllDifferentLetters(_ string1: String, _ string2: String) -> String {
        let set1 = Set(string1)
        let set2 = Set(string2)
        return String(set1.symmetricDifference(set2))
    }

    func getAllUniqueDifferentLetters(_ string1: String, _ string2: String) -> String {
        let set1 = Set(string1)
        let set2 = Set(string2)

        let dif = set1.subtracting(set2)

        return String(dif)
    }
}
