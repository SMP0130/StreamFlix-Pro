//
//  FavoriteStore.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 15/11/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@Observable
@MainActor
class FavoriteStore{
    var favoriteStore = [Movie]()
    let db = Firestore.firestore()
    
    
    func isFavorite(_ movie: Movie) -> Bool{
        favoriteStore.contains{ favoriteMovie in
            favoriteMovie.id == movie.id
        }
    }
    
    func add(_ movie:Movie)async{
        guard !isFavorite(movie) else{
            return
        }
        
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        do{
            try db
                .collection("users")
                .document(id)
                .collection("favorites")
                .document(String(movie.id))
                .setData(from: movie)
        }catch{
            print(error.localizedDescription)
        }
        favoriteStore.append(movie)
        
    }
    func loadMovies() async{
        guard let id = Auth.auth().currentUser?.uid else { return }
        do{
            let snapshot = try await db
                .collection("users")
                .document(id)
                .collection("favorites")
                .getDocuments()
            
            let result = snapshot.documents.compactMap {
                try? $0.data(as: Movie.self)
            }
            
            favoriteStore = result
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func remove(_ movie: Movie)async{
       
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        do{
            try await db
                .collection("users")
                .document(id)
                .collection("favorites")
                .document(String(movie.id))
                .delete()
            if let index = favoriteStore.firstIndex(where: { $0.id == movie.id }){
                favoriteStore.remove(at: index)
            }
        }catch{
            print(error.localizedDescription)
        }
            
    }
    func toggle(_ movie: Movie)async {
        if isFavorite(movie) {
           await remove(movie)
        } else {
            await add(movie)
        }
    }
    
    
}
