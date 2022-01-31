//
//  Array+Extension.swift
//  SwiftExtensionKit
//
//  Copyright (c) 2017-2022 RichAppz Limited (https://richappz.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

// https://stackoverflow.com/questions/26371751/changing-the-value-of-struct-in-an-array

public extension Array {
    
    mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> Void) {
        for index in indices {
            modifyElement(atIndex: index) { body(index, &$0) }
        }
    }

    /**
     Enabling the mutation of a object inside a array
     */
    mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> Void) {
        var element = self[index]
        modifyElement(&element)
        self[index] = element
    }
    
    /**
     Split an array into chucks
     */
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }

}

extension Sequence {

    /**
     Return the sequence with all duplicates removed.
     Duplicate, in this case, is defined as returning `true` from `comparator`.
     
     - note: Taken from stackoverflow.com/a/46354989/3141234
     */
    func uniqued(comparator: @escaping (Element, Element) throws -> Bool) rethrows -> [Element] {
        var buffer: [Element] = []

        for element in self {
            // If element is already in buffer, skip to the next element
            if try buffer.contains(where: { try comparator(element, $0) }) {
                continue
            }

            buffer.append(element)
        }

        return buffer
    }
}

public extension Sequence where Element: Equatable {

    /**
     Return the sequence with all duplicates removed.
     i.e. `[ 1, 2, 3, 1, 2 ].uniques == [ 1, 2, 3 ]`
     - note: Taken from stackoverflow.com/a/46354989/3141234
     */
    var uniques: [Element] {
        return self.uniqued(comparator: ==)
    }
    
}
