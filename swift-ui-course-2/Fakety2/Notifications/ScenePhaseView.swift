//
//  ScenePhaseView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 31/12/24.
//

import SwiftUI

struct ScenePhaseView: View {
    @Environment(\.scenePhase) var scenePhase: ScenePhase

    @State private var phaseHistory: [String] = []

    var body: some View {
        List(phaseHistory, id: \.self) { phase in
            Text(phase)
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                phaseHistory.append("visible and can interact")
            } else if newPhase == .inactive {
                phaseHistory.append("visible but cannot interact")
            } else {
                phaseHistory.append("not visible")
            }
        }
    }
}

#Preview {
    ScenePhaseView()
}
