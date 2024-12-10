import Foundation

func useEnums() {
    let dayOfWeeek: DaysOfWeek = .Friday

    print("raw value \(DayType.Working.rawValue)")
    print("raw value to instance \(DayType(rawValue: "Working day") ?? DayType.Working)")

    let uiState: UiState = .Error("internal server error")

//    switch uiState {
//    case .Loading:
//        print("UI is loading")
//    case .Error(let error):
//        print("UI had an error: \(error)")
//    case .Success(let data):
//        print("UI says: \(data)")
//    }

    switch uiState {
    case .Loading:
        print("UI is loading")
    case let .Error(error):
        print("UI had an error: \(error)")
    case let .Success(data):
        print("UI says: \(data)")
    }
    
//    if case UiState.Error(let error) = uiState {
//        print("UI had an error: \(error)")
//    }
    
    if case UiState.Error(let error) = uiState {
        print("UI had an error: \(error)")
    }
}

enum UiState {
    case Error(String)
    case Loading
    case Success(Array<String>)
}

enum DayType: String {
    case Working = "Working day"
    case Free = "Free day"

    func whatToDo() -> String {
        switch self {
        case .Free:
            "Nothing"
        case .Working:
            "Work"
        }
    }
    
    static func random() -> DayType {
        return .Free
    }
}

enum DaysOfWeek: Int {
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
    case Sunday = 7
}

func shouldIWork(day: DaysOfWeek) {
    print("day number: \(day.rawValue)")

    if day == .Saturday || day == .Sunday {
        print("NO WORK")
    } else {
        print("YES WORK")
    }

    switch day {
    case .Monday:
        print("One")
    case .Tuesday:
        print("Two")
    case .Wednesday:
        print("Three")
    case .Thursday:
        print("Four")
    case .Friday:
        print("Five")
    case .Saturday:
        print("Six")
    case .Sunday:
        print("Seven")
    }
}
