import Foundation

func useTimers() {
    print("non repeating timer")

    /// timers schedule in the main thread
    
    Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
        print("Time is up")
    })

    var counter = 1

    Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
        print("Time is up")

        if counter > 10 {
            timer.invalidate()
        }

        counter += 1
    })
}
