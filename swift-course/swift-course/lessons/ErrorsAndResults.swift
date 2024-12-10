import Foundation

func useErrorsAndResults() {
    defer {
        print("This always happens at the end!")
    }

    do {
        let number = try riskyDivision(value1: 1, value2: 0)
        print("number: \(number)")
    } catch RiskyErrors.AZeroWasFound {
        print("Cannot divide by zero dummy!")
    } catch let RiskyErrors.InvalidValue1(value1) where value1 == 0 {
        print("Zero cannot be divided dummy!")
    } catch {
        print("This is unspected!")
    }

    let safeNumber: Double? = try? riskyDivision(value1: 2, value2: 0)
    let dangerNumber: Double = try! riskyDivision(value1: 2, value2: 2)

    let result = riskyDivisionResult(value1: 1, value2: 0)

    switch result {
    case let .success(number):
        print("number: \(number)")
    case let .failure(error):
        print("error: \(error)")
    }
}

enum RiskyErrors: Error {
    case AZeroWasFound
    case InvalidValue1(value1: Double)
}

private func riskyDivision(value1: Double, value2: Double) throws -> Double {
    if value1 == 0 {
        throw RiskyErrors.InvalidValue1(value1: value1)
    }

    if value2 == 0 {
        throw RiskyErrors.AZeroWasFound
    }

    return value1 / value2
}

private func riskyDivisionResult(value1: Double, value2: Double) -> Result<Double, RiskyErrors> {
    if value2 == 0 {
        return .failure(.AZeroWasFound)
    }

    return .success(value1 / value2)
}

/// The rethrows keyword is used when you write a function (let’s call it A) that accepts a throwing function as a parameter (let’s call it B).
///  If function B throws errors, then the function A becomes a throwing function too, but if function B doesn’t throw errors then neither does function A.
func danger(closure: () throws -> Void) rethrows {
    try closure()
}
