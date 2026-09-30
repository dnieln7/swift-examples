//
//  KeyValueObservation.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 31/12/24.
//

import Observation
import SwiftUI

@Observable class KeyValueObservationViewModel {
    var currentValue: String = ""
    @ObservationIgnored var myObservedObject: MyObservedObject = MyObservedObject()
    @ObservationIgnored private var countObserver: NSKeyValueObservation?

    init() {
        countObserver = myObservedObject.observe(\.count, options: [.new]) { _, value in
            if let newValue = value.newValue {
                self.currentValue = "Count: \(newValue)"
            }
        }
    }

    func onDispose() {
        countObserver = nil
    }
}

class MyObservedObject: NSObject {
    // dynamic - report changes in background
    @objc dynamic var count: Int = 0
}
