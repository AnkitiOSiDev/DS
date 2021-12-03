//
//  BinaryTree.swift
//  DS
//
//  Created by Ankit on 01/12/21.
//

import Foundation

class BinaryNode<T> {
    var value: T
    var left: BinaryNode<T>?
    var right: BinaryNode<T>?
    
    init(value: T) {
        self.value = value
    }
    
    var min : BinaryNode {
        return left?.min ?? self
    }
}

extension BinaryNode {
    func inOrder(visit: (BinaryNode) -> Void) {
        left?.inOrder(visit: visit)
        visit(self)
        right?.inOrder(visit: visit)
    }
}


