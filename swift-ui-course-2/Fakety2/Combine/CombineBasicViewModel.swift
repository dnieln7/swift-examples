//
//  CombineBasicViewModel.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 21/01/25.
//

import Combine
import Observation
import SwiftUI

@Observable class CombineBasicViewModel {
    // Emits a value once and finishes
    let just: Just<String>

    // Exposes functions to emit values, using Never because it will never fail
    let stream = PassthroughSubject<Int, Never>()

    var timerPublisher: Timer.TimerPublisher
    var timerCancellable: Cancellable?

    init() {
        just = Just("Hello World")
        timerPublisher = Timer.publish(every: 1, on: RunLoop.main, in: .common)

        Task(priority: .background) {
            var count = 0

            while count < 5 {
                stream.send(count)
                try? await Task.sleep(for: .milliseconds(500))
                count += 1
            }
        }
    }
    
    func startTimer() {
        guard timerCancellable == nil else { return }
        
        timerCancellable = timerPublisher.connect()
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
    }
}
