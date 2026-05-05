# 🏋️‍♂️ Super Fitness - Flutter Health & Workout Application

## 💻 Project Description

### 🎯 Overview
**Super Fitness** is a comprehensive, modern Flutter mobile application designed to help users train smarter, eat better, and stay consistent in achieving their fitness goals. It combines personalized workouts, meal recommendations, and an AI-powered Smart Coach chatbot — all in one intuitive and engaging experience.

The application follows **Clean Architecture**, **Bloc/Cubit (MVI pattern)**, and a scalable modular design to deliver high performance, reliability, and a smooth user experience across Android and iOS.

---

## 🏗️ Architecture and Structure

The project follows a **Clean Architecture** approach to ensure clear separation of concerns and a maintainable code structure.

| Layer | Folder(s) | Role & Responsibilities |
| :--- | :--- | :--- |
| **Presentation** | `presentation` (screens, widgets, cubits) | Handles UI rendering and user interaction using Bloc/Cubit (MVI pattern) for state management. |
| **Domain** | `domain` (entities, repos, usecases) | Contains business logic, entities, and repository contracts independent of data sources. |
| **Data** | `data` (models, datasource, repos) | Handles API calls, local storage, and data mapping between models and entities. |
| **Core / API** | `app/core/` | Centralized networking, routing, services (like Gemini AI), and error handling. |

---

## ✨ Key Features

- **🚀 Onboarding & Authentication**
  - **Onboarding Flow:** Interactive introduction screens showcasing the app’s features.
  - **Login / Sign Up:** Secure authentication using email and password.
  - **Forgot Password:** Simple reset password process through a dedicated view.

- **🏠 Home Screen**
  - The main dashboard providing users with personalized recommendations and progress insights.
  - **Categories Section:** Explore workout and nutrition categories.
  - **Recommended Exercises for Today:** Smart daily workout suggestions.
  - **Upcoming Workouts:** Select a muscle group (e.g., Chest, Back, Legs) and view related workouts displayed in a horizontal scroll list.
  - **Recommended Meals:** Curated meal recommendations based on user goals.
  - **Popular Training:** Discover trending workouts from the community.

- **💪 Muscle Details & Workouts**
  - Browse all muscle groups available in the app.
  - Displays a list of exercises for the selected muscle group.
  - Each exercise includes a **tutorial video** for proper form and guidance.

- **🍽️ Food Recommendation View**
  - Divided into food sections, each containing a list of healthy meals.
  - Each meal includes detailed ingredients, nutritional information, and related meal recommendations.
  - **Preparation Videos** integrated seamlessly via YouTube Player.

- **🤖 Smart Coach Chat Bot**
  - Your personal AI fitness assistant built with **Google Gemini AI**.
  - Chat naturally for workout plans, nutrition advice, motivation, and consistency tips.
  - Local chat history persistence using **Sqflite** for offline access.

- **👤 Profile & Settings**
  - **Edit Profile:** Update name, profile picture, goal, and personal details.
  - **Change Password:** Secure password management.
  - **Language Switch:** Instantly toggle between **English** and **Arabic** (RTL support).
  - **Security, Privacy & Help:** Manage privacy, data permissions, legal info, and support.

---

## 🖼️ Screenshots

### 🔐 Authentication
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="assets/images/placeholder.png" width="150" alt="Splash"/>
  <img src="assets/images/placeholder.png" width="150" alt="Login"/>
  <img src="assets/images/placeholder.png" width="150" alt="Register"/>
  <img src="assets/images/placeholder.png" width="150" alt="OTP"/>
</div>

---

### 🏠 Home & Workouts
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="assets/images/placeholder.png" width="150" alt="Home"/>
  <img src="assets/images/placeholder.png" width="150" alt="Exercises"/>
  <img src="assets/images/placeholder.png" width="150" alt="Workout Details"/>
</div>

---

### 🥗 Meals & Nutrition
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="assets/images/placeholder.png" width="150" alt="Meals"/>
  <img src="assets/images/placeholder.png" width="150" alt="Meal Details"/>
</div>

---

### 🤖 Smart Coach (AI)
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="assets/images/placeholder.png" width="150" alt="Smart Coach Start"/>
  <img src="assets/images/placeholder.png" width="150" alt="Smart Coach Chat"/>
</div>

---

### 👤 Profile & Settings
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="assets/images/placeholder.png" width="150" alt="Profile"/>
  <img src="assets/images/placeholder.png" width="150" alt="Edit Profile"/>
</div>

*(Note: Replace the image paths with actual screenshots from your `assets/images/` directory once available)*

---

## 🛠️ Tech Stack & Dependencies

### Core Architecture & State Management
| Package | Purpose |
|---|---|
| `flutter_bloc` / `bloc` | Reactive and scalable state management (MVI Pattern) |
| `go_router` | Declarative routing |
| `get_it` + `injectable` | Service locator & dependency injection |

### Networking & AI
| Package | Purpose |
|---|---|
| `dio` + `retrofit` | Efficient and type-safe HTTP client for API calls |
| `google_generative_ai` | Gemini AI integration for the Smart Coach chatbot |
| `flutter_dotenv` | Secure environment variable management |

### UI & UX
| Package | Purpose |
|---|---|
| `easy_localization` | i18n — English & Arabic with RTL support |
| `skeletonizer` / `shimmer` | Loading skeleton UI animations |
| `youtube_player_flutter` | Embedded video player for exercise and meal tutorials |
| `cached_network_image` | Efficient remote image loading |

### Data & Storage
| Package | Purpose |
|---|---|
| `sqflite` | Local database for storing Smart Coach chat history |
| `flutter_secure_storage` | Securely stores authentication tokens and credentials |
| `shared_preferences` | App settings local storage |

---

## 🚀 Getting Started

### Prerequisites
1. Ensure you have the Flutter SDK installed.
2. Obtain a **Gemini API Key** from Google AI Studio.

### Installation

```bash
# Clone the repository
git clone <your-repository-url>
cd super_fitness_app

# Create environment file and add your Gemini API Key
echo "GEMINI_API_KEY=your_api_key_here" > assets/.env

# Install dependencies
flutter pub get

# Run code generation (Retrofit, Injectable, JSON)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

---

## 🧪 Testing & Quality Assurance

Super Fitness includes comprehensive testing to ensure reliability and code quality, achieving a **test coverage of 84%**.

| Type | Packages |
|---|---|
| Unit / Widget Tests | `flutter_test`, `bloc_test` |
| Mocking | `mockito`, `mocktail` |
| Image Mocking | `network_image_mock` |

### Covers key components such as:
- API data handling and repository layers.
- UI widgets and Bloc/Cubit state transitions.

```bash
flutter test
```

---

## 🌐 Localization

Supports **English** and **Arabic** with instantly toggleable RTL layout.

```text
assets/translations/
├── en.json
└── ar.json
```

---

## 🧭 App Routes

| Route | Path | Screen |
|---|---|---|
| App Start | `/appStart` | Splash / Decision screen |
| Onboarding | `/onboarding` | Interactive intro screens |
| Sign In | `/signIn` | User login |
| Sign Up | `/signup` | User registration |
| Complete Signup | `/completeSignup` | User details collection |
| Forgot Password | `/forgetPassword` | Password recovery |
| Verify Code | `/verifyResetCode` | OTP verification |
| Reset Password | `/resetPassword` | Set new password |
| Home | `/home` | Main dashboard / Categories |
| Dashboard | `/homeScreen` | Home metrics and overviews |
| Exercises | `/exercises` | Muscle details & videos |
| Meals | `/meals` | Nutritional meals list |
| Meal Details | `/mealDetails` | Single meal information & videos |
| Smart Coach | `/smartCoach` | AI Coach landing screen |
| AI Chat | `/smartCoachChat` | Interactive Gemini AI Chat |
| Profile | `/profile` | User profile management |
| Edit Profile | `/editProfile` | Update personal info |
| Change Password| `/changePassword` | Update security credentials |
| Help / Privacy | `/helpPage`, `/privacyPage` | Support, Privacy, and Security |
