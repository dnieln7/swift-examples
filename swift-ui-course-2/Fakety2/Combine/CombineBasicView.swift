//
//  CombineBasicView.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 21/01/25.
//

import SwiftUI

struct CombineBasicView: View {
    @State private var viewModel = CombineBasicViewModel()

    var body: some View {
        VStack {
            Text("Hello")
            Button("Start timer") {
                viewModel.startTimer()
            }
            .padding()
            Button("Stop timer") {
                viewModel.stopTimer()
            }
            .padding()
        }
//        .onReceive(viewModel.just) {
//            debugPrint("just: \($0)")
//        }
//        .onReceive(viewModel.stream) {
//            debugPrint("stream >>> \($0)")
//        }
        .onReceive(viewModel.timerPublisher) {
            debugPrint("timer >>> \($0)")
        }
    }
}

#Preview {
    CombineBasicView()
}
