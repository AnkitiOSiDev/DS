//
//  Stack.swift
//  DS
//
//  Created by Ankit on 29/11/21.
//

import Foundation

struct Stack<T> {
    var storage: [T] = []
    
    mutating func push(value:T) {
        storage.append(value)
    }
    
    mutating func pop() -> T? {
        storage.popLast()
    }
    
    func peek() -> T? {
        storage.last
    }
    
    func isEmpty() -> Bool {
        peek() == nil
    }
}
