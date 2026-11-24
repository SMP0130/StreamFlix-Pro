# StreamFLIX Pro

StreamFLIX Pro is a native iOS movie discovery application built with Swift and SwiftUI. It retrieves movie data from TMDb, supports Firebase email and password authentication, stores favorites per user in Cloud Firestore, and embeds YouTube trailers in movie detail screens.

## Features

- Browse featured, trending, popular, and top-rated movies
- Search TMDb movie data
- View movie details, artwork, ratings, and trailers
- Register and sign in with Firebase Authentication
- Save and remove per-user favorites in Cloud Firestore
- Display loading, error, empty, and image fallback states

## Technologies

- Swift and SwiftUI
- Observation and SwiftUI environment injection
- URLSession, async/await, generics, and Codable
- Firebase Authentication and Cloud Firestore
- WebKit, WKWebView, and UIViewRepresentable
- Swift Package Manager

## Setup

1. Clone the repository and open `StreamFLIXPro.xcodeproj` in Xcode.
2. Create a TMDb account and generate a read access token.
3. Copy `StreamFLIXPro/Secrets.example.xcconfig` to `StreamFLIXPro/Secrets.xcconfig`.
4. Replace `YOUR_TMDB_READ_ACCESS_TOKEN` with your TMDb token.
5. Create a Firebase iOS application using your own bundle identifier.
6. Download `GoogleService-Info.plist` from Firebase and add it to the `StreamFLIXPro` target.
7. Enable Email/Password Authentication and create a Cloud Firestore database.
8. Build and run the application in an iOS Simulator.

Local credential files are excluded from version control. Never commit a real TMDb token or private service credentials.

## Architecture

The project uses observable reference types for shared authentication, movie, and favorites state. SwiftUI views receive shared stores through the environment, while Codable value types represent TMDb response data. Networking is centralized in a generic decoding service using async/await.

## Author

Smit Patel
