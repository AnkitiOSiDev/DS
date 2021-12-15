//
//  Heap.swift
//  DS
//
//  Created by Ankit on 11/12/21.
//

import Foundation

struct Heap<T:Equatable> {
    var elements = [T]()
    let sort : (T,T) -> Bool
    func isEmpty() -> Bool{
        elements.isEmpty
    }
    
    
    init(sort: @escaping (T,T) -> Bool) {
        self.sort = sort
    }
    
    init(element: [T],sort: @escaping (T,T) -> Bool) {
        self.sort = sort
        self.elements = element
        
        for index in stride(from: count()/2-1, through: 1, by: -1) {
            siftDown(index: index)
        }
    }
    
    func leftChildIndex(parent index: Int) -> Int {
        2*index + 1
    }
    
    func righChildIndex(parent index: Int) -> Int {
        2*index + 2
    }
    
    func parentIndex(child index: Int) -> Int {
        return (index-1)/2
    }
    
    func peek() -> T?{
        elements.first
    }
    
    func count() -> Int {
        elements.count
    }
    
    
    mutating func remove() -> T? {
        guard isEmpty() else {
            return nil
        }
        
        elements.swapAt(0, count()-1)
        defer {
            siftDown(index: 0)
        }
        return elements.removeLast()
    }
    
    func siftDown(index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(parent: parent)
            let right = righChildIndex(parent: parent)
            var candidate = parent
            if left < count() && sort(elements[left] , elements[candidate]) {
                candidate = left
            }else if right < count() && sort(elements[right],elements[candidate]){
                candidate = right
            }
            if candidate == parent {
                return
            }
            
            parent = candidate
        }
    }
    
    mutating func insert(_ element: T) {
      elements.append(element)
      siftUp(from: elements.count - 1)
    }
    
    mutating func siftUp(from index: Int) {
      var child = index
      var parent = parentIndex(child: index)
      while child > 0 && sort(elements[child], elements[parent]) {
        elements.swapAt(child, parent)
        child = parent
        parent = parentIndex(child: child)
      }
    }
}
