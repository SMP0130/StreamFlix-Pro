//
//  MovieViewModel.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 13/11/26.
//

import Observation
import Foundation

@MainActor
@Observable
final class MovieViewModel {
    var trendingMovies : [Movie] = []
    var popularMovies : [Movie] = []
    var topRatedMovies : [Movie] = []
    var featuredMovie : Movie?
    var isLoading = false
    var errorMessage : String?
    
    func loadMovies() async {
         isLoading = true
        errorMessage = nil
        
        defer{
            isLoading = false
        }
        do{
            do {
                let response = try await MovieServices().fetch(endPoint: "/trending/movie/day", as: MovieResponse.self)
                trendingMovies = response.results
                featuredMovie = trendingMovies.randomElement()
            }
            do {
                let response = try await MovieServices().fetch(endPoint: "/movie/popular", as: MovieResponse.self)
                popularMovies = response.results
            }
            do {
                let response = try await MovieServices().fetch(endPoint: "/movie/top_rated", as: MovieResponse.self)
                topRatedMovies = response.results
            }
          
            
        }catch {
            errorMessage = error.localizedDescription
        }
    }
}


