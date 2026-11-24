//
//  MoviePosterVIew.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 13/11/26.
//

import SwiftUI

struct FeaturedView: View {
    let featuredMovie : Movie
    
    var body: some View {
        NavigationLink {
            MovieDetailView(movie: featuredMovie)
        }label: {
            if let url = featuredMovie.posterURL {
                AsyncImage(url: url){ phase in
                    switch phase{
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity,maxHeight: 400,alignment: .top)

                    case .success(let image):
                        VStack{
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity,maxHeight: 400,alignment: .top)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Spacer()
                        }
                    case .failure:
                        ContentUnavailableView(
                            "Unable to Load Poster",
                            systemImage: "film"
                        )
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                ContentUnavailableView(
                    "Poster Unavailable",
                    systemImage: "film"
                )
            }
        }
  
            
        }
    }


