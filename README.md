# 📚 Read Era - Personal Book Discovery App

**Read Era** is a minimalist yet powerful Flutter application for book discovery. It combines a clean UI with real-time Firebase synchronization to provide users with a seamless reading collection management experience.

---

## ✨ Experience

*   🚀 **Secure Auth** – Instant Google Sign-In with automated user profile provisioning.
*   📖 **Live Discovery** – Real-time book feed synchronized with Cloud Firestore.
*   🔍 **Swift Search** – High-performance client-side filtering by title and author.
*   🔖 **Cloud Collection** – Persistent, cross-device bookmarks.

---

## 📱 App Gallery

| **Authenticated Access** | **Home Discovery** | **Intelligent Search** |
| :---: | :---: | :---: |
| ![Login Screen](screenshots/login.png) | ![Home Feed](screenshots/home.png) | ![Search Interface](screenshots/search.png) |

| **Deep Dive Details** | **Personal Collection** |
| :---: | :---: |
| ![Book Details](screenshots/detail.png) | ![User Library](screenshots/collection.png) |

---

## 🛠️ Tech Stack

*   **UI Framework:** Flutter (Material Design 3)
*   **Backend:** Firebase Authentication & Cloud Firestore
*   **State Management:** Multi-Provider Architecture
*   **Optimization:** Cached Network Image for efficient asset loading

---

## 📂 Architecture

```bash
lib/
├── config/     # Design tokens & theme
├── models/     # Data entities
├── services/   # Firebase service layer
├── providers/  # Reactive state layers
├── screens/    # Feature-based view layers
└── widgets/    # Modular UI components
```

---

## 🚀 Quick Setup

1.  **Repository Setup**
    ```bash
    git clone [repository-url]
    cd read_era
    flutter pub get
    ```

2.  **Environment Configuration**
    *   Place `google-services.json` in `android/app/`.
    *   Refer to **[FIREBASE_SETUP.md](FIREBASE_SETUP.md)** for backend configuration.

3.  **Launch**
    ```bash
    flutter run
    ```

---

## 📜 License

Distributed under the MIT License.

---

*Engineered with Flutter & Firebase*
