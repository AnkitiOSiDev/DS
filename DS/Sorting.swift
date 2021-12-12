//
//  Sorting.swift
//  DS
//
//  Created by Ankit on 04/12/21.
//

import Foundation

class Sort {
    
    static func bubbleSort<T: Comparable>(array: inout [T]) {
        
        guard array.count > 1 else {
            return
        }
        
        var swap = false
        
        for end in (1..<array.count).reversed() {
            for current in 0..<end {
                if array[current] > array[current+1] {
                    array.swapAt(current, current+1)
                    swap = true
                }
            }
            
            if !swap {
                return
            }
        }
    }
    
    static func selectionSort<T: Comparable>(array: inout [T]) {
        guard array.count > 1 else {
            return
        }
        for current in 0..<array.count-1 {
            var lowest = current
            for other in (current+1)..<array.count {
                if array[lowest] > array[other] {
                    lowest = other
                }
            }
            if lowest != current {
                array.swapAt(lowest, current)
            }
        }
    }
    
    static func insersionSort<T:Comparable>(array: inout [T]) {
        
        guard  array.count > 1 else {
            return
        }
        
        for current in 1..<array.count {
            for shifting in (1...current).reversed() {
                if array[shifting] < array[shifting-1] {
                    array.swapAt(shifting, shifting-1)
                }else{
                    break;
                }
            }
        }
    }
    
    
    
    func bubble<T: MutableCollection>(collection: inout T ) where T.Element : Comparable{
        
        guard collection.count > 1 else {
            return
        }
        
       
        for end in collection.indices.reversed() {
            var swap = false
            var current = collection.startIndex
            
            while current < end {
                let next = collection.index(after: current)
                if collection[current] > collection[next] {
                    collection.swapAt(current, next)
                    swap = true
                }
                current = next
            }
            
            if !swap {
                return
            }
        }
    }
    
    func selectionSort<T:MutableCollection> (collection : inout T) where T.Element : Comparable {
        guard collection.count > 1 else {
            return
        }
        
        for current in collection.indices {
            var lowest = current
            var other = collection.index(after: current)
            
            while other < collection.endIndex  {
                if collection[lowest] > collection[other] {
                    lowest = other
                }
                other = collection.index(after: other)
            }
            
            if lowest != current {
                collection.swapAt(lowest, current)
            }
        }
    }
    
    func insertionSort<T:BidirectionalCollection & MutableCollection> (collection : inout T) where T.Element : Comparable {
        guard collection.count > 1 else {
            return
        }
        
        for current in collection.indices {
            var shifting = current
            while shifting > collection.startIndex {
                let previous = collection.index(before: shifting)
                if collection[previous] > collection[shifting] {
                    collection.swapAt(previous, shifting)
                }else{
                    break
                }
                shifting = previous
            }
        }
    }
    
    
   static func mergeSort<T:Comparable>(array: [T]) -> [T] {
        
        guard array.count > 1 else {
            return array
        }
        
        let middle = array.count/2
        let left =  mergeSort(array:Array(array[..<middle]))
        let right =  mergeSort(array:Array(array[middle...]))
        
        return merge(left, right)
    }
    
    
    
    static func merge<T:Comparable>(_ left: [T],_ right: [T]) -> [T]{
        var leftIndex = 0
        var rightIndex = 0
        var result = [T]()
        
        while leftIndex < left.count && rightIndex < right.count {
            let leftValue = left[leftIndex]
            let rightValue = right[rightIndex]
            
            if leftValue < rightValue {
                result.append(left[leftIndex])
                leftIndex+=1
            }else if leftValue > rightValue {
                result.append(right[rightIndex])
                rightIndex+=1
            }else {
                result.append(left[leftIndex])
                leftIndex+=1
                result.append(right[rightIndex])
                rightIndex+=1
            }
        }
        
        if leftIndex < left.count {
            result.append(contentsOf: left[leftIndex...])
        }
        
        if rightIndex < right.count {
            result.append(contentsOf: right[rightIndex...])
        }
        return result
    }
    
    
    static func getPivot<T:Comparable>(array: inout [T], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var index = low
        
        for jposition in low..<high {
            if array[jposition] <= pivot {
                array.swapAt(jposition, index)
                index+=1
            }
        }
        
        array.swapAt(index, high)
        return index
    }
    
    static func quickSort<T:Comparable>(array: inout [T], low: Int, high: Int) {
        if low < high {
            let pivot = getPivot(array: &array, low: low, high: high)
            quickSort(array: &array, low: low, high: pivot-1)
            quickSort(array: &array, low: pivot+1, high: high)
        }
    }
}

