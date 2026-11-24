//
//  ContentView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 13/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = MovieViewModel()
    @Environment(AuthenticationStore.self)
    private var authenticationStore
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack{
                    
                    if viewModel.isLoading {
                        ProgressView("Loading movies…")
                    } else if let errorMessage = viewModel.errorMessage {
                        ContentUnavailableView(
                            "Unable to Load Movies",
                            systemImage: "wifi.exclamationmark",
                            description: Text(errorMessage)
                        )
                    } else if let featuredMovie = viewModel.featuredMovie {
                        FeaturedView(featuredMovie: featuredMovie)
                    } else {
                        ContentUnavailableView(
                            "No Movies",
                            systemImage: "film"
                        )
                    }
                    if !viewModel.trendingMovies.isEmpty {
                        MovieRowView(
                            title: "Trending Movies",
                            movies: viewModel.trendingMovies
                        )
                    }
                    if !viewModel.popularMovies.isEmpty {
                        MovieRowView(
                            title: "Popular Movies",
                            movies: viewModel.popularMovies
                        )
                    }
                    if !viewModel.topRatedMovies.isEmpty {
                        MovieRowView(
                            title: "Top Rated Movies",
                            movies: viewModel.topRatedMovies
                        )
                    }
                }
                
                
            }
            .navigationTitle("Home")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        authenticationStore.signOut()
                    }label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
        }
        
        .preferredColorScheme(.dark)
        .task {
            await viewModel.loadMovies()
        }
    }
}



