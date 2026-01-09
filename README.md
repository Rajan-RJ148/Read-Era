# Read Era - Book Discovery App

A Flutter-based book discovery application with Firebase backend, featuring Google authentication, book browsing, search functionality, and user-specific bookmarking.

## Features

✅ **Google Authentication** - Secure login with Google Sign-In  
✅ **Book Discovery** - Browse all available books with beautiful UI  
✅ **Smart Search** - Search books by name or author  
✅ **Personal Collection** - Bookmark your favorite books  
✅ **Book Details** - View comprehensive book information  
✅ **Real-time Sync** - Bookmarks persist across devices and sessions

## Screenshots

### 🔑 Authentication Flow
````carousel
![Login Screen](/C:/Users/Welcome/.gemini/antigravity/brain/23473efc-0e9d-42fe-ab2b-422b8a840d36/app_login_screen.png)
<!-- slide -->
![Auth Checking](/C:/Users/Welcome/.gemini/antigravity/brain/23473efc-0e9d-42fe-ab2b-422b8a840d36/app_auth_checking.png)
<!-- slide -->
![Google Sign-In](/C:/Users/Welcome/.gemini/antigravity/brain/23473efc-0e9d-42fe-ab2b-422b8a840d36/app_google_signin.png)
````

### 📚 App Features
````carousel
![Home Screen](/C:/Users/Welcome/.gemini/antigravity/brain/23473efc-0e9d-42fe-ab2b-422b8a840d36/app_home_screen.png)
<!-- slide -->
![Search & Explore](/C:/Users/Welcome/.gemini/antigravity/brain/23473efc-0e9d-42fe-ab2b-422b8a840d36/app_explore_screen.png)
<!-- slide -->
![Book Detail](/C:/Users/Welcome/.gemini/antigravity/brain/23473efc-0e9d-42fe-ab2b-422b8a840d36/app_book_detail.png)
<!-- slide -->
![My Collection](/C:/Users/Welcome/.gemini/antigravity/brain/23473efc-0e9d-42fe-ab2b-422b8a840d36/app_collection_screen.png)
````

## Tech Stack

- **Flutter** - Latest stable version
- **Firebase Authentication** - Google Sign-In
- **Cloud Firestore** - Real-time database
- **Provider** - State management
- **Cached Network Image** - Optimized image loading

## Project Structure

```
lib/
├── config/
│   └── theme.dart              # App theme and colors
├── models/
│   ├── book.dart               # Book data model
│   └── user_model.dart         # User data model
├── services/
│   ├── auth_service.dart       # Authentication logic
│   ├── firestore_service.dart  # Firestore operations
│   └── bookmark_service.dart   # Bookmark management
├── providers/
│   ├── auth_provider.dart      # Auth state management
│   ├── books_provider.dart     # Books state management
│   └── bookmarks_provider.dart # Bookmarks state management
├── screens/
│   ├── auth/
│   │   └── login_screen.dart   # Login screen
│   ├── home/
│   │   └── home_screen.dart    # Home tab
│   ├── explore/
│   │   └── explore_screen.dart # Search tab
│   ├── collection/
│   │   └── collection_screen.dart # Bookmarks tab
│   ├── book_detail/
│   │   └── book_detail_screen.dart # Book details
│   └── main_navigation.dart    # Bottom navigation
├── widgets/
│   ├── book_card.dart          # Reusable book card
│   ├── genre_tag.dart          # Genre badge
│   └── bookmark_button.dart    # Bookmark toggle
└── main.dart                   # App entry point
```

## Firebase Setup

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" and follow the setup wizard
3. Name your project (e.g., "read-era")
4. Disable Google Analytics (optional)

### 2. Enable Authentication

1. In Firebase Console, go to **Authentication** → **Sign-in method**
2. Enable **Google** sign-in provider
3. Add your support email

### 3. Create Firestore Database

1. Go to **Firestore Database** → **Create database**
2. Start in **test mode** (for development)
3. Choose a location close to your users

### 4. Firestore Security Rules

Update your Firestore rules to:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Books collection - read-only for all authenticated users
    match /books/{bookId} {
      allow read: if request.auth != null;
      allow write: if false; // Only admins can add books manually
    }
    
    // Users collection - users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 5. Add Sample Books to Firestore

Manually add books to the `books` collection with this structure:

```javascript
{
  bookName: "I Want a Better Catastrophe",
  authorName: "Andrew Boyd",
  imageUrl: "https://example.com/book-cover.jpg",
  genre: "Non-Fiction",
  storyBrief: "A brief description of the story...",
  detailedOverview: "A detailed overview of the book content..."
}
```

**Example books to add:**
- Fiction books with genre "Fiction"
- Non-fiction books with genre "Non-Fiction"
- Add at least 5-10 books for testing

### 6. Configure Android App

1. In Firebase Console, click **Add app** → **Android**
2. Enter your package name: `com.example.read_era`
3. Download `google-services.json`
4. Place it in `android/app/` directory

5. Update `android/build.gradle`:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

6. Update `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        minSdkVersion 21  // Update to 21 or higher
    }
}
```

7. Get SHA-1 certificate fingerprint:
```bash
cd android
./gradlew signingReport
```
Copy the SHA-1 and add it to Firebase Console → Project Settings → Your Android app

### 7. Configure iOS App (if needed)

1. In Firebase Console, click **Add app** → **iOS**
2. Enter your bundle ID: `com.example.readEra`
3. Download `GoogleService-Info.plist`
4. Open `ios/Runner.xcworkspace` in Xcode
5. Drag `GoogleService-Info.plist` into the Runner folder
6. Update `ios/Runner/Info.plist` with Google Sign-In URL scheme

## Installation & Running

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio / Xcode
- Firebase project configured

### Steps

1. **Clone the repository**
```bash
git clone <repository-url>
cd read_era
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Firebase**
   - Add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to `ios/Runner/` (for iOS)

4. **Run the app**
```bash
flutter run
```

## Usage

1. **Login**: Tap "Login with Google" and authenticate
2. **Browse Books**: View all books on the Home tab
3. **Search**: Use the Explore tab to search by book name or author
4. **Bookmark**: Tap the bookmark icon on any book detail page
5. **My Collection**: View all your bookmarked books in the My Collection tab

## Firestore Data Structure

### Books Collection
```
books/
  └── {bookId}
      ├── bookName: string
      ├── authorName: string
      ├── imageUrl: string
      ├── genre: string
      ├── storyBrief: string
      └── detailedOverview: string
```

### Users Collection
```
users/
  └── {userId}
      ├── name: string
      ├── email: string
      └── bookmarks: array<string> (array of bookId references)
```

## Key Implementation Details

### Authentication
- Google Sign-In integration with Firebase Auth
- Automatic user document creation on first login
- Persistent authentication state

### Bookmark System
- User-specific bookmarks stored in Firestore
- Real-time synchronization using streams
- Duplicate prevention using `arrayUnion`
- Bookmarks persist across sessions and devices

### Search Functionality
- Client-side filtering for case-insensitive search
- Search by book name or author name
- Real-time results as you type

### State Management
- Provider pattern for clean separation of concerns
- Three main providers: Auth, Books, Bookmarks
- Reactive UI updates on data changes

## Testing Checklist

- [ ] Google Sign-In works correctly
- [ ] Books display on Home screen
- [ ] Search returns correct results
- [ ] Bookmark adds book to collection
- [ ] Unbookmark removes book from collection
- [ ] Bookmarks persist after app restart
- [ ] Same book cannot be bookmarked twice
- [ ] My Collection shows all bookmarked books

## Known Limitations

- Email/Password authentication not implemented (Google Sign-In only)
- Search is client-side (loads all books then filters)
- No offline support
- No reading progress tracking
- No pagination for large book collections

## Future Enhancements

- Email/Password authentication
- Server-side search with Algolia or similar
- Offline mode with local caching
- Reading progress tracking
- Book ratings and reviews
- Social features (share books, follow friends)

## Troubleshooting

### Google Sign-In fails
- Verify SHA-1 certificate is added to Firebase Console
- Check that `google-services.json` is in the correct location
- Ensure Google Sign-In is enabled in Firebase Authentication

### Books not loading
- Verify Firestore rules allow authenticated reads
- Check that books collection exists with sample data
- Look for errors in console logs

### Bookmarks not saving
- Verify Firestore rules allow user writes to their own document
- Check that user document was created on login
- Ensure user is authenticated

## License

This project is created for educational purposes.

## Contact

For questions or issues, please open an issue in the repository.
