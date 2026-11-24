//
//  Configuration.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 15/11/26.
//

import Foundation

enum AppConfiguration {
    static var tmdbAccessToken: String {
        guard let token = Bundle.main.object(
            forInfoDictionaryKey: "TMDBAccessToken"
        ) as? String,
        !token.isEmpty else {
            fatalError("TMDb access token is missing")
        }

        return token
    }
}
