//
//  DictionaryModel.swift
//  Collections
//
//  Created by Roman Ivanov on 30.06.2022.
//

import Foundation

enum DictinaryOperationState {
    case idle
    case execution
    case finished(time: Double, number: String)
}

class DictionaryModel {
    let queue = DispatchQueue(label: "Dictionary operation execution queue")
    var array: [(name: String, phone: String)] = []
    var dictionary: [String: String] = [:]
    var dataGeneration: DictinaryOperationState = .idle
    var operations: [DictionaryOperation] = [
        DictionaryOperation(title: "Find the first contact", task: { array, _ in
            return array.first { $0.0 == "Name0" }?.1
        }),
        DictionaryOperation(title: "Find the first contact", task: { _, dictionary in
            return dictionary["Name0"]
        }),
        DictionaryOperation(title: "Find the last contact", task: { array, _ in
            return array.first { $0.0 == "Name9999999" }?.1
        }),
        DictionaryOperation(title: "Find the last contact", task: { _, dictionary in
            return dictionary["Name9999999"]
        }),
        DictionaryOperation(title: "Find the non-existing element", task: { array, _ in
            return array.first { $0.0 == "NameQwerty" }?.1
        }),
        DictionaryOperation(title: "Find the non-existing element", task: { _, dictionary in
            return dictionary["NameQwerty"]
        })
    ]

    func generateData(onStart: @escaping () -> Void, completion: @escaping () -> Void) {
        dataGeneration = .execution
        onStart()
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                for i in 0 ..< 10_000_000 {
                    self.array.append((name: "Name\(i)", phone: String(i)))
                    self.dictionary.updateValue(String(i), forKey: "Name\(i)")
                }
                self.dataGeneration = .finished(time: 0, number: "-1")
                completion()
            }
        }
    }

    func perform(operation: DictionaryOperation, onStart: @escaping () -> Void, completion: @escaping () -> Void) {
        operation.state = .execution
        onStart()
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let executionTimeAndNumber = self.getExecutionTimeAndNumber {
                operation.task(&self.array, &self.dictionary)
            }
            DispatchQueue.main.async {
                operation.state = .finished(time: executionTimeAndNumber.0, number: executionTimeAndNumber.1 ?? "Not found")
                completion()
            }
        }
    }

    func getExecutionTimeAndNumber(_ block: () -> String?) -> (Double, String?) {
        let beginTime = CFAbsoluteTimeGetCurrent()
        _ = block()
        let endTime = CFAbsoluteTimeGetCurrent()

        return (endTime - beginTime, block())
    }
}
