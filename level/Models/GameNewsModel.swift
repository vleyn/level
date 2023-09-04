//
//  GameNewsModel.swift
//  level
//
//  Created by Владислав Мазуров on 18.07.23.
//

import Foundation

struct GameNews: Decodable {
    let id: String?
    let date: Int?
    let header: String?
    let shortDescription: String?
    let longDescription: String?
    let numberOfReads: Int?
    let image: String?
    let author: String?
}
