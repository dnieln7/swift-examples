import Foundation

func useDates() {
    let now = Date()
    let tomorrow = Date(
        timeIntervalSinceNow: HOURS_IN_A_DAY * MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE
    )
    let tenDaysBeforeNextDay = Date(
        timeInterval: -10 * HOURS_IN_A_DAY * MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE,
        since: tomorrow
    )
    
    print("now: \(now)")
    print("tomorrow: \(tomorrow)")
    print("tenDaysBeforeNextDay: \(tenDaysBeforeNextDay)")
    
    print(".now: \(Date.now)")
    print(".distantFuture: \(Date.distantFuture)")
    print(".distantPast: \(Date.distantPast)")
    
    if now.compare(tomorrow) == ComparisonResult.orderedAscending {
        print("now is less than tomorrow")
    }
    
    /// calendars and components
    let calendar = Calendar.current
    var components = calendar.dateComponents(
        [Calendar.Component.year],
        from: now
    )
    
    print("The year is \(components.year ?? 0)")
    
    var customComponents = DateComponents()
    customComponents.year = 2000
    customComponents.month = 9
    customComponents.day = 23
    
    var dateFromCalendar = calendar.date(from: customComponents)!
    
    print("date from custom component \(dateFromCalendar)")
    
    let customCalendar = Calendar(identifier: Calendar.Identifier.chinese)
    
    var dateFromChineseCalendar = customCalendar.date(from: customComponents)!
    
    print("date from custom component of custom calendar \(dateFromChineseCalendar)")
    
    let tomorrowFromCalendar = Calendar.current.date(byAdding: Calendar.Component.day, value: 1, to: Date.now)
    print("tomorrowFromCalendar \(tomorrowFromCalendar!)")
    /// calendars and components
    
    /// operations
    var comp = DateComponents()
    comp.day = 7
    var appointment = calendar.date(byAdding: comp, to: now)
    
    var comp2 = DateComponents()
    comp2.year = 1998
    comp2.month = 7
    comp2.day = 21
    
    let birthday = calendar.date(from: comp2)
    
    if let it = birthday {
        let comp3 = calendar.dateComponents([.year], from: it, to: now)
        
        print("I have \(comp3.year!) years")
    }
    /// operations
    
    /// intervals
    let tomorrow2 = Date.now.advanced(
        by: HOURS_IN_A_DAY * MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE
    )
    let interval = DateInterval(
        start: Date.now,
        end: Date.now.advanced(
            by: HOURS_IN_A_DAY * MINUTES_IN_AN_HOUR * SECONDS_IN_A_MINUTE
        )
    )
    
    print("Interval \(interval)")
    print("contains tomorrow2 \(interval.contains(tomorrow2))")
    /// intervals
    
    /// formatting
    print("default \(now.formatted())")
    print("only date \(now.formatted(date: Date.FormatStyle.DateStyle.abbreviated, time: Date.FormatStyle.TimeStyle.omitted))")
    print("only date \(now.formatted(date: Date.FormatStyle.DateStyle.abbreviated, time: Date.FormatStyle.TimeStyle.omitted))")
    print("week day \(now.formatted(Date.FormatStyle.dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide)))")
    print("month day hour \(now.formatted(.dateTime.month().day().hour()))") // Order is not important it depends on Locale
    let mxLocale = Locale(identifier: "America/Mexico_City")
    print("mexico locale \(now.formatted(.dateTime.locale(mxLocale)))")
    
    let mxTimeZone = TimeZone(identifier: "America/Mexico_City")
    let dateFormatStyle = Date.FormatStyle(timeZone: mxTimeZone!)
    //    dateFormatStyle.timeZone = mxTimeZone!
    print("mexico timezone \(now.formatted(dateFormatStyle.year().day().month().hour().minute()))")
    
    //    var iSO8601DateFormatter = ISO8601DateFormatter()
    //    iSO8601DateFormatter.timeZone = mxTimeZone
    
    let iSO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = mxTimeZone
        
        return formatter
    }()
    
    print("YYYY-MM-DDTHH:MM:SS.SSS+-HH:SS \(iSO8601DateFormatter.string(from: now))")
    /// formatting
}

fileprivate let SECONDS_IN_A_MINUTE: Double = 60
fileprivate let MINUTES_IN_AN_HOUR: Double = 60
fileprivate let HOURS_IN_A_DAY: Double = 24
