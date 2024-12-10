import Foundation

func usePropertyWrapper() {
    let progressIndicator = ProgressIndicator(progress: 200)
    
    print("progressIndicator: \(progressIndicator.progress)")
}

func freestandingMacros() {
    print("file name \(#file)")
    print("file path \(#filePath)")
    print("line \(#line)")
    print("function \(#function)")
}

@propertyWrapper // Attached macros
struct ProgresValue {
    private var value: Int = 0
    private let min: Int = 0
    private let max: Int = 100

    var wrappedValue: Int {
        get {
            return value
        }
        set {
            if newValue < min {
                value = min
            } else if newValue > max {
                value = max
            } else {
                value = newValue
            }
        }
    }

    init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
}

struct ProgressIndicator {
    @ProgresValue var progress: Int
}
