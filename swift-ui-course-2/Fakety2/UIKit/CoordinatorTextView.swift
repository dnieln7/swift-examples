//
//  CoordinatorTextView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 26/12/24.
//

import SwiftUI

class CoordinatorTextView: NSObject, UITextViewDelegate {
    @Binding var input: String
    
    init(input: Binding<String>) {
        self._input = input
    }
    
    func textViewDidChange(_ textView: UITextView) {
        input = textView.text
    }
}
