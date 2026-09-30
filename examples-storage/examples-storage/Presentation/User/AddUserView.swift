//
//  AddUserView.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 08/05/25.
//

import SwiftData
import SwiftUI

struct AddUserView: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var users: [UserDbModel]

    @State private var name: String = ""

    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            TextField("Insert name", text: $name)
                .textFieldStyle(.roundedBorder)
            Button("Save") {
                saveUser()
            }
            .buttonStyle(.borderedProminent)
            .padding([.top])
            List(users) { user in
                VStack {
                    Text("\(user.name) - \(user.birthday ?? "No birthday") - \(user.height2)")
                }
            }
            .padding([.top])
        }
        .padding()
        .navigationTitle("Add User")
    }

    private func saveUser() {
        let name = name.trimmingCharacters(in: .whitespaces)

        guard !name.isEmpty else { return }
        
        let userInfo = UserInfoDbProperty(birthday: Date(), height: nil, weight: nil)
        let userinfoEncoded = try? PropertyListEncoder().encode(userInfo)
        
        let userInfo2 = UserInfoDbProperty(birthday: nil, height: 169, weight: nil)
        let userinfoEncoded2 = try? JSONEncoder().encode(userInfo2)

        let newUser = UserDbModel(id: UUID(), name: name, userInfo: userinfoEncoded, userInfo2: userinfoEncoded2)

        modelContext.insert(newUser)
        try? modelContext.save()
        
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}

#Preview(traits: .modifier(PreviewFakeData())) {
    @Previewable @State var navigationPath: NavigationPath = NavigationPath()

    AddUserView(
        navigationPath: $navigationPath
    )
}
