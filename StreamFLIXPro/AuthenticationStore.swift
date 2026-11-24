//
//  AuthenticationStore.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 16/11/26.
//

import Foundation
import FirebaseAuth


@MainActor
@Observable
final class AuthenticationStore{
    var currentUser : User?
    var isLoading = false
    var errorMessage : String?
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    
    func createUser(email: String,password: String) async {
        errorMessage = nil
        isLoading = true
        
        defer{
            isLoading = false
        }
        do{
           let result =  try await Auth.auth().createUser(withEmail: email, password: password)
                currentUser = result.user
        }catch{
            errorMessage = error.localizedDescription
        }
    }
    
    func signInUser(email: String, password: String) async{
        errorMessage = nil
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentUser = result.user
        }catch{
            errorMessage = error.localizedDescription
        }
    }
    
    func signOut(){
        errorMessage = nil
        
        do{
            try Auth.auth().signOut()
            currentUser = nil
        }catch{
            errorMessage = error.localizedDescription
        }
        
        
    }
}

