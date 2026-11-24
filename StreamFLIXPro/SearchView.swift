//
//  SearchView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 15/11/26.
//

import SwiftUI


struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    
    var body: some View {
        List{
            ForEach(viewModel.searchResults){ movie in
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
            .navigationTitle("Search")
            .searchable(
                text: $searchText,
                prompt: "Search movies"
            )
            .onSubmit(of: .search){
                Task{
                    await viewModel.searchMovie(for: searchText)
                }
            }
    }
        
}

#Preview {
    SearchView()
}
