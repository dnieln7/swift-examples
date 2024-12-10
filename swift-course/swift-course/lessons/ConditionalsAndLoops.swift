import Foundation

func conditionalsAndLoops(darkMode: Int) {
    if darkMode == 1 {
        print("darker")
    } else if darkMode == 0 {
        print("lighter")
    } else {
        print("error")
    }

    var age = 19
    let message = age < 18 ? "underage" : "allowed" // This can also use if else

    switches(darkMode: darkMode, ages: (10, 30))
    loops()
}

func switches(darkMode: Int, ages: (Int, Int)) {
    switch darkMode {
    case 1:
        print("cool")
    case 11, 12, 13, 14:
        print("even cooler")
    case 2 ... 10:
        print("cooler")
    default:
        print("nah")
    }

    switch ages {
    case (10, 10):
        print("second value is 10")
    case (10, 30):
        print("second value is 30")
    default:
        print("default")
    }

    switch ages {
    case let (first, 10):
        print("second value is 10, first is \(first)")
    case (_, 30):
        print("second value is 30, first is not important")
    default:
        print("default")
    }

    switch ages {
    case let (first, second) where first < second:
        print("\(first) is less than \(second)")
    default:
        break
    }

    var message = switch ages.0 {
    case 10:
        "is 10"
    default:
        "don't know"
    }
}

func loops() {
    let numbers = [1, 2, 3, 4]

    print("numbers")

    for number in numbers where number >= 3 {
        print(number)
    }

    print("for i in 1...10")

    for i in 1 ... 10 {
        print(i)

        if i == 8 {
            break
        }
    }

    print("for i in 0..<10")

    for i in 0 ..< 10 {
        print(i)

        if i == 0 {
            continue
        }

//        guard i == 1 else { continue } // Not common

        print(Int.random(in: 1 ... 100))
    }

    var counter = 0

    while counter < 5 {
        print("counter: \(counter)")
        counter += 1
    }

    repeat {
        print("counter: \(counter)")
        counter += 1
    } while counter < 10
}
