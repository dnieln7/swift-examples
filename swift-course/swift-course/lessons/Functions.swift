import Foundation

func doubleValue(number: Int) -> Int {
    guard number < 1 else {
        return number
    }

    return number * 2
}

private func printHello(_ hello: String = "Hello", times: Int) {
    for i in 1 ... times {
        print("\(hello) printed for the \(i) time")
    }
}

// generic
func saySomething<T>(value: T) {
    print("something is: \(value)")
}

func saySomethingNumeric<T>(value: T) {
    print("something is: \(value)")
}

// pass reference
private func modify(value: inout Int) {
    value = value * 2
}

func modifyExternalVariable() {
    var number = 25
    print("original number: \(number)")
    modify(value: &number)
    print("modified number: \(number)")
}

// One line implicit return
func doubleValue2(number: Int) -> Int {
    number * 2
}

// overloads
func overloaded(int: Int) {
    print("overloaded with int: \(int)")
}

func overloaded(float: Float) {
    print("overloaded with float: \(float)")
}

// Closures
let multiplier = { (number: Int, times: Int) -> Int in
    let total = number * times

    return total
}

// trailing closures
private func doSomethingXTimes(times: Int, block: () -> Void) {
    for _ in 0 ... times {
        block()
    }
}
private func doSomethingNumericXTimes(times: Int, block: (Int) -> Void) {
    for i in 0 ... times {
        block(i)
    }
}
func useTrailingClosure() {
    doSomethingXTimes(times: 2) { () in
        print("Any")
    }
    
    doSomethingNumericXTimes(times: 2) { // Access not declared parameters with $0, $1...
        print("Any \($0)")
    }
}

// Return closure
private func small(resources: String, req: String) {
}
func big(resources: String) -> (String) -> Void {
    return { (req: String) in
        small(resources: resources, req: req)
    }
}

// escaping closure
private var myClosure: () -> Void = {}
func closureBuilder(closure: @escaping () -> Void) {
    // @escaping == outlive the function thta captures the closure
    myClosure = closure
}
