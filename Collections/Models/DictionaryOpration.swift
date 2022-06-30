//
//  DictionaryOpration.swift
//  Collections
//
//  Created by Roman Ivanov on 30.06.2022.
//

import Foundation

class DictionaryOperation {

    let title: String
    var state: DictinaryOperationState = .idle
    let task: (inout [(name: String, phone: String)], inout [String: String]) -> String?
    var isCompleted: Bool {
        switch state {
        case .idle, .execution:
            return false
        case .finished:
            return true
        }
    }

    init(title: String, state: DictinaryOperationState = .idle, task: @escaping (inout [(name: String, phone: String)], inout [String: String]) -> String?) {
        self.title = title
        self.state = state
        self.task = task
    }
}
