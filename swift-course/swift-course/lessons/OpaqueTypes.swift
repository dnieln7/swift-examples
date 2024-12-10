import Foundation

/// Data types that hide the value's data type from the programmer
///
/// If we know that a value conforms to a specific protocol the type can be opaque and the compiler will assing the correct data type
/// Use some followed by the protocol the value
func useOpaqueTypes() {
}

private func luckyBox(saveables: [Int: Saveable]) throws -> Saveable {
    let randomKey = saveables.keys.randomElement()

    guard let key: Dictionary<Int, Saveable>.Keys.Element = randomKey else {
        throw StorageErrors.Empty
    }

    let value = saveables[key]

    guard let saveable: Saveable = value else {
        throw StorageErrors.WrongIdentifier
    }

    return saveable
}

protocol OneSpaceStorage {
    associatedtype Item: Saveable

    var content: Item { get }
}

struct OrangeWrapper: OneSpaceStorage {
    private var _content: Orange

    var content: some Saveable {
        _content
    }

    init(content: Orange) {
        _content = content
    }
}

protocol Storage {
    associatedtype Item: Saveable

    var contents: [Int: Item] { get }
}

struct Box<T: Saveable>: Storage {
    var contents: [Int: T] = [:]
}

struct Wallet: Storage {
    var contents: [Int: CreditCard]
}

protocol Saveable {
    var identifier: Int { get set }
}

struct Orange: Saveable {
    var identifier: Int

    init(identifier: Int) {
        self.identifier = identifier
    }
}

struct CreditCard: Saveable {
    var identifier: Int

    init(identifier: Int) {
        self.identifier = identifier
    }
}

enum StorageErrors: Error {
    case Empty
    case WrongIdentifier
}
