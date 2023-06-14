//
//  UserModel.swift
//  level
//
//  Created by Владислав Мазуров on 14.06.23.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let surname: String
    let nickname: String
    let email: String
    let avatar: String
}
