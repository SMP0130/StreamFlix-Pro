//
//  MovieDetailView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 14/11/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @State private var movieDetails: MovieDetails?
    @Environment(FavoriteStore.self)
    private var favoriteStore
    @State private var movieVideos = [MovieVideo]()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    ZStack(alignment: .center) {
                        if let trailer {
                            YouTubePlayerView(videoKey: trailer.key)
                        }
                        else{
                            ProgressView()
                        }
                    }
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading){
                        Text(movie.title)
                            .font(.title2.bold())
                        Text("Release Date: \(formattedReleaseDate)")
                            .foregroundStyle(.secondary)
                        if let runtime = movieDetails?.runtime{
                            Text("Runtime: \(runtime) minutes")
                                .foregroundStyle(.secondary)
                        }
                        if let genres = movieDetails?.genres, !genres.isEmpty {
                            let genreNames = genres
                                .map(\.name)
                                .joined(separator: ", ")
                            
                            Text("Genres: \(genreNames)")
                                .foregroundStyle(.secondary)
                        }
                        
                        if let average = movieDetails?.voteAverage{
                            let newAverage = String(format: "%.2f",average)
                            
                            Text("Rating : \(newAverage) / 10")
                                .foregroundStyle(.secondary)
                        }
                        
                        
                        if let tagLine = movieDetails?.tagline,!tagLine.isEmpty{
                            Text("Tagline: \(tagLine)")
                                .foregroundStyle(.secondary)
                        }
                        
                        Section{
                            if let overView = movieDetails?.overview{
                                Text(overView)
                                    .padding(.vertical)
                            }
                        }header: {
                            Text("Overview")
                                .font(.title3.bold())
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical,5)
                        
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await favoriteStore.toggle(movie)
                        }
                    } label: {
                        Image(
                            systemName: favoriteStore.isFavorite(movie)
                            ? "heart.fill"
                            : "heart"
                        )
                        .foregroundStyle(favoriteStore.isFavorite(movie) ? .red : .white)
                    }
                }
            }
        }
        .task{
            do{
                let response = try await MovieServices().fetch(endPoint: "/movie/\(movie.id)", as: MovieDetails.self)
                movieDetails = response
                
                let result =  try await MovieServices().fetch(endPoint: "/movie/\(movie.id)/videos", as: VideoResponse.self)
                movieVideos = result.results
                
                
            }
            catch{
                print("Movie details error:", error)
            }
        }
    }
    
    
    
    
    private var  trailer: MovieVideo? {movieVideos.first { video in
        video.site == "YouTube" && video.type == "Trailer"}}
    
    private var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let releaseDate = movie.releaseDate,
              !releaseDate.isEmpty else {
            return "Unknown"
        }
        
        guard let date = formatter.date(from: releaseDate) else {
            return releaseDate
        }
        
        return date.formatted(
            .dateTime
                .day()
                .month()
                .year()
        )
    }
}




#Preview {
    MovieDetailView(movie: .example)
        .preferredColorScheme(.dark)
}

