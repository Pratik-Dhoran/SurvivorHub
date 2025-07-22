# SurvivorHub – Esports Tournament Platform

**SurvivorHub** is a complete Flutter-based mobile application built for managing and participating in esports tournaments. It is divided into two separate apps – one for regular users (players) and one for admins (organizers). The project leverages Firebase as a backend and is optimized for a smooth, real-time tournament experience.

---

## User App – `survivor_hub`

This app is designed for players to explore, register, and engage in various esports tournaments.

### Key Features

- **Login / Signup** – Firebase authentication
- **Home Screen** – Display upcoming tournaments and promotional banners
- **Tournament Details** – View tournament-specific information
- **Join Tournaments** – Register for a tournament in one tap
- **Profile Management** – View and edit user profile
- **Video Player** – Watch intro or event-related videos
- **Notifications** – Receive updates and alerts
- **Static Pages** – About Us, Privacy Policy, Terms & Conditions, etc.

### Tech Stack

- Flutter (Dart)
- Firebase Auth
- Firebase Firestore
- Firebase Storage
- Shared Preferences
- Google Fonts
- Video Player
- HTTP
- Image Picker
- Screen Protector

### Folder Structure
```
lib/
├── screens/
│ ├── login_screen.dart
│ ├── home_screen.dart
│ ├── registration_screen.dart
│ ├── tournament_detail_screen.dart
│ ├── tournament_registration_page.dart
│ ├── video_screen.dart
│ ├── my_profile_screen.dart
│ ├── notification_screen.dart
│ └── ... (about us, splash, etc.)
├── utils/
├── widgets/
└── main.dart
```

---

## Admin App – `survivorhub_admin`

This app is for tournament organizers to manage players, view registrations, and send broadcast notifications.

### Key Features

- **Admin Dashboard** – Overview and quick access to features
- **User List** – View all registered users
- **Registration List** – See participants for each tournament
- **Send Notifications** – Push updates to all users via Firestore

### Tech Stack

- Flutter (Dart)
- Firebase Auth
- Firebase Firestore
- Cached Network Image

### Folder Structure 
```
lib/
├── admin_home_screen.dart
├── user_list_screen.dart
├── registration_list_screen.dart
├── NotificationSenderScreen.dart
└── main.dart
```

---

## 🔧 Installation & Setup

```bash
# For both apps:
flutter pub get
flutter run


