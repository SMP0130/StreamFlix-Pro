//
//  SearchViewModel.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 15/11/26.
//

import SwiftUI
@MainActor
@Observable
class SearchViewModel{
    
    var searchResults = [Movie]()
    
    func searchMovie(for query:String) async{
        var components = URLComponents()
        components.path = "/search/movie"
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        guard let endpoint = components.string else {
            return
        }
        
        do{
            let response = try await MovieServices().fetch(endPoint: endpoint, as: MovieResponse.self)
            searchResults = response.results
        }
        catch{
            print("Search error:", error)
        }
        
        
    }
}
