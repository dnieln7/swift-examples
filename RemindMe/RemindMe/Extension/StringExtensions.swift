//
//  StringExtensions.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 11/12/24.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
