#!/usr/bin/swift
// O(1) enqueue, dequeue, peek, isEmpty
// O(n) contains, remove


protocol Queuing {
    associatedtype Element
    
    var size: Int { get }
    func isEmpty() -> Bool
    func peek() -> Element?
    mutating func enqueue(_ element: Element)
    @discardableResult mutating func dequeue() -> Element?
}

struct Queue<T>: Queuing {
    typealias Element = T

    var elements: [Element] = []

    var size: Int {
        elements.count
    }    

    func isEmpty() -> Bool {
        elements.isEmpty
    }
    
    func peek() -> Element? {
        elements.first
    }
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
    }
    
    @discardableResult mutating func dequeue() -> Element? {
        elements.isEmpty ? nil : elements.removeFirst()
    }
}

var queue = Queue<Int>()
queue.enqueue(3)
queue.enqueue(5)
queue.enqueue(9)
queue.dequeue()
print(queue.elements)
