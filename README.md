# Free Style 

## 📌 Overview

Free Style is a Flutter-based mobile application focused on skill-based battles, challenges, and social interaction. Users can compete in battles, showcase their skills through video submissions, and climb leaderboards while interacting with friends.

---

## 🚀 Features

### ⚔️ Battle System

* 1v1 skill-based battles
* Invite friends or join random battles
* Battle status tracking (active, completed)
* Winner determination & rewards

### 🎯 Skill Challenges

* Skill-based progression system
* Skill tree UI with unlockable skills
* Daily and ongoing challenges

### 🏆 Leaderboard

* Global leaderboard with rankings
* RP (Ranking Points) based progression
* League system (Bronze, Silver, Gold, etc.)

### 👥 Social Features

* Add / Remove friends
* Send battle invites
* Accept / reject requests

### 🔔 Notifications

* Firebase push notifications
* Local notifications support
* Real-time updates for battle status

### 🎥 Video Submission

* Upload battle proof videos
* Support for YouTube & MP4 playback

### 💬 Chat & Blocking

* Chat system using Firebase
* Block / Unblock users
* Real-time status handling

### 🎒 Inventory System

* Manage avatars and balls
* Equip items from inventory
* Premium & free assets support

---

## 🛠️ Tech Stack

* **Flutter** (Dart)
* **Firebase**

    * Cloud Messaging (FCM)
    * Firestore (Chat & Realtime)
* **REST APIs** (Dio)
* **Bloc / Cubit** (State Management)
* **Local Notifications**

---

## 📂 Project Structure

```
lib/
 ├── network_class/       # API services & endpoints
 ├── routes/              # App navigation
 ├── utils/               # Common utilities, widgets, constants
 ├── views/               # UI screens
 │    ├── dashboard/
 │    ├── battle/
 │    ├── match_making/
 │    ├── notifications/
 │    ├── profile/
 │    └── chat/
 └── main.dart            # Entry point
```

---

## ⚙️ Setup & Installation

### 1. Clone the repository

```
git clone https://github.com/promatics-mobile/free_style.git
cd free_style
```

### 2. Install dependencies

```
flutter pub get
```

### 3. Setup Firebase

* Add `google-services.json` (Android)
* Add `GoogleService-Info.plist` (iOS)

### 4. Run the app

```
flutter run
```

---

## 🔐 Environment Setup

Make sure to configure:

* API base URLs
* Firebase configuration
* Notification permissions (Android 13+)

---

## 📡 API Integration

* Uses **Dio** for network calls
* Centralized API handling via `DioNetworkCall`
* Pagination support (offset + limit)

---

## 🔄 State Management

* Uses **Bloc / Cubit**
* Clean separation of UI & business logic
* Handles:

    * Battle flow
    * Notifications
    * History
    * Matchmaking

---

## 🎨 UI Highlights

* Custom reusable widgets
* Responsive design
* Animated progress indicators
* Stepper-based skill tree UI

---

## 📦 Key Modules

| Module        | Description                               |
| ------------- | ----------------------------------------- |
| Battle        | Handles battle creation, invites, results |
| Matchmaking   | Opponent finding & battle start           |
| Notifications | Push + in-app notifications               |
| Chat          | Real-time messaging & blocking            |
| Profile       | User stats & progression                  |
| Inventory     | Avatar & equipment management             |

---

## 📄 License

This project is proprietary and owned by **Promatics Technologies**.

---

## 🙌 Acknowledgements

Developed by **Rajan Prajapati** 🚀

---

## 📬 Contact

For any queries or support, please contact **Promatics Technologies**.
