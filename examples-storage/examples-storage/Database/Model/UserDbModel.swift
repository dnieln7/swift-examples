//
//  UserDbModel.swift
//  examples-storage
//
//  Created by Daniel Nolasco on 13/05/25.
//

import Foundation
import SwiftData

@Model
class UserDbModel: Identifiable {
    var id: UUID
    var name: String
    var userInfo: Data?
    var userInfo2: Data?

    var birthday: String? {
        let decoder = PropertyListDecoder()

        if let userInfo, let decodedUserIfo = try? decoder.decode(UserInfoDbProperty.self, from: userInfo) {
            return decodedUserIfo.birthday?.formatted(date: .abbreviated, time: .omitted)
        }

        return nil
    }

    var height2: String {
        let decoder = JSONDecoder()

        if let userInfo2, let decodedUserIfo2 = try? decoder.decode(UserInfoDbProperty.self, from: userInfo2) {
            if let height = decodedUserIfo2.height {
                return String(format: "%.1f", height)
            }
        }

        return "N/A"
    }

    init(id: UUID, name: String, userInfo: Data?, userInfo2: Data?) {
        self.id = id
        self.name = name
        self.userInfo = userInfo
        self.userInfo2 = userInfo2
    }
}

struct UserInfoDbProperty: Codable {
    let birthday: Date?
    let height: Double?
    let weight: Double?
}
