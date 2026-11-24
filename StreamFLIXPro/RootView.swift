//
//  rootView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 16/11/26.
//

import SwiftUI

struct rootView: View {
    @State private var authenticationStore = AuthenticationStore()
  
    
    
    var body: some View {
        Group {
            if (authenticationStore.currentUser == nil) {
                NavigationStack {
                    LoginScreen()
                }
            } else {
                MainTabView()
            }
        }
        .environment(authenticationStore)
    }
}


#Preview {
    rootView()
}
