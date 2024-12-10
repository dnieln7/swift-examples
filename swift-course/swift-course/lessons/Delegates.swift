import Foundation

func useDelegates() {
    let delegate: SalaryProtocol = BasicSalary()
    var employee1 = Employees(name: "Tom", money: 45000, delegate: delegate)

    employee1.generateReport()
}

// struct Salary {
//    func showMoney(name: String, money: Double) {
//        print("The salary of \(name) is \(money)")
//    }
// }
//
// struct Employees {
//    var name: String
//    var money: Double
//
//    var delegate: Salary
//
//    func generateReport() {
//        delegate.showMoney(name: name, money: money)
//    }
// }

protocol SalaryProtocol {
    func showMoney(name: String, money: Double)
}

struct Salary: SalaryProtocol {
    func showMoney(name: String, money: Double) {
        print("The salary of \(name) is \(money)")
    }
}

struct BasicSalary: SalaryProtocol {
    func showMoney(name: String, money: Double) {
        if money > 40000 {
            print("Salary of over the minimun")
        } else {
            print("The salary of \(name) is \(money)")
        }
    }
}

struct Employees {
    var name: String
    var money: Double

    var delegate: SalaryProtocol

    func generateReport() {
        delegate.showMoney(name: name, money: money)
    }
}
