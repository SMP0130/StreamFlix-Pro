//
//  MainTabView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 15/11/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var favoriteStore = FavoriteStore()
    
    
    var body: some View {
        TabView{
            NavigationStack{
                ContentView()
            }
            .tabItem{
                Label("Home",systemImage: "house")
            }
            
            NavigationStack{
                SearchView()
            }
            .tabItem{
                Label("Search",systemImage: "magnifyingglass")
            }
            
            NavigationStack{
                FavoritesView()
            }
            .tabItem{
                Label("Favorite",systemImage: "heart")
            }
        }
        .task{
            await favoriteStore.loadMovies()
        }
        .environment(favoriteStore)
    }
}

#Preview {
    MainTabView()
}
