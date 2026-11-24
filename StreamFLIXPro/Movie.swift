//
//  Movie.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 13/11/26.
//

import Foundation
import SwiftUI

// MARK: - Welcome
struct MovieResponse: Codable,Hashable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct Movie: Codable,Hashable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let mediaType: String?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case id = "id"
        case title = "title"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity = "popularity"
        case releaseDate = "release_date"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    private static let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: Self.imageBaseURL + posterPath)
    }

    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: Self.imageBaseURL + backdropPath)
    }

    static let example = Movie(
        adult: false,
        backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg",
        id: 1,
        title: "Example Movie",
        originalLanguage: "en",
        originalTitle: "Example Movie",
        overview: "This is an example overview used to design and test the movie detail screen.",
        posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
        mediaType: "movie",
        genreIDS: [28, 18],
        popularity: 100,
        releaseDate: "2026-11-14",
        video: false,
        voteAverage: 8.4,
        voteCount: 1250
    )
}
