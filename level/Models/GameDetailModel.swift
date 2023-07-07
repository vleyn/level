//
//  GameDetailModel.swift
//  level
//
//  Created by Владислав Мазуров on 7.06.23.
//

import Foundation

struct GameDetail: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let nameOriginal: String?
    let description: String?
    let metacritic: Int?
    let metacripticPlatforms: [MetacriticPlatforms]?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let website: String?
    let rating: Float?
    let ratingTop: Int?
    let ratings: [Ratings]?
    let added: Int?
    let addedByStatus: AddedByStatus?
    let playtime: Int?
    let screenshotsCount: Int?
    let moviesCount: Int?
    let creatorsCount: Int?
    let achievementsCount: Int?
    let parentAchievementsCount: Int?
    let redditUrl: String?
    let redditName: String?
    let redditDescription: String?
    let redditLogo: String?
    let redditCount: Int?
    let twitchCount: Int?
    let youtubeCount: Int?
    let reviewsTextCount: Int?
    let ratingsCount: Int?
    let suggestionsCount: Int?
    let metacriticUrl: String?
    let parentsCount: Int?
    let additionsCount: Int?
    let gameSeriesCount: Int?
    let reviewsCount: Int?
    let saturatedColor: String?
    let dominantColor: String?
    let parentPlatforms: [ParentPlatforms]?
    let platforms: [Platforms]?
    let stores: [Stores]?
    let developers: [Developers]?
    let genres: [Genres]?
    let tags: [Tags]?
    let publishers: [Publishers]?
    let esrbRating: EsrbRating?
    let descriptionRaw: String?
    
    enum CodingKeys: String, CodingKey {
        case nameOriginal = "name_original"
        case metacripticPlatforms = "metacriptic_platforms"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case ratingTop = "rating_top"
        case addedByStatus = "added_by_status"
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditUrl = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case metacriticUrl = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case esrbRating = "esrb_rating"
        case descriptionRaw = "description_raw"
        case id, slug, name, description, metacritic, released, tba, updated, website, rating, ratings, added, playtime, platforms, stores, developers, genres, tags, publishers
    }
}

struct MetacriticPlatforms: Decodable {
    let metascore: Int?
    let url: String?
    let platform: MetacriticPlatform?
}

struct MetacriticPlatform: Decodable {
    let platform: Int?
    let name: String?
    let slug: String?
}

struct Developers: Decodable {
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

struct Publishers: Decodable {
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

struct Trailers: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [TrailerResults]?
}

struct TrailerResults: Decodable {
    let id: Int?
    let name: String?
    let preview: String?
    let data: TrailerData?
}

struct TrailerData: Decodable {
    let p480: String?
    let max: String
    
    enum CodingKeys: String, CodingKey {
        case p480 = "480"
        case max
    }
}
