import Foundation

func useProtocols() {
    let authRepository: any AuthRepository = DefaultAuthRepository()

    let printer1 = SamsungWireless(queue: [])
    let printer2 = SamsungWireless(queue: ["Hey"])

    print("printer1 == printer2: \(printer1 == printer2)")
    print("compareValues: \(compareValues(value1: printer1, value2: printer2))")
}

protocol AuthRepository {
    associatedtype T
    associatedtype V

    func login(email: V, password: V) -> T
}

class DefaultAuthRepository: AuthRepository {
    typealias V = String

    func login(email: V, password: V) -> Bool {
        print("Login in...")
        return true
    }
}

// use AnyObject protocol to make this a class-only protocol
protocol Printer: Equatable {
    var queue: FilesQueue { get set }
    var queueReversed: FilesQueue { get }

    func print(file: String) -> Bool
}

struct SamsungWireless: Printer, Hashable {
    var queue: FilesQueue
    var queueReversed: FilesQueue {
        queue.reversed()
    }

    func print(file: String) -> Bool {
        Swift.print("printing...")
        return true
    }

    // Compiler can create this method to hash the properties of each instance
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(queue)
//    }

    // Compiler can create this method to compare the properties of each instance
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.queue == rhs.queue
//    }
}

func compareValues<T: Equatable>(value1: T, value2: T) -> Bool {
    return value1 == value2
}

protocol TextInputError {
}

enum PasswordError: TextInputError {
    case TooShort
    case NoSpecialSymbols
    case NoNumbers
}

internal typealias FilesQueue = Array<String>
