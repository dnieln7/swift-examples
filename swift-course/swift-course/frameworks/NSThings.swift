import Foundation

func useFrameworks() {
    nsStrings()
}

private func nsStrings() {
    var text: NSString = NSString(string: "hello")
    var newText: String = "world"

    print(text as String)
    print(newText as NSString)

    var number = 12.3456
    var number2 = 5400000

    print(String.localizedStringWithFormat("Decimals: %.2f", number))
    print(String.localizedStringWithFormat("Digits: %5d", number2))
}

func nsRanges() {
    let swiftRange: Range<Int> = 4 ..< 10 // stores first and final values
    let range = NSRange(swiftRange) // stores first value and length

    print("swiftRange first: \(swiftRange.first!)")
    print("swiftRange length: \(swiftRange.count)")
    print("range first: \(range.location)")
    print("range length: \(range.length)")

    let text = "01234567890"

    if let number4: String.Index = text.firstIndex(of: "9") {
        let nsRange = NSRange(number4..., in: text)

        print("first: \(nsRange.location)")
        print("length: \(nsRange.length)")
    }
}

func nsNumbers() {
    let nsNumber = NSNumber(value: 34)
    let double: Double = nsNumber.doubleValue * 2.7911

    print(double)

    // Format to a number with 2 decimals
    let text = double.formatted(
        .number
            .precision(NumberFormatStyleConfiguration.Precision.fractionLength(2))
            .rounded(rule: FloatingPointRoundingRule.up)
    )

    print(text)

    let text2 = double.formatted(
        .currency(code: "USD")
    )

    print(text2)
}
