//
//  TrendAPIData.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/11/06.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trendAPI = try? JSONDecoder().decode(TrendAPI.self, from: jsonData)

import Foundation

// MARK: - TrendAPI
struct TrendAPI: Codable {
    let totalPages, page, totalResults: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case page
        case totalResults = "total_results"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let id: Int
    let originalName, firstAirDate: String?
    let mediaType: String?
    let voteCount: Int
    let backdropPath, overview: String?
    let adult: Bool
    let originalLanguage: String
    let originCountry: [String]?
    let genreIDS: [Int]
    let voteAverage, popularity: Double
    let posterPath: String?
    let originalTitle, title, releaseDate: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case name, id
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case mediaType = "media_type"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case overview, adult
        case originalLanguage = "original_language"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case voteAverage = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case title
        case releaseDate = "release_date"
        case video
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case hi = "hi"
    case ja = "ja"
}

