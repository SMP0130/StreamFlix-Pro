//
//  YouTubePlayerView.swift
//  StreamFLIXPro
//
//  Created by Patel Smit on 17/11/26.
//

import Foundation
import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
  
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    let videoKey: String
    
    func makeUIView(context: Context) -> WKWebView {
        
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        
        guard let url = URL(
            string: "https://www.youtube.com/embed/\(videoKey)?playsinline=0"
        ) else {
            return webView
        }
        
        guard let bundleID = Bundle.main.bundleIdentifier else {
            return webView
        }

        var request = URLRequest(url: url)
        request.setValue(
            "https://\(bundleID.lowercased())",
            forHTTPHeaderField: "Referer"
        )
        webView.load(request)
        
        return webView
    }
}
