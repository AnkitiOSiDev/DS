//
//  Linkedlist.swift
//  DS
//
//  Created by Ankit on 27/11/21.
//

import Foundation

class Node<T> {
    var value: T
    var next: Node?
    var previous: Node?
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) -> \(next)"
    }
}

struct LinkedList <T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    init() {
        
    }
    
    var isEmpty: Bool {
        return head == nil
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else {
            return "Empty"
        }
        
        return "\(head)"
    }
}

extension LinkedList {
    mutating func push(value: T) {
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    mutating func append(value: T) {
        let node = Node(value: value)
        guard !isEmpty else {
            push(value: value)
             return
        }
        
        tail?.next = node
        tail = node
    }
    
    func node(at index: Int) -> Node<T>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    mutating func insert(value: T, after index: Int) {
        if let currentNode = node(at: index) {
            if tail === currentNode {
                append(value: value )
                return
            }
            currentNode.next = Node(value: value, next: currentNode.next)
        }
    }
}

extension LinkedList {
    
    mutating func pop() {
        head = head?.next
        if isEmpty {
            tail = nil
        }
    }
    
    mutating func removeLast() {
        if isEmpty {
            return
        }
        
        if head?.next == nil {
            pop()
            return
        }
        
        var currentNode = head
        var secondLastNode: Node<T>?
        
        while currentNode?.next != nil {
            secondLastNode = currentNode
            currentNode = currentNode?.next
        }
        
        secondLastNode?.next = nil
        tail = secondLastNode
    }
    
    mutating func remove(after index: Int) {
        if let node = node(at: index) {
            if node.next === tail {
               tail = node
               return
            }
            node.next = node.next?.next
        }
    }
    
}

extension LinkedList: Collection {
    
    struct Index: Comparable {
        static func < (lhs: LinkedList<T>.Index, rhs: LinkedList<T>.Index) -> Bool {
            guard lhs != rhs else {
                return false
            }

            let nodes = sequence(first: lhs.node) { node in
                return node?.next
            }

            return nodes.contains { node in
                node === rhs.node
            }
        }

        var node: Node<T>?

        static func == (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
               return left.next === right.next
            case (nil, nil):
                return true
            default:
              return false
            }
        }
    }

    var startIndex: Index {
        return Index(node: head)
    }

    var endIndex: Index {
        return Index(node: tail?.next)
    }

    func index(after index: Index) -> Index {
        return Index(node: index.node?.next)
    }

    subscript(position: Index) -> T? {
        return position.node?.value
    }
}

extension LinkedList {
    mutating func copyList() {
        guard var oldNode = head, !(isKnownUniquelyReferenced(&head)) else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        print("\(String(describing: newNode?.value))")
        while let oldNextNode = oldNode.next {
            newNode?.next = Node(value: oldNextNode.value)
            print("\(String(describing: newNode?.value))")
            newNode = newNode?.next
            print("\(String(describing: newNode?.value))")
            oldNode = oldNextNode
        }
        
        tail = newNode
    }
}
