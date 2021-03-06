//
//  ArrayModel.swift
//  Collections
//
//  Created by Roman Ivanov on 29.06.2022.
//

import Foundation

enum OperationState {
    case idle
    case execution
    case finished(time: Double)
}

class ArrayModel {
    let queue = DispatchQueue(label: "Array operation execution queue")
    var array = [Int]()
    var arrayGeneration: OperationState = .idle
    var arrayOperations: [ArrayOperation] = [
        ArrayOperation(title: "Insert 1000 elements at the beginning of the array one-by-one", task: {
            var arrayCopy = $0
            for i in 0 ..< 1000 {
                arrayCopy.insert(i, at: 0)
            }
        }),
        ArrayOperation(title: "Insert 1000 elements at the beginning of the array at once", task: {
            var arrayCopy = $0
            arrayCopy.insert(contentsOf: 1...1000, at: 0)
        }),
        ArrayOperation(title: "Insert 1000 elements in the middle of the array one-by-one", task: {
            var arrayCopy = $0
            for i in 0 ..< 1000 {
                arrayCopy.insert(i, at: arrayCopy.count / 2)
            }
        }),
        ArrayOperation(title: "Insert 1000 elements in the middle of the array all at once", task: {
            var arrayCopy = $0
            arrayCopy.insert(contentsOf: 1...1000, at: arrayCopy.count / 2)
        }),
        ArrayOperation(title: "Insert 1000 elements in the end of the array one-by-one", task: {
            var arrayCopy = $0
            for i in 0 ..< 1000 {
                arrayCopy.append(i)
            }
        }),
        ArrayOperation(title: "Insert 1000 elements in the end of the array all at once", task: {
            var arrayCopy = $0
            arrayCopy.append(contentsOf: 1...1000)
        }),
        ArrayOperation(title: "Remove 1000 elements at the beginning of the array one-by-one", task: {
            var arrayCopy = $0
            for _ in 0 ..< 1000 {
                arrayCopy.remove(at: 0)
            }
        }),
        ArrayOperation(title: "Remove 1000 elements at the beginning of the array", task: {
            var arrayCopy = $0
            arrayCopy.removeSubrange(0 ..< 1000)
        }),
        ArrayOperation(title: "Remove 1000 elements in the middle of the array one-by-one", task: {
            var arrayCopy = $0
            for _ in 0 ..< 1000 {
                arrayCopy.remove(at: arrayCopy.count / 2)
            }
        }),
        ArrayOperation(title: "Remove 1000 elements in the middle of the array", task: {
            var arrayCopy = $0
            arrayCopy.removeSubrange(arrayCopy.count / 2 ..< arrayCopy.count / 2 + 1000)
        }),
        ArrayOperation(title: "Remove 1000 elements at the end of the array by-one-one", task: {
            var arrayCopy = $0
            for _ in 0 ..< 1000 {
                arrayCopy.removeLast()
            }
        }),
        ArrayOperation(title: "Remove 1000 elements at the end of the array", task: {
            var arrayCopy = $0
            arrayCopy.removeSubrange(arrayCopy.count - 1000 ..< arrayCopy.count)
        })
    ]

    func generateArray(onStart: @escaping () -> Void, completion: @escaping () -> Void) {
        arrayGeneration = .execution
        onStart()
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }

            var arr: [Int] = []
            let arrayGenerationTime = self.measureExecutionTime {
                for i in 0 ..< 10_000_000 {
                    arr.append(i)
                }
            }

            DispatchQueue.main.async {
                self.array = arr
                self.arrayGeneration = .finished(time: arrayGenerationTime)
                completion()
            }
        }
    }

    func perform(operation: ArrayOperation, onStart: @escaping () -> Void, completion: @escaping () -> Void) {
        operation.state = .execution
        onStart()
        queue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            let executionTime = self.measureExecutionTime {
                operation.task(self.array)
            }
            DispatchQueue.main.async {
                operation.state = .finished(time: executionTime)
                completion()
            }
        }
    }

    func measureExecutionTime(_ block: () -> Void) -> Double {
        let beginTime = CFAbsoluteTimeGetCurrent()
        block()
        let endTime = CFAbsoluteTimeGetCurrent()

        return endTime - beginTime
    }
}
