//
//  Date+Extension.swift
//  SwiftExtensionKit
//
//  Copyright (c) 2017-2024 RichAppz Limited (https://richappz.com)
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

let standardDateFormat = "dd/MM/yyyy"

public extension Date {
    
    var weekDay: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var startOfMonth: Date? {
        let interval = Calendar.current.dateInterval(of: .month, for: self)
        return interval?.start.toLocalTime
    }
    
    var endOfMonth: Date? {
        
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth ?? Date())!
    }
    
    var string: String {
        let formatter = DateFormatter()
        formatter.dateFormat = standardDateFormat
        return formatter.string(from: self)
    }
    
    func isSameDayAs(_ date: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date)
        return diff.day == 0
    }
    
}

extension Optional where Wrapped == Date {
    var string: String {
        let formatter = DateFormatter()
        formatter.dateFormat = standardDateFormat
        guard let date = self else { return "No Date"}
        return formatter.string(from: date )
    }
}

private extension Date {
    
    var toLocalTime: Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
}
