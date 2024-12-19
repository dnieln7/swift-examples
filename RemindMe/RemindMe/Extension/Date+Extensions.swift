//
//  DateExtensions.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 13/12/24.
//

import Foundation

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    var dateComponents: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
}
