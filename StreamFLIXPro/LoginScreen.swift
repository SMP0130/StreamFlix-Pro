//
//  LoginScreen.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 16/11/26.
//

import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(AuthenticationStore.self)
    private var authenticationStore
    
    var body: some View {
        
            VStack(spacing:20){
                TextField("  Enter Your Email",text: $email)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.gray)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                SecureField("  Password",text: $password)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.gray)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button{
                    Task{
                        await authenticationStore.signInUser(email: email, password: password)
                    }
                }label:{
                    Text("Sign In")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.red)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
                NavigationLink{
                    SignUpView()
                }label: {
                    Text("Don't have an account ?")
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .navigationTitle("Login")
        
    }
}

#Preview {
    LoginScreen()
        .preferredColorScheme(.dark)
        .environment(AuthenticationStore())
}
