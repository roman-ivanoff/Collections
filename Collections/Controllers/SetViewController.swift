//
//  SetViewController.swift
//  Collections
//
//  Created by Roman Ivanov on 28.06.2022.
//

import UIKit

class SetViewController: UIViewController {
    var model: SetModel? = nil
    let textFieldModel = TextFieldModel()
    var navigationItemNumber: Int!
    let regex = "[A-Za-z]"
    private lazy var onlyCharactersDelegateObject = InputRuleTextFieldDelegate(rule: OnlyCharactersRule(
        model: textFieldModel, regex: regex))

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var allMatchingLettersLabel: UILabel!
    @IBOutlet weak var charactersThatDoNotMatchLabel: UILabel!
    @IBOutlet weak var uniqueCharactersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Set: \(navigationItemNumber!)"

        firstTextField.delegate = onlyCharactersDelegateObject
        secondTextField.delegate = onlyCharactersDelegateObject
    }

    @IBAction func getAllMatchingLettersAction(_ sender: UIButton) {
        allMatchingLettersLabel.text = model?.getAllMatchingLetters(firstTextField.text!, secondTextField.text!)

        allMatchingLettersLabel.isHidden = false
    }

    @IBAction func getAllCharactersThatDoNotMatchAction(_ sender: UIButton) {
        charactersThatDoNotMatchLabel.text = model?.getAllDifferentLetters(firstTextField.text!, secondTextField.text!)

        charactersThatDoNotMatchLabel.isHidden = false
    }

    @IBAction func getAllUniqueCharactersAction(_ sender: UIButton) {
        charactersThatDoNotMatchLabel.text = model?.getAllDifferentLetters(firstTextField.text!, secondTextField.text!)

        charactersThatDoNotMatchLabel.isHidden = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

}
