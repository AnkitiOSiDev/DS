//
//  DoubleLinkedList.swift
//  DS
//
//  Created by Ankit on 29/11/21.
//

import Foundation

struct DoubleLinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    func isEmpty() -> Bool {
        head == nil
    }
    
    func first() -> Node<T>? {
        head
    }
    
    mutating func append(value: T) {
        let node = Node(value: value)
        
        guard let tailNode = tail else {
            head = node
            tail = node
            return
        }
        node.previous = tailNode
        tail?.next = node
        tail = node
    }
    
    mutating func remove(node: Node<T>) -> T? {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = node.next
        } else {
            head = node.next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.next = nil
        node.previous = nil
        
        return node.value
    }
}

extension DoubleLinkedList: CustomStringConvertible {
  
  public var description: String {
    var string = ""
    var current = head
    while let node = current {
      string.append("\(node.value) -> ")
      current = node.next
    }
    return string + "end"
  }
}

struct DoubleLinkedIterator<T>: IteratorProtocol {
    var currentNode: Node<T>?
    init(node: Node<T>?) {
        currentNode = node
    }
    mutating func next() -> Node<T>? {
        defer {
            currentNode = currentNode?.next
        }
        return currentNode
    }
}

extension DoubleLinkedList: Sequence {
    func makeIterator() -> DoubleLinkedIterator<T> {
        return DoubleLinkedIterator(node: head)
    }
}
