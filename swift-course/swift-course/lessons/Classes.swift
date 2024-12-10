import Foundation

// Reference types

func useClasses() {
    let phone = Phone(id: 121, name: "IPhone X")

    phone.name = "IPhone XR"

    // === !== objects are identical
    // == != obejcts information is the same (Equatable protocol)

    // metatypes
    let reference = Phone.self
    let phone2 = reference.init(id: 1, name: "IPhone 13") // Posible because of the required initializer

    // Memory management
    var employee: Employee? = Employee()
    var department: Department? = Department()

    /// Strong reference cycle
    employee?.name = "Steve"
    employee?.location = department

    department?.area = "Mail"
    department?.person = employee

    /// References categories:
    /// Strong: Normal references
    /// Weak / Unowed: When Automatic Reference Counting encounters one of these to be the last reference to an object, it erases the object (because it's not counted)
    /// Weak: Variables with optional values
    /// Unowed: Variables with NOT optional values
    ///
    /// Closures can create strong reference cycles if we try to access properties or methods defined outside the closure.
    /// If we need to reference properties or methods with self inside a closure,
    /// we can declare the reference to self as weak with the syntax weak self] or [unowned self).
    /// The expression must be declared before the closure's parameters.

    // Type casting
    let list: [Device] = [
        Phone(id: 1, name: "IPhone 13"),
        Watch(id: 2, name: "Series 8"),
    ]

    let firstIsWatch = list[0] is Watch

    if firstIsWatch {
        print("watch found!")
    }

    let optionalWatch = list[0] as? Watch
//    let forcedWatch = list[0] as! Watch

    print("optionalWatch: \(String(describing: optionalWatch))")

    let any1: Any = list[0]
    let any2: AnyObject = list[0]

    print("Any: \(any1)")
    print("AnyObject: \(any2)")

    var myWatch: Watch? = Watch()

    print("myWatch: \(String(describing: myWatch))")

    myWatch = nil

    print("end")
}

class Employee {
    var name: String?
//    var location: Department?
    weak var location: Department?
}

class Department {
    var area: String?
//    var person: Employee?
    weak var person: Employee?
}

class Device {
    let id: Int

    init(id: Int) {
        self.id = id
    }

    // use final to avoid overriding
    func fancyId() -> String {
        return "ID: \(id)"
    }

    deinit {
        print("This super instance is going to be deleted")
    }
}

class Phone: Device {
    var name: String

    required init(id: Int, name: String) {
        self.name = name
        super.init(id: id)
    }

    func changeName(newName: String) {
        name = newName
    }

//    static let loggerID = "PHONE_CLASS"

    // This can be modified by subclasses, to avoid use static instead
    class func defaultInstance() -> Phone {
        return Phone(id: -1, name: "Test device")
    }
}

class Watch: Device {
    var name: String?

    // Secondary initializer to call other initializers in a more convenient way, like providing less arguments
    convenience init() {
        self.init(id: -1, name: nil)
    }

    init(id: Int, name: String?) {
        self.name = name
        super.init(id: id)
    }

    override func fancyId() -> String {
        return "WATCH ID: \(id)"
    }

    deinit {
        print("This instance is going to be deleted")
    }
}
