//
//  CustomOperators.swift
//  RemindMe
//
//  Created by Daniel Nolasco on 16/12/24.
//

import Foundation
import SwiftUI

public func ?? <T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    return Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { newValue in
            lhs.wrappedValue = newValue
        }
    )
}
