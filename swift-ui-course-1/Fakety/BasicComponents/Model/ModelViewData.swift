//
//  ModelViewData.swift
//  Fakety
//
//  Created by Daniel Nolasco on 14/10/24.
//

import SwiftUI
import Observation

@Observable class ModelViewData {
    var titleInput: String = ""
    // changes won't trigger a view re-creation
    @ObservationIgnored var savePressedCounter: Int = 0
}
