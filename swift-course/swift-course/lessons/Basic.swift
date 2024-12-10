import Foundation

/// Basic swift stuff

func types() {
    print("Types")

    let integer: Int = 1
    let float: Float = 0.12345678
    let double: Double = 0.99
    let string: String = "hello"
    let specialString = #"Special "String" "#
    let multiline = """
    Line 1
    Line 2
    """
    let character: Character = "S"
    let bool: Bool = true

    var mutable = "hello"
    mutable = "world"

    print("integer: \(integer)")
    print("float: \(float)")
    print("double: \(double)")
    print("string: \(string)")
    print("specialString: \(specialString)")
    print("multiline: \(multiline)")
    print("character: \(character)")
    print("bool: \(bool)")
    print("mutable: \(mutable)")
}

func operators() {
    print("Operators")

    var int = 0

    print("accumulate", int += 1)
    print("sum: ", 1 + 1)
    print("substract: ", 1 - 1)
    print("multiply: ", 1 * 1)
    print("divide: ", 10.0 / 3.0)
    print("reminder: ", 100 % 66)
    print("equals: ", 100 == 66)
    print("NEGATION equals: ", 100 != 66)
    print("NEGATION NEGATION equals: ", !(100 != 66))
    print("greater than: ", 100 > 66)
    print("greater or equal than: ", 100 >= 66)
    print("less than: ", 100 < 66)
    print("less or equal than: ", 100 <= 66)
    print("AND: ", true && false)
    print("OR: ", true || false)

    var i = 0

    print(i += 1)
}

func optionals(_ optional: String?) {
    var value = 5

    if let it = optional { // it is independent of optional
        print("if let: \(it)")
    } else {
        print("if let: nil")
    }

    // optional binding also supports more conditions
    if let it = optional, value == 5 {
        print("if let and condition: \(it)")
    }

    // optional is independent of "optional" even though they have the same name
    if let optional {
        print("if let (short): \(optional)")
    }

    let value2: String = optional ?? "DEFAULT"

    print("default value: \(value2)")

    guard let value3: String = optional else {
        return // or throw
    }

    print("guard let: \(value3)")

    let value4: String = optional!

    print("unwrap: \(value4)")

    var implicitlyUnwrappedOptional: String!

    implicitlyUnwrappedOptional = "hello"

    print("implicitlyUnwrappedOptional: \(implicitlyUnwrappedOptional ?? "is nil")")
}

func ranges() {
    let closedRange: ClosedRange<Int> = 1 ... 5 // 1, 2, 3, 4, 5
    let openRange: Range<Int> = 1 ..< 5 // 1, 2, 3, 4

    print("openRange: \(closedRange)")
    print("openRange random: \(Int.random(in: closedRange))")
    print("closedRange: \(openRange)")
    print("closedRange random: \(Int.random(in: openRange))")
}

func strings() {
    var text = "Hello world"
    var start = text.startIndex
    var findIndex = text.firstIndex(of: " ")
    
    if let end = findIndex {
        print("First word is \(text[start ..< end])")
    }

    findIndex = text.firstIndex(of: " ")

    if let end = findIndex {
        text.replaceSubrange(start ..< end, with: "Goodbye")
    }

    let hasWorld = text.hasSuffix("world")

    print("hasWorld: \(hasWorld)")
}
