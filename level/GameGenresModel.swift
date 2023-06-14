//
//  GameGenresModel.swift
//  level
//
//  Created by Владислав Мазуров on 13.06.23.
//

import Foundation

struct GameGenres: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GenresResults]?
}

struct GenresResults: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let games_count: Int?
    let image_background: String?
    let games: [Games]?
}

struct Games: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let added: Int?
}
