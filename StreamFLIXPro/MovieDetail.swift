//
//  MovieDetail.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 14/11/26.
//

import Foundation

struct MovieDetails: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String
    let runtime: Int?
    let genres: [Genre]
    let tagline: String?
    let status: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime
        case genres, tagline, status
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct Genre: Decodable,Identifiable{
    let id: Int
    let name: String
}

extension MovieDetails {
    static let example = MovieDetails(
        id: 11,
        title: "Star Wars",
        overview: "Princess Leia is captured by Imperial forces. Luke Skywalker joins Han Solo to rescue her and restore peace to the galaxy.",
        backdropPath: "/2w4xG178RpB4MDAIfTkqAuSJzec.jpg",
        posterPath: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
        releaseDate: "1977-05-25",
        runtime: 121,
        genres: [
            Genre(id: 12, name: "Adventure"),
            Genre(id: 28, name: "Action"),
            Genre(id: 878, name: "Science Fiction")
        ],
        tagline: "A long time ago in a galaxy far, far away...",
        status: "Released",
        voteAverage: 8.2
    )
}
