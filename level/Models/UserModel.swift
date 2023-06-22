//
//  UserModel.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import Foundation

struct UserModel: Codable {
    var uid: String
    let nickname: String
    let email: String
    let avatar: String
    let bio: String
}
