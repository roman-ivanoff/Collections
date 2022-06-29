//
//  ArrayOperation.swift
//  Collections
//
//  Created by Roman Ivanov on 29.06.2022.
//

import Foundation

class ArrayOperation {

    let title: String
    var state: OperationState = .idle
    let task: ([Int]) -> Void
    var isCompleted: Bool {
        switch state {
        case .idle, .execution:
            return false
        case .finished:
            return true
        }
    }

    init(title: String, state: OperationState = .idle, task: @escaping ([Int]) -> Void) {
        self.title = title
        self.state = state
        self.task = task
    }
}
