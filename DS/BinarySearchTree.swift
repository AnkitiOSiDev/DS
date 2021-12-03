//
//  BinarySearchTree.swift
//  DS
//
//  Created by Ankit on 02/12/21.
//

import Foundation

struct BinarySearchTree<T: Comparable> {
    var root: BinaryNode<T>?
    
    mutating func insert(value: T) {
        root = insert(node: root, value: value)
    }
    
    func insert(node: BinaryNode<T>?, value: T) -> BinaryNode<T> {
        
        guard let node = node else {
            return BinaryNode(value: value)
        }
        
        if value < node.value {
            node.left = insert(node: node.left, value: value)
        } else {
            node.right = insert(node: node.right, value: value)
        }
        
        return node
    }
    
    func contains(_ value: T) -> Bool {
        
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            
            if node.value > value {
                current = node.left
            }else{
                current = node.right
            }
        }
        
        return false
    }
    
    mutating func remove(value: T) {
        root = remove(node: root, value: value)
    }
    
    func remove(node: BinaryNode<T>?, value: T) -> BinaryNode<T>? {
        
        guard let node = node else {
            return nil
        }
        
        if node.value == value {
            if node.left == nil && node.right == nil {
                return nil
            }
            
            if node.left == nil {
                return node.right
            }
            
            if node.right == nil {
                return node.left
            }
            
            node.value = node.right!.min.value
            node.right = remove(node: node.right, value: node.value)
        }else if (node.value > value){
            node.left = remove(node: node.left, value: value)
        }else {
            node.right = remove(node: node.right, value: value)
        }
        return node;
    }
}



extension BinarySearchTree: CustomStringConvertible {
  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}
