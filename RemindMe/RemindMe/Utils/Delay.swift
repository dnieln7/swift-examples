//
//  Delay.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 17/12/24.
//

import Foundation

class Delay {
    
    private var seconds: Double
    private var dispatchWorkItem: DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func doWork(_ work: @escaping () -> Void) {
        dispatchWorkItem = DispatchWorkItem{
            work()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: dispatchWorkItem!)
    }
    
    func cancel() {
        dispatchWorkItem?.cancel()
    }
}
