//
//  CardModel.swift
//  level
//
//  Created by Владислав Мазуров on 11.07.23.
//

import Foundation

struct CardModel: Codable {
    let id: String
    let cardNumber: String
    let expirationDate: String
    let cvvCode: String
    let cardholderName: String
    var balance: Int
}
