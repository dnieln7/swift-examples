import CoreGraphics
import Foundation

func useGraphics() {
    let cgFloat: CGFloat = 1
    let cgSize = CGSize(width: 1, height: 200)
    let cgPoint = CGPoint(x: 500, y: 0)

    var cgRect = CGRect(origin: cgPoint, size: cgSize)
    
    cgRect.midX // horizontal center
    cgRect.origin = cgPoint
}
