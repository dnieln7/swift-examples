//
//  ModelData.swift
//  Fakety
//
//  Created by Daniel Nolasco on 14/10/24.
//

import SwiftUI
import Observation

@Observable class ModelData {
    // Because this class is @Observable no need to annotate properties with @State
    var title: String = "Default title"
    //    var titleInput: String = "" // recommended to put this in another place dedicated to the view's data
}
