import Foundation

func useModifiers() {
}

final class AppleWatch {
    var name: String?

    // public getter | private setter
    public private(set) var heartRate: Int = 128

    public private(set) lazy var hasOxygenSensor: Bool = {
        print("Loading location...")
        return true
    }()

    private init(name: String?) {
        self.name = name
    }

    // Singleton
    static let shared = AppleWatch(name: DEFAULT_NAME)
}

fileprivate let DEFAULT_NAME = "TEST"
internal let GREETING = "Hello world" // default access modifier
public let PUBLIC_GREETING = "Hello other worlds" // Other modules can read this
