import Foundation

func useExtensions() {
    print("Decimal to int: \(decimal: 25.1)")
}

extension Watch {
    func getTime() -> Int {
        print("Watch id: \(id)")
        return 97812
    }
}

extension Printer {

// With this, implementation of the protocol can skip implementing the print function, they will use the default implementation instead
//    func print(file: String) -> Bool {
//        Swift.print("default print implementation")
//        return false
//    }
    
    func printQueue() {
        Swift.print("The queue is: \(queue)")
    }
}

extension GenericStructure<Int> {
    init(double: Double) {
        value = Int(double.rounded())
    }

    // getter
    var valueInHalf: Double {
        return Double(value) / 2.0
    }

    func printDescriptionTimes2() {
        print("printDescriptionTimes2: \(value * 2)")
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(decimal: Double) {
        appendLiteral(String(decimal.rounded(.up)))
    }
}
