//
//  Int+Extension.swift
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

public enum DayType: Int {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

public extension Int {
    
    /**
     Converts unit number to currency string
     - Parameter currencyCode: String
     */
    func getLocalisedCurrencyString(currencyCode: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.roundingMode = .down
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = currencyCode
        
        guard let priceString = currencyFormatter.string(
            from: NSNumber(value: Double(self)/100.0)) else { return "" }
        
        return priceString
    }
    
    var dayBackendConversion: Int {
        switch self {
        case 1: return 6
        case 2: return 0
        case 3: return 1
        case 4: return 2
        case 5: return 3
        case 6: return 4
        case 7: return 5
        default: return 0
        }
    }
    
    /**
     Works out the percentage of an int
     */
    func percentage(_ percentage: Double) -> Double {
        let val = Double(self) * percentage
        return val / 100.0
    }
    
}
