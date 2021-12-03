//
//  Tree.swift
//  DS
//
//  Created by Ankit on 30/11/21.
//

import Foundation


class TreeNode<T> {
    
    var value : T
    
    var children:[TreeNode] = []
    
    init(value: T) {
        self.value = value
    }
    
    func addChild(node: TreeNode) {
        children.append(node)
    }
}

extension TreeNode {
    func dfs(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach { node in
            node.dfs(visit: visit)
        }
    }
    
    func levelOrder(visit: (TreeNode) -> Void) {
        visit(self)
        var queue = StackQueue<TreeNode>()
        children.forEach {queue.enqueue(value: $0)}
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach {queue.enqueue(value: $0) }
        }
    }
    
    func dfsStack(tree: TreeNode) {
        var result = [T]()
        var stack = Stack<TreeNode>()
        stack.push(value: tree)
        
        while !stack.isEmpty() {
            let pop = stack.pop()
            guard let curentWrap = pop else {
                return
            }
            result.append(curentWrap.value)
            curentWrap.children.forEach { stack.push(value: $0) }
        }
        
        print(result.forEach({print($0)}))
    }
    
    func bfsQueue(tree: TreeNode) {
        var result = [T]()
        var queue = StackQueue<TreeNode>()
        queue.enqueue(value: tree)
        
        while !queue.isEmpty() {
            let dequeue = queue.dequeue()
            guard let dequeueWrap = dequeue else {
                return
            }
            
            result.append(dequeueWrap.value)
            dequeueWrap.children.forEach { queue.enqueue(value: $0) }
        }
        print(result.forEach({print($0)}))
    }
}
