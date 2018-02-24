//
//  Stack.swift
//  HW5
//
//  Created by Austin Toot on 2/24/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import Foundation

struct Stack<Element> {
    var items = [Element]()
    var count: Int {
        get {
            return items.count
        }
    }
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element? {
        if isEmpty() {
            return nil
        } else {
            return items.removeLast()
        }
    }
    func peek() -> Element? {
        return items.last
    }
    func isEmpty() -> Bool {
        return count == 0
    }
}
