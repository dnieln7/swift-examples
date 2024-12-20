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
    
    func minusDays(_ days: Int) -> Date {
        return addingTimeInterval(-TimeInterval(days) * 24 * 60 * 60)
    }
    
    func plusDays(_ days: Int) -> Date {
        return addingTimeInterval(TimeInterval(days) * 24 * 60 * 60)
    }
    
    func atStartOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}
