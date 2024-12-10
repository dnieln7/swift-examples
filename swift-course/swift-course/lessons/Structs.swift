import Foundation

// Value types

func useStructs() {
    var notification = Notification(title: "1", content: "2")

    // To modify content a new instance of Notification will be created, and assigned to
    // notification that's why notification needs to be a var to mutate it's members
//    notification.content = "3"

    // KeyPath - reference to a property with read/read-write access
    let keyPathContent = \Notification.content
    print("keyPathContent: ", notification[keyPath: keyPathContent])
    notification[keyPath: keyPathContent] = "3"
    print("keyPathContent after write: ", notification[keyPath: keyPathContent])

    let instance = GenericStructure<Int>(value: 5)
    let instance2 = GenericStructure(value: 5)

    // Primitive values are structs
    var int: Int = Int(1)
    var string: String = String(int)

    print("int: \(int)")
    print("string: \(string)")

    // Casting
    var units = "45"

    if let unitsNumeric = Int(units) {
        print("unitsNumeric is not nil because the casting of units to int was successful: \(unitsNumeric)")
    }
}

struct Notification {
    // stored properties
    var title: String
    var content: String

    // Getter and Setter (computed properties)
    var uppercasedTitle: String {
        get {
            return title.uppercased()
        }
        set {
            title = newValue.uppercased()
        }
//        set(it) {
//            title = it.uppercased()
//        }
    }

    init() {
        title = "default title"
        content = "default content"
    }

    init(title: String, content: String) {
        self.title = title
        self.content = content
    }

    func titleAndContent() -> String {
        return title + " " + content
    }

    mutating func rewrite(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

extension Notification {
    func isValid() -> Bool {
        print(title)
        return true
    }
}

struct Price {
    var increment: Double = 0
    var oldPrice: Double = 0

    // Property observers
    var price: Double = 0 {
        // modifiying price here will not trigger the observers

        // new value - executed before the price changed
        willSet(it) {
            increment = it - price
        }

        // previous value - executed after the price changed
        didSet {
            oldPrice = oldValue
        }
    }

    // Type properties and functions
    static let currencies = 2

    static func negativePrice() -> Price {
        return Price(price: -1)
    }
}

struct GenericStructure<T> {
    var value: T
}
