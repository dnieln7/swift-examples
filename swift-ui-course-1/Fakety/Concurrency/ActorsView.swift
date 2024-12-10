//
//  ActorsView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 30/10/24.
//

import SwiftUI

struct ActorsView: View {
    var counter: CounterActor = CounterActor()

    var body: some View {
        VStack {
            Button("Increment") {
                print("Without waiting: \(counter.stringifyOtherValue())")

                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    Task(priority: .background) {
                        async let operation = counter.increment()

                        print("Background task value: \(await operation)")
                    }
                }

                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                    Task(priority: .high) {
                        let newValue = await counter.increment()

                        print("High task value: \(newValue)")
                    }
                }
            }
        }
    }
}

// Protect contents from access by multiple threads at the same time
// Can debugged using thread sanitizer from run scheme
actor CounterActor {
    // properties are async by default
    var value: Int = 0
    let otherValue: Int = 999

    // functions are async by default
    func increment() -> Int {
        value += 1

        return value
    }

    func incrementByProduct(product: Product) -> Int {
        value += product.price

        return value
    }

    // this is not isolated from other threads
    // using nonisolated allows for other threads to not wait
    nonisolated func stringifyOtherValue() -> String {
        "otherValue: \(otherValue)"
    }
}

// Sendable tells the compiler that the data type is thread safe (the value will not be changed later by other thread), the compiler will show errors if the object conforming to the protocol contains unsafe values

// Structures are thread safe because they are passed by value (copied), classes are safe if they dont have unsafe values

// Structures can also conform to the Sendable protocol to ensure that they dont contain unsafe values

// Final, this way we ensure no one can create potentially unsafe subclasses from it
final class Product: Sendable {
    let name: String
    let price: Int

    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

// the @unchecked tells the compiler to not check if MaybeUnsafeProduct conforms to the Sendable protocol
final class MaybeUnsafeProduct: @unchecked Sendable {
    let name: NSString // This is not Sendable, but we are sure that this value won't change later
    let price: Int
    
    init(name: NSString, price: Int) {
        self.name = name
        self.price = price
    }
}

#Preview {
    ActorsView()
}
