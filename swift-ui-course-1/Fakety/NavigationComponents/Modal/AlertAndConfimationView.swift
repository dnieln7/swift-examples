//
//  AlertAndConfimationView.swift
//  Fakety
//
//  Created by Daniel Nolasco on 24/10/24.
//

import SwiftUI

struct AlertAndConfimationView: View {
    @State private var showAlert: Bool = false
    @State private var showConfirmationDialog: Bool = false

    var body: some View {
        VStack {
            Button("Show alert") {
                showAlert.toggle()
            }
            .padding()
            Button("Show confirmation dialog") {
                showConfirmationDialog.toggle()
            }
        }
        .alert(
            "Error",
            isPresented: $showAlert,
            actions: {
                Button("Cancel", role: .cancel) {
                    showAlert.toggle()
                }
                Button("Delete", role: .destructive) {
                    print("deleted")
                }
                Button("Accept", role: .none) {
                    print("accepted")
                }
            },
            message: {
                Text("There was an error")
            }
        )
        .confirmationDialog(
            "Accept",
            isPresented: $showConfirmationDialog,
            actions: {
                Button("Yes", role: .none) {
                    print("Yes")
                }
                Button("No", role: .destructive) {
                    print("No")
                }
                Button("Cancel", role: .cancel) {
                    print("Cancel")
                }
            },
            message: {
                Text("Are you sure?")
            }
        )
    }
}

#Preview {
    AlertAndConfimationView()
}
