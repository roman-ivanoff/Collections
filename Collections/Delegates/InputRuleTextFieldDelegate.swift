//
//  InputRuleTextFieldDelegate.swift
//  Collections
//
//  Created by Roman Ivanov on 28.06.2022.
//

import UIKit

class InputRuleTextFieldDelegate: NSObject {
    private let inputRule: InputRuleProtocol

    init(rule: InputRuleProtocol) {
        self.inputRule = rule
        super.init()
    }
}

extension InputRuleTextFieldDelegate: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        inputRule.inputRule(string: string)
    }
}
