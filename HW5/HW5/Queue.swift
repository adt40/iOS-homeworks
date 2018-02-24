//
//  Queue.swift
//  HW5
//
//  Created by Austin Toot on 2/24/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import Foundation

struct Queue<Element> {
    var items = [Element]()
    var count: Int {
        get {
            return items.count
        }
    }
    mutating func enqueue(_ item: Element) {
        items.append(item)
    }
    mutating func dequeue() -> Element? {
        if isEmpty() {
            return nil
        } else {
            return items.removeFirst()
        }
    }
    func peek() -> Element? {
        return items.first
    }
    mutating func clear() {
        items = [Element]()
    }
    func isEmpty() -> Bool {
        return count == 0
    }
}
