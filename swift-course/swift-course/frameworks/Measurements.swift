import Foundation

func useMeasurements() {
    var lenght = Measurement(value: 30, unit: UnitLength.centimeters)
    var weight = Measurement(value: 5, unit: UnitMass.pounds)
    
    var lenght1 = Measurement(value: 300, unit: UnitLength.centimeters)
    var lenght2 = Measurement(value: 8, unit: UnitLength.meters)
    
    let total = lenght1 + lenght2
    let totalKilometers = total.converted(to: UnitLength.kilometers)
    
    print("total \(total.formatted(.measurement(width: .wide, usage: .road)))")
    print("totalKilometers \(totalKilometers.formatted(.measurement(width: .abbreviated, usage: .asProvided)))")
    print("total \(total.formatted(.measurement(width: .wide, usage: .asProvided, numberFormatStyle: .number.precision(.fractionLength(4)))))")
    
    let usLocale = Locale(identifier: "America/New_York")
    
    let usFormat = Measurement<UnitLength>.FormatStyle(width: .narrow, locale: usLocale, usage: .road)
    
    print("total us \(totalKilometers.formatted(usFormat))")
}
