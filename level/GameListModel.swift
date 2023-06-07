//
//  GameListModel.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation

struct GameList: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Results]?
}

struct Results: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Float?
    let ratingTop: Int?
    let ratings: [Ratings]?
    let ratingsCount: Int?
    let reviewsTextCount: Int?
    let added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let playtime: Int?
    let suggestionsCount: Int?
    let updated: String?
    let userGame: String?
    let reviewsCount: Int?
    let saturatedColor: String?
    let dominantColor: String?
    let platforms: [Platforms]?
    let parentPlatforms: [ParentPlatforms]?
    let genres: [Genres]?
    let stores: [Stores]?
    let clip: String?
    let tags: [Tags]?
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshots]?
    
    enum CodingKeys: String, CodingKey {
        case backgroundImage = "background_image"
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case addedByStatus = "added_by_status"
        case suggestionsCount = "suggestions_count"
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case id, slug, name, released, tba, rating, ratings, added, metacritic, playtime, updated, platforms, genres, stores, clip, tags, esrbRating, shortScreenshots
    }
}

struct Ratings: Decodable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Float?
}

struct AddedByStatus: Decodable {
    let yet: Int?
    let owned: Int?
    let beaten: Int?
    let toplay: Int?
    let dropped: Int?
    let playing: Int?
}

struct Platforms: Decodable {
    let platform: Platform?
    let releasedAt: String?
    let requirementsEn: Requirements?
    let requirementsRu: Requirements?
    
    enum CodingKeys: String, CodingKey {
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
        case platform
    }
}

struct Requirements: Decodable {
    let mininum: String?
    let recommended: String?
}

struct Platform: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let image: String?
    let yearEnd: Int?
    let yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case id, name, slug, image
    }
}

struct ParentPlatforms: Decodable {
    let platform: ParentPlatform?
}

struct ParentPlatform: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct Genres: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case id, name, slug
    }
}

struct Stores: Decodable {
    let id: Int?
    let store: Store?
}

struct Store: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let domain: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case id, name, slug, domain
    }
}

struct Tags: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let language: String?
    let gamesCount: Int?
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case id, name, slug, language
    }
}

struct EsrbRating: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct ShortScreenshots: Decodable {
    let id: Int?
    let image: String?
}
