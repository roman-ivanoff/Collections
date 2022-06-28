//
//  TextFieldModel.swift
//  Collections
//
//  Created by Roman Ivanov on 28.06.2022.
//

import Foundation

class TextFieldModel {
    func contains(string: String, regex: String) -> Bool {
        let regexRule = NSPredicate(format: "SELF MATCHES %@ ", regex)
        return regexRule.evaluate(with: string)
    }

    func checkBackspace(string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackspace = strcmp(char, "\\b")
            if isBackspace == -92 {
                return true
            }
        }

        return false
    }
}
