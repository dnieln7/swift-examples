import Foundation

func sequences() {
    let sequenceText = repeatElement("Hello", count: 5)
    let sequenceNumbers = stride(from: 0, to: 8, by: 2)
    let finalSequence = zip(sequenceText, sequenceNumbers)
    
    for (text, number) in finalSequence {
        print("\(text) - \(number)")
    }
}

func tuples() {
    var nameAgeMale = ("Daniel", 24, true)
    let (_, age, _) = nameAgeMale
    var nameAgeMaleNamed = (name: "Daniel", age: 24, male: true)

    print("name \(nameAgeMale.0)")
    print("age \(age)")
    print("male \(nameAgeMaleNamed.male)")
}

func arrays() {
    var array: [Int] = [11, 2, 2, 233]
    array[0] = 4
    array.append(3)
    array.insert(0, at: 1)
    array += [12, 13, 41]

    for (index, number) in array.enumerated() {
        print("index: \(index) - number: \(number)")
    }

    print("array: \(array)")

    var arraySlice: ArraySlice<Int> = array[0 ..< 4] // Can be casted to array with Array(arraySlice)
    print("arraySlice: \(arraySlice)")

    var matrix: [[Int]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    print("matrix: \(matrix)")

    // use reference to init instead of closure

    let numbers = [1, 2, 3, 4]
    let textNumbers = numbers.map(String.init)
    print("textNumbers: \(textNumbers)")
}


func sets() {
    var set: Set<Int> = Set() // Can also use []
    set.insert(2)
    _ = set.popFirst() ?? -1

    var store: Set<String> = ["Banana", "Apple", "Orange", "Pear"]
    var basket: Set<String> = ["Apple", "Orange"]

    if basket.isSubset(of: store) {
        print("The fruits in the basket are from the store")
    }

    print("set \(set)")
}

func dictionaries() {
    var dictionary: [Int: String] = [
        1: "Daniel",
    ]

    dictionary[3] = "Hello"
    dictionary.updateValue("Antonio", forKey: 2)
    dictionary[2] = nil

    print("dictionary: \(dictionary)")
    print("value at 1: \(dictionary[1]!)")

    let list = [15, 25, 38, 55, 42]
    let group5 = Dictionary(
        grouping: list,
        by: { element in element % 5 == 0 ? "yes" : "no" }
    )

    print("mutiples of 5: \(group5)")

    let dic = ["one": "Banana", "two": "Apple", "three": "Pear"]
    var sorted = dic.sorted(by: { $0.value < $1.value })
    
    print("sorted: \(sorted)")
}
