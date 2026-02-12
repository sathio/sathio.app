# Sathio: Voice-First Local Action Model (LAM) for India 🇮🇳

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue)
![Dart](https://img.shields.io/badge/Dart-3.3.0-blue)
![Supabase](https://img.shields.io/badge/Backend-Supabase-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

**Sathio** acts as your digital companion ("Saathi") that empowers users in India—especially those less familiar with technology—to perform complex digital tasks using simple voice commands in their native language.

It is not just a chatbot; it's a **Large Action Model (LAM)** that autonomously navigates apps and websites to get things done.

---

## 🚀 Key Features

*   🗣️ **Vernacular Voice Interface:** Speak naturally in Hindi, Bengali, Tamil, Marathi, and more. Powered by Bhashini & Sarvam AI.
*   🤖 **Autonomous Agent (LAM):** Handles complex workflows like "Check my PM-Kisan status" or "Download my Aadhaar card" automatically.
*   🎨 **Premium Luma-Inspired UX:** A beautiful, clean, and accessible interface designed for readability and ease of use.
*   📱 **Offline Lite Mode:** Provides critical information (FAQs, emergency numbers) even without an internet connection.
*   🇮🇳 **Hyper-Local Context:** Deeply integrated with Indian government services (UIDAI, DigiLocker, UPI).
*   🔔 **Smart Notifications:** Stay updated on scheme deadlines and status changes with push and local alerts.

---

## 🛠️ Technology Stack

*   **Frontend Framework:** Flutter (Dart)
*   **State Management:** Riverpod 2.0
*   **Navigation:** GoRouter
*   **Backend & Auth:** Supabase (PostgreSQL, Edge Functions)
*   **Local Database:** Hive (NoSQL)
*   **AI Models:**
    *   **Logic & Vision:** Google Gemini 1.5 Flash / Pro
    *   **Speech-to-Text (STT):** Bhashini / Sarvam AI / OpenAI Whisper
    *   **Text-to-Speech (TTS):** Bhashini / Sarvam AI / Google TTS
*   **Device Control:** Android Accessibility Service & Method Channels

---

## 📂 Project Structure

```
lib/
├── core/               # App configuration, themes, constants, router
│   ├── constants/      # India data, API keys
│   ├── theme/          # AppTheme, typography, colors
│   └── router/         # GoRouter setup
├── features/           # Feature-based modular architecture
│   ├── auth/           # Login, OTP, Phone Auth
│   ├── home/           # Dashboard, Voice Trigger
│   ├── onboarding/     # Welcome, Language Select, Profile Setup
│   ├── profile/        # Settings, User Preferences
│   ├── services/       # Govt Schemes, Bill Pay, Status Checks
│   └── voice/          # STT/TTS Logic, Animation Overlay
├── services/           # External service integrations
│   ├── api/            # API Clients (Dio)
│   ├── audio/          # Audio recording & playback
│   ├── database/       # Repositories (Supabase, Hive)
│   ├── lam/            # Large Action Model Orchestrator
│   └── notifications/  # FCM & Local Notifications
└── shared/             # Reusable widgets and models
```

---

## 🏁 Getting Started

### Prerequisites

*   **Flutter SDK:** Install version 3.19.0 or higher.
*   **Dart SDK:** Version 3.3.0 or higher.
*   **Android Studio:** For Android emulator and SDK manager.
*   **Supabase Account:** Create a project and get your URL & Anon Key.
*   **Bhashini/Sarvam API Keys:** For voice capabilities.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/sathio/sathio.app.git
    cd sathio.app
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Set up Environment Variables:**
    Create a `.env` file in the root directory:
    ```env
    SUPABASE_URL=your_supabase_url
    SUPABASE_ANON_KEY=your_supabase_anon_key
    BHASHINI_API_KEY=your_bhashini_key
    GEMINI_API_KEY=your_gemini_key
    ```

4.  **Run the App:**
    ```bash
    flutter run
    ```

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1.  Fork the repository.
2.  Create a new branch: `git checkout -b feature/your-feature-name`.
3.  Commit your changes: `git commit -m 'Add some feature'`.
4.  Push to the branch: `git push origin feature/your-feature-name`.
5.  Submit a pull request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Made with ❤️ for India 🇮🇳**
