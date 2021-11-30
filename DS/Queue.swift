//
//  Queue.swift
//  DS
//
//  Created by Ankit on 29/11/21.
//

import Foundation

protocol Queue {
    associatedtype Element
    mutating func enqueue(value: Element)
    mutating func dequeue() -> Element?
    func isEmpty() -> Bool
    func peek() -> Element?
}

struct StackQueue<T>: Queue {
    
    private var rightStack: [T] = []
    private var leftStack: [T] = []
    
    mutating func enqueue(value: T) {
        rightStack.append(value)
    }
    
    mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
    
    func isEmpty() -> Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    func peek() -> T? {
        if leftStack.isEmpty {
          return rightStack.first
        }
        return leftStack.last
    }

}

struct DoubleLinkedListQueue<T>: Queue {
    private var linkedList = DoubleLinkedList<T>()
    
    mutating func enqueue(value: T) {
        linkedList.append(value: value)
    }
    
    mutating func dequeue() -> T? {
        guard !linkedList.isEmpty(), let node = linkedList.first() else {
            return nil
        }
        return linkedList.remove(node: node)
    }
    
    func isEmpty() -> Bool {
        linkedList.isEmpty()
    }
    
    func peek() -> T? {
        linkedList.first()?.value
    }
    
}
