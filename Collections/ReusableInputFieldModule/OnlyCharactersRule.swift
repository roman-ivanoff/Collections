//
//  OnlyCharactersRule.swift
//  Collections
//
//  Created by Roman Ivanov on 28.06.2022.
//

import UIKit

struct OnlyCharactersRule: InputRuleProtocol {
    let model: TextFieldModel
    let regex: String

    func inputRule(string: String) -> Bool {
        if model.checkBackspace(string: string) {
            return true
        }

        if model.contains(string: string, regex: regex) {
            return true
        }

        return false
    }

}
