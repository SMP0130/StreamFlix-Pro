//
//  MovieVideo.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 17/11/26.
//

import Foundation

struct VideoResponse: Decodable{
    let id: Int
    let results: [MovieVideo]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}

struct MovieVideo: Decodable{
    let iso639_1: String
       let iso3166_1: String
       let name: String
       let key: String
       let site: String
       let size: Int
       let type: String
       let official: Bool
       let publishedAt: String
       let id: String

       enum CodingKeys: String, CodingKey {
           case iso639_1 = "iso_639_1"
           case iso3166_1 = "iso_3166_1"
           case name = "name"
           case key = "key"
           case site = "site"
           case size = "size"
           case type = "type"
           case official = "official"
           case publishedAt = "published_at"
           case id = "id"
       }
}
