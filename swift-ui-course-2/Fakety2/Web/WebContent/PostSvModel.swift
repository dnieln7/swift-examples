//
//  PostSvModel.swift
//  Fakety2
//
//  Created by Daniel Nolasco on 24/02/25.
//

import Foundation

struct PostSvModel: Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
