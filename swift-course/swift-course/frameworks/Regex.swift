import Foundation
import RegexBuilder

func useRegex() {
    let pattern = /(number): [0-9]+/
    let message = "number"
    let message2 = "number: 1123412"
    
    let match = message2.firstMatch(of: pattern)
    
    if let it = match {
        let (matchingString, parenthesisString) = it.output // this is a tuple (actual number of values will change as the number of parenthesis increase)
        
        print("message2 matchingString \(matchingString)")
        print("message2 parenthesisString \(parenthesisString)")
    }
    
    print("message matches? \(!message.matches(of: pattern).isEmpty)")
    
    print("split \("1,2,3,4".split(separator: /,/))")
    print("replacing \("500-11-111-11".replacing(/-/, with: " "))")
    
    /// Regex builder
    let regex = Regex {
        "number: "
        OneOrMore(.digit)
    }
    
    let regex2 = Regex {
        Capture {
            "number: "
        }
        OneOrMore(.digit)
    }
    
    let matchCustom = !message.matches(of: pattern).isEmpty
    let matchCustom2 = !message2.matches(of: pattern).isEmpty
    
    print("matchCustom \(matchCustom)")
    print("matchCustom2 \(matchCustom2)")
    
    if let it = message2.firstMatch(of: regex2) {
        let (matchingString, parenthesisString) = it.output // this is a tuple (actual number of values will change as the number of parenthesis increase)
        
        print("message2 matchingString \(matchingString)")
        print("message2 parenthesisString \(parenthesisString)")
    }
}
