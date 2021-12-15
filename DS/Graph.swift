//
//  Graph.swift
//  DS
//
//  Created by Ankit on 10/12/21.
//

import Foundation

enum EdgeType {
    case directed
    case uniDirected
}

protocol Graph {
    associatedtype Element
    func createVertex(data: Element) -> Vertex<Element>
    func directed(from source: Vertex<Element>,to destination: Vertex<Element>, weight: Double?)
    func uniDirected(betwen source: Vertex<Element>,and destination: Vertex<Element>, weight: Double?)
    func add(edge: EdgeType, source: Vertex<Element>,to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>,to destination: Vertex<Element>) -> Double?
}

struct Vertex<T> {
    let data : T
    let index: Int
}

extension Vertex: Hashable where T : Hashable {
    
}

extension Vertex: Equatable where T : Equatable  {
    
}

struct Edge<T> {
    var weight : Double?
    var source: Vertex<T>
    var dest: Vertex<T>
}


class AdjecencyList<T: Hashable> : Graph {
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(data: data, index: adjencies.count)
        adjencies[vertex] = []
        return vertex
    }
    
    func directed(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(weight: weight, source: source, dest: destination)
        adjencies[source]?.append(edge)
    }
    
    func uniDirected(betwen source: Vertex<T>, and destination: Vertex<T>, weight: Double?) {
        directed(from: source, to: destination, weight: weight)
        directed(from: destination, to: source, weight: weight)
    }
    
    func add(edge: EdgeType, source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        switch edge {
        case .directed:
            directed(from: source, to: destination, weight: weight)
        case .uniDirected:
            uniDirected(betwen: source, and: destination, weight: weight)
        }
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjencies[source] ?? []
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        edges(from: source).first(where: {$0.dest == destination})?.weight
    }
    
    typealias Element = T
    
   
    var adjencies : [Vertex<T>:[Edge<T>]] = [:]
    
    init() {
        
    }
    
}


class AdjanceyMatrix<T> : Graph {
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(data: data, index: vertices.count)
        vertices.append(vertex)
        for row in 0..<weight.count {
            weight[row].append(nil)
        }
        let row = [Double?](repeating: nil, count: vertices.count)
        weight.append(row)
        return vertex
    }
    
    func directed(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        self.weight[source.index][destination.index] = weight
    }
    
    func uniDirected(betwen source: Vertex<T>, and destination: Vertex<T>, weight: Double?) {
        directed(from: source, to: destination, weight: weight)
        directed(from: destination, to: source, weight: weight)
    }
    
    func add(edge: EdgeType, source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        switch edge {
        case .directed:
            directed(from: source, to: destination, weight: weight)
        case .uniDirected:
            uniDirected(betwen: source, and: destination, weight: weight)
        }
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges : [Edge<T>] = []
        for column in 0..<weight.count {
            if let weight = weight[source.index][column] {
                edges.append(Edge(weight: weight, source: source, dest: vertices[column]))
            }
        }
        return edges
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        self.weight[source.index][destination.index]
    }
    
  typealias Element = T
    
    private var vertices = [Vertex<T>]()
    private var weight = [[Double?]]()
    
    init() {
        
    }
    
    
}

extension Graph where Element : Hashable {
    func BFS(source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = StackQueue<Vertex<Element>>()
        var enqueued = Set<Vertex<Element>>()
        var visited = [Vertex<Element>]()
        
        queue.enqueue(value: source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighbour = edges(from: vertex)
            neighbour.forEach { edge in
                if !(enqueued.contains(edge.dest)) {
                    queue.enqueue(value: edge.dest)
                    enqueued.insert(edge.dest)
                }
            }
        }
        
        return visited
    }
    
    func DFS(source: Vertex<Element>) -> [Vertex<Element>] {
        var visited = [Vertex<Element>]()
        var stack = Stack<Vertex<Element>>()
        var pushed = Set<Vertex<Element>>()
        
        stack.push(value: source)
        pushed.insert(source)
        visited.append(source)
        
        outer: while let vertex = stack.peek() {
            let neighbours = edges(from: vertex)
            guard !neighbours.isEmpty else {
                stack.pop()
                continue
            }
            
            for edge in neighbours {
                if !pushed.contains(edge.dest) {
                    stack.push(value: edge.dest)
                    pushed.insert(edge.dest)
                    visited.append(edge.dest)
                    continue outer
                }
            }
            stack.pop()
        }
        return visited
    }
}
