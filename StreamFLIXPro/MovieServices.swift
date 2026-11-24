//
//  MovieServices.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 13/11/26.
//

import Foundation

enum MovieServiceError: LocalizedError {
    case invalidResponse(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse(let statusCode):
            return "TMDb request failed with status code \(statusCode)."
        }
    }
}

struct MovieServices{
    func fetch<T: Decodable>(endPoint: String,as Type: T.Type) async throws -> T{
        let fixedURL = "https://api.themoviedb.org/3"
        let urlString = "\(fixedURL)\(endPoint)"
        guard let url = URL(string: urlString)
                else{
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = ("GET")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(
            "Bearer \(AppConfiguration.tmdbAccessToken)",
            forHTTPHeaderField: "Authorization"
        )
        
        let (data, response) = try await URLSession.shared.data(for :request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw MovieServiceError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
        
    }
    
}


