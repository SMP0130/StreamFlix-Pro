//
//  StreamFLIXProApp.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 13/11/26.
//

import SwiftUI
import FirebaseCore

@main
struct StreamFLIXProApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
           rootView()
        }
    }
}
