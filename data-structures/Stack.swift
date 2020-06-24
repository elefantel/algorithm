#!/usr/bin/swift
// O(1) push, pop, peek, size
// O(n) search

protocol Stacking {
    associatedtype Element

    var size: Int { get }
    func isEmpty() -> Bool
    func peek() -> Element?
    mutating func push(_ element: Element)
    @discardableResult mutating func pop() -> Element?
}

struct Stack<T>: Stacking {
    typealias Element = T
    
    var elements: [Element] = []
    
    var size: Int {
        elements.count
    }

    func isEmpty() -> Bool {
        elements.isEmpty
    }

    func peek() -> Element? {
        elements.last
    }    

    mutating func push(_ element: Element) {
        elements.append(element)
    }

    @discardableResult mutating func pop() -> Element? {
        elements.popLast()
    }
}

var stack = Stack<Int>()
stack.push(5)
stack.push(7)
print(stack.elements)

