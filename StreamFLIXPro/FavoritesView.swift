//
//  FavoritesView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 15/11/26.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(FavoriteStore.self)
    private var favoriteStore
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(favoriteStore.favoriteStore){ movie in
                    NavigationLink{
                        MovieDetailView(movie: movie)
                    }label:{
                        HStack(spacing: 50) {
                            if let url = movie.posterURL {
                                AsyncImage(url: url){ image  in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }placeholder: {
                                    ProgressView()
                                }
                                .frame(width:80,height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Image(systemName: "photo")
                                    .foregroundStyle(.secondary)
                                    .frame(width:80,height: 120)
                                    .background(.quaternary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                            Text(movie.title)
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        0
                    }
                }
            }
            .navigationTitle("Favorites")
        }
            
        }
    }


#Preview {
    FavoritesView()
}
