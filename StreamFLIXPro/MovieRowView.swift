//
//  HorizontalScrollView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 13/11/26.
//

import SwiftUI

struct MovieRowView: View {
    let title : String
    let movies : [Movie]
    
   
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.gray.opacity(0.8))
            ScrollView(.horizontal,showsIndicators: false){
                LazyHStack(spacing: 12){
                        ForEach(movies){ movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            }
                            label:
                            {
                            if let posterURL = movie.posterURL {
                                AsyncImage(url: posterURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 130, height: 195)

                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()

                                    case .failure:
                                        Image(systemName: "photo")
                                            .foregroundStyle(.secondary)

                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width:130,height:195)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Image(systemName: "photo")
                                    .foregroundStyle(.secondary)
                                    .frame(width:130,height:195)
                                    .background(.quaternary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    }
                }
                .padding(.horizontal)
                
            }
        }
    }




