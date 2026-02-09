# SATHIO — VIBE CODING PROMPTS

**Purpose:** Step-by-step prompts optimized for Google Antigravity IDE  
**Usage:** Copy each prompt, paste into the agent, wait for completion, then continue to next prompt  
**Tip:** Each prompt is self-contained. If something breaks, re-run that prompt or the previous one.

---

## ⚠️ CRITICAL: START EVERY SESSION WITH THIS PROMPT

### Prompt 0.0 — Context Loading (ALWAYS RUN FIRST)
```
Before we start building, please thoroughly analyze these documentation files in the ./Info/ folder:

1. Read FINAL_PRD.md - Complete product requirements, features, monetization, user personas
2. Read IMPLEMENTATION_PLAN.md - Technical architecture, tech stack, development phases
3. Read PROJECT_CONTEXT.md - Brand philosophy, voice design, team values
4. Read UI_UX.md - Design system, colors, typography, components, screens

After reading all files, confirm you understand:
- What Sathio is (voice-first vernacular AI assistant for India)
- Target users (farmers, shopkeepers, seniors, migrants)
- Core features (voice interaction, government services, guided mode)
- Design language (Teal + Orange, Noto Sans, icon-heavy, 48dp touch targets)
- Technical stack (Flutter, FastAPI, Supabase, Bhashini APIs)

Say "I've analyzed all documentation and I'm ready to build Sathio" when done.
```

---

## 🛠️ RECOMMENDED TECH STACK

Based on Sathio's requirements (India-first, offline-capable, scalable, cost-effective), here's the optimal stack:

### Authentication: **Supabase Auth**
**Why Supabase Auth?**
- ✅ Phone OTP authentication (critical for India - most users don't have email)
- ✅ Anonymous auth (guest mode for first-time users)
- ✅ Social login (Google) as backup
- ✅ Row Level Security for data protection
- ✅ Free tier: 50,000 MAU
- ✅ Works offline with token caching
- ✅ India data residency available

**Alternatives considered:**
- Firebase Auth: Good but Google lock-in, less control
- Auth0: Expensive at scale
- Custom JWT: More work, security risks

### Backend: **Supabase + Edge Functions**
**Why Supabase?**
- ✅ Postgres database included (ACID compliant, powerful)
- ✅ Edge Functions for serverless logic (Deno-based)
- ✅ Real-time subscriptions (for notifications)
- ✅ Storage for audio files
- ✅ Free tier generous (500MB database, 1GB storage)
- ✅ Self-hostable if needed later
- ✅ Scales automatically

**For ML/AI heavy lifting:**
- Use separate FastAPI service on Railway/Render for Bhashini integration
- Or use Supabase Edge Functions to call Bhashini APIs

**Alternatives considered:**
- Firebase: Good but Firestore has querying limitations
- PocketBase: Great but less mature
- Custom FastAPI: More control but more DevOps work

### Database: **Supabase PostgreSQL**
**Why PostgreSQL (via Supabase)?**
- ✅ Full SQL support (complex queries for analytics)
- ✅ JSONB for flexible schema (FAQs, schemes)
- ✅ Full-text search (search queries in Hindi/Tamil)
- ✅ PostGIS for location (state/district filtering)
- ✅ Row Level Security for privacy
- ✅ Triggers for automation
- ✅ Free tier: 500MB

**Additional storage:**
- Hive (Flutter) for local offline cache
- Supabase Storage for audio files
- Optional: Pinecone/Supabase pgvector for semantic search (Phase 2)

### Complete Stack Summary

| Layer | Technology | Cost (MVP) |
|-------|------------|------------|
| **Frontend** | Flutter | Free |
| **Auth** | Supabase Auth | Free (50K MAU) |
| **Backend** | Supabase Edge Functions | Free tier |
| **Database** | Supabase PostgreSQL | Free (500MB) |
| **Storage** | Supabase Storage | Free (1GB) |
| **ML/Voice** | Bhashini APIs | Free (govt) |
| **Fallback ML** | FastAPI on Railway | Free tier |
| **Push Notifications** | Firebase FCM | Free |
| **Analytics** | Supabase + Mixpanel | Free tier |

**Total MVP Cost: ₹0 - ₹5,000/month** (scales as users grow)

---

## 🏁 PHASE 0: PROJECT SETUP

### Prompt 0.1 — Initialize Flutter Project
```
First, ensure you've read all docs in ./Info/ (FINAL_PRD.md, IMPLEMENTATION_PLAN.md, PROJECT_CONTEXT.md, UI_UX.md).

Create a new Flutter project called "sathio" in the current directory. Use the following settings:
- Package name: com.sathio.app
- Minimum Android SDK: 21
- Target Android SDK: 34
- Kotlin for Android, Swift for iOS

After creation, set up the folder structure:
- lib/core/ (constants, theme, utils, router)
- lib/features/ (onboarding, auth, home, voice, services, profile)
- lib/shared/ (widgets, models)
- lib/services/ (api, audio, storage, auth)

Add these dependencies to pubspec.yaml:
- flutter_riverpod (state management)
- go_router (navigation)
- supabase_flutter (backend)
- dio (HTTP for external APIs)
- hive_flutter (local storage)
- permission_handler
- record (audio recording)
- just_audio (audio playback)
- flutter_tts
- speech_to_text
- lottie (animations)
- flutter_animate (micro-animations)

Run flutter pub get and verify the project builds.
```

### Prompt 0.2 — Supabase Project Setup
```
Set up Supabase for Sathio:

1. Create lib/core/config/supabase_config.dart:
   - Supabase URL placeholder
   - Supabase anon key placeholder
   - Instructions to get keys from supabase.com

2. Create lib/services/supabase/supabase_service.dart:
   - Initialize Supabase client
   - Singleton pattern
   - Error handling wrapper

3. Update main.dart:
   - Initialize Supabase before runApp
   - Initialize Hive for local storage
   - Handle initialization errors gracefully

4. Create .env.example file:
   - SUPABASE_URL=your-project-url
   - SUPABASE_ANON_KEY=your-anon-key

Add flutter_dotenv to pubspec.yaml for env file loading.
Build and verify no errors.
```

### Prompt 0.3 — Design System Setup
```
Read the UI_UX.md file in ./Info/ and create the complete design system:

1. Create lib/core/theme/colors.dart:
   - Sathio Teal: #00BFA5
   - Saffron Orange: #FF9800
   - Deep Blue: #1E3A5F
   - All gray scale (50-900)
   - Success (#4CAF50), Error (#E53935), Warning (#FFC107)
   - Dark mode variants

2. Create lib/core/theme/typography.dart:
   - Use Noto Sans as primary font (supports Devanagari, Tamil, Bengali)
   - Implement full type scale: displayLarge, headlineMedium, bodyLarge, etc.
   - Support scalable fonts (use sp units)

3. Create lib/core/theme/spacing.dart:
   - Spacing tokens: xs(4), sm(8), md(16), lg(24), xl(32), xxl(48)
   - Border radius: sm(4), md(8), lg(16), xl(24), full(9999)

4. Create lib/core/theme/app_theme.dart:
   - Light theme with Material 3
   - Dark theme (complete implementation)
   - Custom color scheme extension

5. Download Noto Sans fonts and add to assets/fonts/
   - Noto Sans regular, medium, semibold, bold
   - Noto Sans Devanagari (for Hindi, Marathi)
   - Noto Sans Tamil
   - Noto Sans Bengali

6. Update pubspec.yaml with font assets

Build and verify theme applies correctly.
```

### Prompt 0.4 — Core Constants & Config
```
Create configuration files:

1. lib/core/constants/app_constants.dart:
   - App name: "Sathio"
   - Tagline: "Main hoon na"
   - Supported languages: ['hi', 'bn', 'ta', 'mr']
   - Language names: {'hi': 'हिंदी', 'bn': 'বাংলা', 'ta': 'தமிழ்', 'mr': 'मराठी'}
   - Max recording duration: 60 seconds
   - API timeout: 30 seconds

2. lib/core/constants/asset_paths.dart:
   - Paths for images, icons, audio, lottie animations

3. lib/core/utils/extensions.dart:
   - Context extensions for theme, colors, spacing
   - String extensions for formatting
   - DateTime extensions for display

4. Create assets/ folder structure:
   - assets/images/
   - assets/icons/
   - assets/audio/
   - assets/lottie/ (for animations)
   - assets/fonts/
   
5. Update pubspec.yaml to include all asset folders.

Build and verify no errors.
```

---

## 🔐 PHASE 1: AUTHENTICATION

### Prompt 1.1 — Auth Service
```
Create authentication using Supabase Auth:

1. lib/services/auth/auth_service.dart:
   - Singleton or Riverpod provider
   - Methods:
     - signInAnonymously() - for guest users
     - signInWithPhone(phoneNumber) - sends OTP
     - verifyOtp(phone, otp) - verifies and signs in
     - signInWithGoogle() - social login
     - signOut()
     - getCurrentUser()
     - isAuthenticated()
   - Handle auth state changes with stream
   - Store session in secure storage

2. lib/services/auth/auth_state.dart:
   - AuthState class with: loading, authenticated, unauthenticated, error
   - User model with: id, phone, name, language, createdAt

3. lib/services/auth/auth_provider.dart:
   - Riverpod providers for auth state
   - AuthNotifier for state management

4. Error handling:
   - Invalid OTP message
   - Network error handling
   - Rate limiting awareness

Test with a simple auth test screen.
```

### Prompt 1.2 — Phone OTP Flow UI
```
Create phone authentication screens:

1. lib/features/auth/screens/phone_input_screen.dart:
   - Clean, minimal design matching UI_UX.md
   - Phone input with +91 prefix (India)
   - Large numeric keyboard friendly input
   - "Continue" button (disabled until valid phone)
   - "Continue as Guest" link below
   - Privacy text: "Aapka number safe hai"

2. lib/features/auth/screens/otp_verification_screen.dart:
   - 6-digit OTP input (individual boxes)
   - Auto-focus and auto-advance
   - Timer for resend (60 seconds)
   - "Resend OTP" link after timer
   - Auto-submit when 6 digits entered
   - Loading state while verifying
   - Error state with friendly message

3. lib/features/auth/widgets/phone_input_field.dart:
   - Custom phone input with country code
   - Validation (10 digits for India)
   - Format display: XXX-XXX-XXXX

4. lib/features/auth/widgets/otp_input.dart:
   - 6 individual boxes
   - Handles paste
   - Delete goes to previous box

Style everything per UI_UX.md (Teal primary, large touch targets).
```

---

## 🎓 PHASE 2: DUOLINGO-STYLE ONBOARDING

### Prompt 2.1 — Onboarding Flow Design
```
Create a Duolingo-inspired onboarding experience:

Reference: Duolingo's onboarding is famous for being:
- Progressive (one thing at a time)
- Visual (icons, illustrations, animations)
- Interactive (user makes choices, not just reading)
- Encouraging (positive feedback at each step)

Design the flow:
1. Welcome → 2. Language Selection → 3. What brings you here? → 4. Voice Demo → 5. Permission → 6. Quick Win → 7. Profile Setup (optional)

Create lib/features/onboarding/onboarding_flow.dart:
   - List of onboarding steps
   - Progress tracker
   - Navigation between steps
   - Skip option (but discouraged)
   
Create lib/features/onboarding/onboarding_provider.dart:
   - Current step index
   - Selections made
   - Complete status
   - Store progress in Hive
```

### Prompt 2.2 — Welcome Screen
```
Create the welcome screen (Step 1):

lib/features/onboarding/screens/welcome_screen.dart:
   - Full screen, off-white background
   - Sathio mascot/logo animation (Lottie or animated)
   - Large friendly text: "Namaste! 🙏"
   - Subtitle: "Main Sathio hoon, aapka digital saathi"
   - Animated illustration of a friendly assistant
   - Primary button: "Shuru karein" (Let's start)
   - Progress dots at bottom (1 of 7)

Add subtle entrance animations:
   - Logo fades in and scales up
   - Text slides up
   - Button bounces in

Use Lottie animation for the mascot if available, otherwise use a simple animated illustration.
```

### Prompt 2.3 — Language Selection (Interactive)
```
Create language selection (Step 2) - Duolingo style:

lib/features/onboarding/screens/language_selection_screen.dart:
   - Header: "Kaunsi bhasha mein baat karein?" (with translation hint)
   - 4 large language cards (not small buttons):
     - Each card: Flag icon + Native script name + English name
     - Hindi: 🇮🇳 हिंदी (Hindi)
     - Bengali: 🇮🇳 বাংলা (Bengali)
     - Tamil: 🇮🇳 தமிழ் (Tamil)
     - Marathi: 🇮🇳 मराठी (Marathi)
   
   - Tap card → plays voice sample: "Main Hindi mein baat kar sakta hoon"
   - Selected card gets teal border + checkmark animation
   - Subtle celebration (confetti or sparkle) on selection
   - Continue button appears after selection
   - Progress dots (2 of 7)

Make it feel like a choice, not a form.
```

### Prompt 2.4 — Use Case Selection
```
Create "What brings you here?" screen (Step 3):

lib/features/onboarding/screens/use_case_screen.dart:
   - Header: "Aap Sathio se kya karna chahte ho?" (in selected language)
   
   - 4-6 tappable cards with icons:
     - 📄 "Sarkari kaam" (Government services) - Aadhaar, PAN, etc.
     - 💡 "Bill payment" (Utilities) - Bijli, mobile, gas
     - 💊 "Health jaankari" (Health info) - Schemes, hospitals
     - 📚 "Padhai mein madad" (Education) - Scholarships
     - 💰 "Loan/Banking" (Financial) - Loans, account
     - ❓ "Kuch aur" (Something else)
   
   - Multiple selection allowed (tap to select/deselect)
   - Visual feedback: selected cards glow/highlight
   - Personalization message: "Main aapke liye ready ho jaunga!"
   - Continue button
   - Progress dots (3 of 7)

This helps personalize the home screen later.
```

### Prompt 2.5 — Voice Demo Screen
```
Create interactive voice demo (Step 4):

lib/features/onboarding/screens/voice_demo_screen.dart:
   - Header: "Dekho main kaise kaam karta hoon"
   
   - Animated demonstration:
     1. Show a sample query appearing: "Aadhaar kaise download karein?"
     2. Show mic listening animation
     3. Show Sathio "thinking"
     4. Show response card with steps
   
   - OR interactive mini-demo:
     - "Mic button dabao aur bolo: Namaste Sathio"
     - User taps and says it
     - Sathio responds: "Namaste! Main sun sakta hoon. Bahut badhiya!"
     - Celebration animation 🎉
   
   - Skip option: "Baad mein try karunga"
   - Continue button
   - Progress dots (4 of 7)

This builds confidence before first real use.
```

### Prompt 2.6 — Permission Screen
```
Create permission request screen (Step 5):

lib/features/onboarding/screens/permission_screen.dart:
   - Header: "Kuch permissions chahiye"
   
   - Permission cards (one at a time or all together):
     - 🎤 Microphone: "Aapki awaaz sunne ke liye" 
       - Required badge
     - 🔔 Notifications: "Important updates ke liye"
       - Optional badge
     - 📍 Location: "Aapke state ki schemes dikhane ke liye"
       - Optional badge
   
   - Each permission has:
     - Icon
     - Why we need it (simple explanation)
     - Allow button
     - Visual confirmation when granted (checkmark)
   
   - Handle denial gracefully
   - Progress dots (5 of 7)
   
Use permission_handler package for actual permission requests.
```

### Prompt 2.7 — Quick Win Screen
```
Create the "Quick Win" experience (Step 6):

lib/features/onboarding/screens/quick_win_screen.dart:
   - Header: "Chalo ek choti si madad karte hain!"
   
   - Present a simple, satisfying task:
     - "Aaj ka mausam jaano" (weather)
     - OR "Emergency numbers dekho"
     - OR "Aadhaar helpline number"
   
   - User taps → instant useful result
   - Big celebration: "Dekha! Kitna aasan tha!"
   - Gamification: "Aapne pehla task complete kiya! 🌟"
   
   - This is crucial: User feels success before they even start
   - Continue button: "Ab asli kaam shuru karein"
   - Progress dots (6 of 7)
```

### Prompt 2.8 — Profile Setup (Optional)
```
Create optional profile setup (Step 7):

lib/features/onboarding/screens/profile_setup_screen.dart:
   - Header: "Thoda apne baare mein batao (optional)"
   
   - Simple form:
     - Name input: "Aapka naam" (optional)
     - State dropdown: "Aap kahan rehte ho?" (for state-specific schemes)
     - District dropdown: (appears after state selection)
   
   - Benefits shown: "State select karne se local schemes dikhengi"
   
   - Two buttons:
     - "Save karein" (Primary)
     - "Baad mein" (Skip - takes to home)
   
   - Progress dots (7 of 7, completed!)
   
   - After completion: Navigate to Home with welcome back message
```

### Prompt 2.9 — Onboarding Complete Animation
```
Create completion celebration:

lib/features/onboarding/screens/onboarding_complete_screen.dart:
   - Full screen celebration
   - Confetti animation (Lottie)
   - Sathio mascot happy animation
   - Text: "Badhai ho! Ab aap ready ho! 🎉"
   - Subtitle: "Jab bhi madad chahiye, main yahan hoon"
   
   - Auto-dismiss after 3 seconds → Home screen
   - OR tap anywhere to proceed immediately
   
   - Store onboarding_complete = true in Hive
   - Never show onboarding again for this user
```

---

## 🎨 PHASE 3: SHARED WIDGETS

### Prompt 3.1 — Primary Button Components
```
Create reusable button components based on UI_UX.md specs:

1. lib/shared/widgets/buttons/primary_button.dart:
   - Height: 56dp, full rounded corners (28dp radius)
   - Teal background (#00BFA5), white text
   - Loading state with circular spinner
   - Disabled state (gray #BDBDBD)
   - Haptic feedback on press
   - onPressed callback, child widget, isLoading, isEnabled

2. lib/shared/widgets/buttons/secondary_button.dart:
   - Outlined variant, 2dp teal border
   - Transparent background
   - Teal text

3. lib/shared/widgets/buttons/text_button_custom.dart:
   - No background, just teal text
   - For "Skip", "Later" actions

4. lib/shared/widgets/buttons/icon_button_circular.dart:
   - 48x48dp circle
   - Icon centered
   - Optional label below

5. lib/shared/widgets/buttons/mic_button.dart:
   - Large 72x72dp circular button
   - Teal background with white mic icon (36x36)
   - Three states: 
     - idle: subtle pulse animation
     - listening: animated waveform inside + glow
     - processing: spinning indicator
   - Use AnimationController for pulse
   - Shadow elevation 8dp

Export all from lib/shared/widgets/buttons/buttons.dart
```

### Prompt 3.2 — Card Components
```
Create card components per UI_UX.md:

1. lib/shared/widgets/cards/service_card.dart:
   - 16dp corner radius, white background
   - Subtle shadow (elevation 2)
   - Padding 16dp
   - Content: Icon (48x48 centered) + Title + optional Subtitle
   - Full card tappable with ripple
   - Props: icon, title, subtitle, onTap, isSelected

2. lib/shared/widgets/cards/step_card.dart:
   - For guided mode steps
   - 12dp corner radius
   - Light tinted background (#FAFAFA)
   - Active state: 4dp teal left border
   - Step number badge (24dp teal circle with white number)
   - Instruction text (Body Large)
   - Play button (secondary, right-aligned)
   - Props: stepNumber, instruction, isActive, onPlay

3. lib/shared/widgets/cards/response_card.dart:
   - Bot response display
   - Avatar on left (40dp)
   - Text content in bubble
   - Play/pause button for TTS
   - Speed toggle row (0.75x | 1x | 1.25x)
   - Timestamp (optional)

4. lib/shared/widgets/cards/info_card.dart:
   - For FAQs, tips
   - Expandable (tap to show/hide content)
   - Icon + title + expand arrow

Export all from lib/shared/widgets/cards/cards.dart
```

### Prompt 3.3 — Feedback & Loading Components
```
Create feedback widgets:

1. lib/shared/widgets/feedback/loading_waveform.dart:
   - Animated waveform (5 bars)
   - Bars animate up/down at different phases
   - Teal color
   - Optional text below ("Samajh raha hoon...")
   - Size variants: small, medium, large

2. lib/shared/widgets/feedback/success_animation.dart:
   - Green checkmark with scale + bounce animation
   - Optional confetti background
   - Text below: customizable
   - Auto-plays on widget mount

3. lib/shared/widgets/feedback/error_state.dart:
   - Amber warning icon (48dp)
   - Friendly error text
   - Retry button (primary)
   - Optional close button

4. lib/shared/widgets/feedback/empty_state.dart:
   - Illustration/icon
   - Message text
   - Optional action button

5. lib/shared/widgets/feedback/app_snackbar.dart:
   - Helper to show snackbars
   - Dark background (#212121), white text
   - 4 second auto-dismiss
   - Optional action button (teal text)
   - Position: bottom, 16dp margin

Export all from lib/shared/widgets/feedback/feedback.dart
```

### Prompt 3.4 — Navigation Components  
```
Create navigation components:

1. lib/shared/widgets/navigation/bottom_nav_bar.dart:
   - 4 items: Home, History, Profile, Help
   - Icons: home, history, person, help_outline (Material)
   - Active: Teal icon + label
   - Inactive: Gray icon + label
   - 64dp height
   - Slight elevation/shadow
   - Haptic feedback on tap
   - AnimatedContainer for selection indicator

2. lib/shared/widgets/navigation/top_app_bar.dart:
   - Height: 56dp
   - Optional back arrow (left)
   - Title (center, H2 style)
   - Optional action icons (right)
   - Transparent or white background option
   - Props: title, showBack, actions, onBack

3. lib/shared/widgets/navigation/language_pill.dart:
   - Small tappable pill showing current language
   - Flag + language code (e.g., 🇮🇳 HI)
   - Tap opens language change dialog

4. lib/shared/widgets/navigation/progress_dots.dart:
   - Row of dots for onboarding
   - Current dot: teal, larger
   - Other dots: gray, smaller
   - Animated transitions

Export all from lib/shared/widgets/navigation/navigation.dart

Create lib/shared/widgets/widgets.dart that exports all widget categories.
```

---

## 🗣️ PHASE 4: VOICE SERVICES

### Prompt 4.1 — Audio Recording Service
```
Create audio recording service:

1. lib/services/audio/audio_recorder_service.dart:
   - Uses record package
   - Riverpod provider (not singleton)
   - Methods:
     - startRecording() - returns void, stores path internally
     - stopRecording() - returns audio file path
     - cancelRecording() - deletes temp file
     - isRecording - getter
   - Features:
     - Max duration: 60 seconds with auto-stop
     - Emits recording state stream (idle, recording, stopped)
     - Handle permissions internally (request if needed)
     - Save to app's temp directory

2. lib/services/audio/audio_player_service.dart:
   - Uses just_audio package
   - Methods:
     - play(String source) - URL or file path
     - pause()
     - stop()
     - setSpeed(double speed) - 0.75, 1.0, 1.25
     - seek(Duration position)
   - Streams:
     - playerState (playing, paused, stopped)
     - position
     - duration
   - Support both local files and remote URLs

3. lib/services/audio/audio_providers.dart:
   - Riverpod providers for both services

Create a debug screen to test record → playback cycle.
```

### Prompt 4.2 — Speech Services
```
Create speech service layer:

1. lib/services/speech/stt_service.dart:
   - Abstract interface:
     - Future<TranscriptionResult> transcribe(String audioPath, String language)
   - TranscriptionResult: text, confidence, language

2. lib/services/speech/tts_service.dart:
   - Abstract interface:
     - Future<void> speak(String text, String language, {double speed})
     - Future<void> stop()
     - Stream<TtsState> get stateStream

3. lib/services/speech/local_tts_service.dart:
   - Implementation using flutter_tts
   - Configure for Indian languages
   - Speed control support
   - Fallback for offline mode

4. lib/services/speech/bhashini_service.dart:
   - Implementation for Bhashini APIs
   - ASR endpoint configuration
   - TTS endpoint configuration
   - Handle API errors gracefully
   - Fallback to local TTS if Bhashini fails

5. lib/services/speech/speech_providers.dart:
   - Riverpod providers
   - Environment-based selection (mock, local, bhashini)

For now, implement local_tts_service fully. Bhashini can be added later.
```

### Prompt 4.3 — Voice Interaction Manager
```
Create the main voice interaction controller:

1. lib/services/voice/voice_state.dart:
   - VoiceState sealed class or enum with:
     - idle - ready to listen
     - listening - recording audio
     - processing - transcribing + getting response
     - speaking - playing TTS response
     - error - something went wrong
   - Each state can carry relevant data

2. lib/services/voice/voice_interaction_manager.dart:
   - StateNotifier<VoiceState> or AsyncNotifier
   - Orchestrates the full flow:
     1. startListening() → recording starts
     2. stopListening() → stop recording, start processing
     3. Process: transcribe audio → send to backend → get response
     4. speakResponse() → TTS output
     5. Return to idle
   
   - Methods:
     - startListening()
     - stopListening()
     - cancelListening()
     - speakResponse(String text)
     - retry()
   
   - Callbacks/Events:
     - onTranscriptionComplete(String text)
     - onResponseReady(BotResponse response)
     - onError(String message)

3. lib/services/voice/voice_providers.dart:
   - VoiceInteractionManagerProvider

Test with a debug screen that shows all state transitions.
```

---

## 🏠 PHASE 5: CORE SCREENS

### Prompt 5.1 — Splash Screen
```
Create splash screen:

1. lib/features/splash/splash_screen.dart:
   - Off-white background (#F5F5F5)
   - Centered Sathio logo (use placeholder icon or simple Image)
   - Size: 120x120dp
   - "Sathio" text below (H1, Deep Blue)
   - Tagline "Main hoon na" below (Body, gray)
   - Subtle loading indicator at very bottom
   
   Logic:
   - Initialize services (Supabase, Hive)
   - Check auth state
   - Check onboarding status
   
   Navigation:
   - If not onboarded → /onboarding
   - If onboarded but not authenticated → /auth (or skip if guest mode)
   - If authenticated → /home
   
   Duration: 2-3 seconds minimum for branding

2. Add to router as initial route ("/")
```

### Prompt 5.2 — Home Screen
```
Create the main home screen:

1. lib/features/home/home_screen.dart:
   Layout (from top to bottom):
   - Top bar: LanguagePill (left), Settings icon (right)
   - Hero section (center):
     - Sathio avatar/icon (80x80dp)
     - Greeting: "Namaste [Name]! Batao, kya madad chahiye?"
     - (Use user's name if available, otherwise just "Namaste!")
   - Primary CTA: Large MicButton (72x72dp) centered
   - Label below mic: "Tap karke bolo"
   - Quick access grid (2x2):
     - ServiceCard: Government services (📄)
     - ServiceCard: Bill payments (💡)
     - ServiceCard: Health info (💊)
     - ServiceCard: Education (📚)
   - Bottom: BottomNavBar

2. lib/features/home/home_provider.dart:
   - User's language preference
   - User's name
   - Quick access cards data (personalized from onboarding)
   - Recent/suggested actions

3. Tap mic → show ListeningOverlay
4. Tap service card → navigate to service
5. Bottom nav works (other screens can be placeholders)
```

### Prompt 5.3 — Listening Overlay
```
Create the listening overlay:

1. lib/features/voice/widgets/listening_overlay.dart:
   - ModalBottomSheet or full Overlay
   - Semi-transparent dark background
   - Center content:
     - Large animated mic icon (96x96dp)
     - Pulsing glow when listening
     - Animated waveform below mic
     - Text: "Sun raha hoon..."
     - Timer: "0:05 / 1:00"
   - Cancel button (X) in top-right corner
   
   States:
   - listening: waveform active, mic glowing
   - processing: waveform stops, show loading spinner, text changes to "Samajh raha hoon..."

2. lib/features/voice/voice_overlay_controller.dart:
   - Show/hide logic
   - Connect to VoiceInteractionManager
   
3. Integration:
   - Tap mic on home → show overlay → start recording
   - Overlay connects to VoiceInteractionManager state
   - When processing complete → close overlay → show response
```

### Prompt 5.4 — Response Screen
```
Create the response display:

1. lib/features/voice/response_screen.dart:
   - TopAppBar: Back button, context title (e.g., "Aadhaar")
   - Sathio avatar with subtle animation (listening pose)
   - ResponseCard:
     - Text content (Body Large)
     - Play button to replay audio
     - Speed toggle (0.75x | 1x | 1.25x)
   - If has steps → show "Detailed steps dekhein" link
   - Action area:
     - If actionable: "Aage badhein" (Primary), "Repeat" (Secondary)
     - If conversational: just show mic button for follow-up
   - Bottom: Floating mic button for follow-up questions

2. lib/features/voice/response_provider.dart:
   - Current response data
   - TTS playback state
   - Selected speed

3. Auto-play TTS when screen opens (user preference setting)

4. Follow-up: tap mic → back to listening overlay → new response
```

---

## 📋 PHASE 6: SERVICE FEATURES

### Prompt 6.1 — Services List Screen
```
Create government services browsing:

1. lib/features/services/services_screen.dart:
   - TopAppBar: Back, title "Sarkari Seva"
   - Category chips/tabs (horizontal scroll):
     - All, Identity, Subsidies, Healthcare, Education
   - List of ServiceCards with:
     - Icon
     - Service name (in user's language)
     - Brief description
   - Filter by category
   - Voice search hint: "Ya bolein jo dhundna hai"

2. lib/features/services/services_provider.dart:
   - List of all services
   - Selected category filter
   - Search query

3. lib/features/services/models/service_model.dart:
   - id, title, description, icon, category
   - steps: List<GuideStep>

4. Service data (hardcoded for MVP):
   - Aadhaar download
   - Aadhaar update
   - PAN card apply
   - PM-Kisan registration
   - PM-Kisan status check
   - Ration card apply
   - Ayushman Bharat card
   - State pension check

5. Tap service → guided mode screen
```

### Prompt 6.2 — Guided Mode Screen
```
Create step-by-step guidance:

1. lib/features/guided/guided_screen.dart:
   - TopAppBar: Back, "Step 2 of 5", Close (X)
   - Linear progress bar (% complete)
   - Current step card (StepCard):
     - Step number badge
     - Instruction text
     - Play button (plays audio instruction)
     - Optional visual (screenshot/illustration)
   - "Open website" button if step has URL
   - Navigation row:
     - "← Pichla" (Previous, secondary)
     - "Aagla →" (Next, primary, prominent)
   - Bottom bar:
     - "Pause karein" button
     - "Insaan se baat karein" button (Talk to Human)

2. lib/features/guided/guided_provider.dart:
   - Service data
   - Current step index
   - Methods: next(), previous(), pause(), resume()
   - Elapsed time tracking

3. lib/features/guided/models/guide_step.dart:
   - stepNumber, instruction, audioUrl (optional)
   - visualHint (image path or URL)
   - actionUrl (external website to open)
   - isCompleted

4. Create detailed steps for "Aadhaar Download" (5-6 steps as example)
```

### Prompt 6.3 — Task Complete Screen
```
Create success celebration:

1. lib/features/guided/task_complete_screen.dart:
   - Background: light with subtle confetti animation (Lottie)
   - SuccessAnimation widget (green checkmark, scale bounce)
   - Large text: "Ho gaya! 🎉" (H1)
   - Specific message: "Aapka Aadhaar download complete!"
   - Summary card:
     - Service name
     - Time taken
     - Steps completed
   - Action buttons:
     - "Naya task shuru karein" (Primary) → services list
     - "Home jaayein" (Secondary) → home screen
   - Rating section:
     - "Kaisa raha experience?"
     - 👎 (Sad) | 😐 (Okay) | 👍 (Good)
   - Save completed task to history

2. Navigate here when last step is completed in guided mode
```

---

## 👤 PHASE 7: USER FEATURES

### Prompt 7.1 — Profile Screen
```
Create user profile:

1. lib/features/profile/profile_screen.dart:
   - Avatar (can use initials if no photo)
   - Name (editable)
   - Phone number (if authenticated)
   - Language preference (tappable → opens picker)
   
   - Settings sections:
     - Voice Settings:
       - Speed slider (0.75x - 1.25x)
       - Volume preview button
     - Notifications:
       - Toggle: Daily tips
       - Toggle: Scheme updates
       - Toggle: Task reminders
     - Privacy:
       - Clear history button
       - Delete account button (⚠️ with confirmation)
   
   - Links:
     - Help & Support → Help screen
     - Rate App → Play Store
     - Share App
     - About Sathio

2. lib/features/profile/profile_provider.dart:
   - User data from Supabase
   - Local preferences from Hive
   - Save changes to both

3. Connect from bottom nav "Profile" tab
```

### Prompt 7.2 — History Screen
```
Create query history:

1. lib/features/history/history_screen.dart:
   - TopAppBar: "Meri History"
   - Grouped by date: "Aaj", "Kal", "Is Hafta", etc.
   - Each item:
     - Query text (truncated)
     - Service icon or type indicator
     - Timestamp
     - Status: ✓ Complete | ⏸ Incomplete
   - Tap item → view details or resume
   - Empty state: illustration + "Abhi tak kuch nahi kiya"

2. lib/features/history/history_provider.dart:
   - Load from local storage (Hive) or Supabase
   - Add new entries after each query
   - Filter: All, Completed, Incomplete
   - Limit to last 30 days

3. lib/features/history/models/history_item.dart:
   - id, query, response, serviceName
   - timestamp, isCompleted
   - Optional: lastStepIndex (for resume)

4. Connect from bottom nav "History" tab
```

### Prompt 7.3 — Help Screen
```
Create help and support:

1. lib/features/help/help_screen.dart:
   - TopAppBar: "Madad"
   
   - Quick actions:
     - Voice help: "Bolein: 'Mujhe madad chahiye'"
   
   - FAQ section (expandable):
     - "Sathio kya hai?"
     - "Kya ye free hai?"
     - "Mera data safe hai?"
     - "Offline kaam karta hai?"
     - (8-10 FAQs total)
   
   - Contact section:
     - "Talk to Human" button (premium feature indicator)
     - WhatsApp support link
     - Email support link
   
   - Emergency numbers card:
     - Police: 100
     - Ambulance: 108
     - Women Helpline: 1091
     - Child Helpline: 1098

2. lib/features/help/help_provider.dart:
   - FAQ data (localized)

3. Connect from bottom nav "Help" tab and home screen
```

---

## 💾 PHASE 8: DATABASE SETUP

### Prompt 8.1 — Supabase Tables
```
Create Supabase database schema:

Provide SQL migrations for these tables:

1. users table:
   - id (UUID, primary key, references auth.users)
   - phone (text, unique)
   - name (text, nullable)
   - language (text, default 'hi')
   - state (text, nullable)
   - district (text, nullable)
   - onboarding_complete (boolean, default false)
   - created_at (timestamp)
   - updated_at (timestamp)

2. query_history table:
   - id (UUID, primary key)
   - user_id (UUID, references users)
   - query_text (text)
   - intent (text)
   - response_summary (text)
   - service_id (text, nullable)
   - is_completed (boolean)
   - language (text)
   - created_at (timestamp)

3. user_preferences table:
   - user_id (UUID, primary key, references users)
   - voice_speed (float, default 1.0)
   - notify_daily_tips (boolean, default true)
   - notify_scheme_updates (boolean, default true)
   - notify_task_reminders (boolean, default true)
   - updated_at (timestamp)

4. services table (read-only, admin managed):
   - id (text, primary key)
   - title_hi (text)
   - title_bn (text)
   - title_ta (text)
   - title_mr (text)
   - description_hi (text)
   - description_bn (text)
   - description_ta (text)
   - description_mr (text)
   - category (text)
   - icon (text)
   - is_active (boolean)
   - priority (int)
   - created_at (timestamp)

5. service_steps table:
   - id (UUID, primary key)
   - service_id (text, references services)
   - step_number (int)
   - instruction_hi (text)
   - instruction_bn (text)
   - instruction_ta (text)
   - instruction_mr (text)
   - audio_url (text, nullable)
   - visual_hint_url (text, nullable)
   - action_url (text, nullable)

Create appropriate indexes and RLS policies:
- Users can only read/write their own data
- Services and steps are readable by all authenticated users
```

### Prompt 8.2 — Repository Layer
```
Create repository pattern for data access:

1. lib/services/database/repositories/user_repository.dart:
   - createUser(User user)
   - updateUser(User user)
   - getUser(String id)
   - deleteUser(String id)
   - Use Supabase client
   - Handle errors

2. lib/services/database/repositories/history_repository.dart:
   - addQuery(QueryHistoryItem item)
   - getHistory(String userId, {int limit, DateTime since})
   - updateQueryCompletion(String id, bool isCompleted)
   - clearHistory(String userId)

3. lib/services/database/repositories/preferences_repository.dart:
   - getPreferences(String userId)
   - updatePreferences(UserPreferences prefs)
   - Reset to defaults

4. lib/services/database/repositories/services_repository.dart:
   - getAllServices(String language)
   - getServiceById(String id, String language)
   - getServiceSteps(String serviceId, String language)

5. lib/services/database/database_providers.dart:
   - Riverpod providers for all repositories

Create models for each entity in lib/shared/models/
```

### Prompt 8.3 — Offline Sync
```
Create offline-first data layer:

1. lib/services/storage/offline_cache.dart:
   - Cache services and steps locally (Hive)
   - Cache FAQs locally
   - Sync when online
   - Timestamp for freshness
   - Max cache age: 7 days

2. lib/services/storage/sync_service.dart:
   - detectConnectivity()
   - syncPendingChanges()
   - fetchLatestServices()
   - Queue for offline writes

3. lib/services/database/offline_repository.dart:
   - Wrapper that checks online status
   - Returns cached data if offline
   - Syncs when back online

4. Update repositories to use offline layer

5. Show subtle indicator when offline:
   - "Offline mode" chip on home screen
   - Reduced functionality message
```

---

## 🔗 PHASE 9: NAVIGATION & FLOW

### Prompt 9.1 — Router Setup
```
Set up complete navigation with go_router:

1. lib/core/router/app_router.dart:
   Define all routes:
   - / (splash)
   - /onboarding (onboarding flow)
   - /onboarding/welcome
   - /onboarding/language
   - /onboarding/usecase
   - /onboarding/voice-demo
   - /onboarding/permissions
   - /onboarding/quick-win
   - /onboarding/profile
   - /onboarding/complete
   - /auth (auth flow)
   - /auth/phone
   - /auth/otp
   - /home
   - /services
   - /services/:id
   - /services/:id/guide
   - /services/:id/complete
   - /history
   - /history/:id
   - /profile
   - /profile/edit
   - /settings
   - /help

   Redirect logic:
   - If not onboarded → /onboarding
   - If onboarded but not authenticated → /home (guest mode OK)
   - Shell route for bottom nav screens

2. lib/core/router/route_names.dart:
   - Constants for all route names

3. lib/core/router/route_guards.dart:
   - Auth guard
   - Onboarding guard

4. Update main.dart to use MaterialApp.router
```

### Prompt 9.2 — Deep Links & App Links
```
Configure deep linking:

1. Android setup (android/app/src/main/AndroidManifest.xml):
   - Intent filter for sathio://
   - Intent filter for https://app.sathio.in/

2. Update go_router to handle deep links:
   - sathio://service/aadhaar-download → /services/aadhaar-download
   - sathio://profile → /profile
   - https://app.sathio.in/service/pm-kisan → /services/pm-kisan

3. Create assetlinks.json for Android App Links (placeholder)

4. Test navigation flow end-to-end:
   - Splash → Onboarding (7 steps) → Home
   - Home → Tap mic → Listening → Processing → Response
   - Home → Tap service → Guided mode → Complete → Home
   - All bottom nav tabs work
```

---

## 🧪 PHASE 10: POLISH & TESTING

### Prompt 10.1 — Micro-Animations
```
Add polish animations using flutter_animate:

1. Screen transitions:
   - Slide from right for push navigation
   - Fade for modals and overlays
   - Scale up for dialogs

2. Microphone button:
   - Idle: gentle pulse every 2s (scale 1.0 → 1.05 → 1.0)
   - Listening: glow effect + faster pulse
   - Processing: rotation animation

3. Cards:
   - Enter animation: fade + slide up with stagger
   - Tap: slight scale down (0.98) then up
   - Selection: border color transition

4. Success celebrations:
   - Checkmark: scale 0 → 1.2 → 1.0 with bounce
   - Text: fade in after checkmark
   - Confetti: Lottie animation overlay

5. Loading states:
   - Skeleton screens instead of spinners
   - Shimmer effect on loading cards

Keep all animations under 300ms for responsiveness.
Test on low-end device to ensure no jank.
```

### Prompt 10.2 — Error Handling & Edge Cases
```
Implement comprehensive error handling:

1. Network errors:
   - Detect offline state
   - Show friendly message: "Internet nahi hai. Offline mode mein ho."
   - Retry button where applicable
   - Queue writes for later sync

2. Voice errors:
   - Mic permission denied: Guide to settings with illustration
   - No speech detected: "Kuch sunai nahi diya. Phirse bolo?"
   - Transcription confidence low: "Dhyan se suna nahi. Repeat karo?"
   - TTS failed: Show text and skip audio

3. Auth errors:
   - Invalid OTP: "Galat code. Phirse daalo."
   - Too many attempts: "Bahut baar try kiya. 5 minute baad try karo."
   - Session expired: Gentle re-auth prompt

4. API errors:
   - Generic: "Kuch gadbad hui. Thodi der baad try karo."
   - Service specific: More helpful message

5. Global error handler:
   - Catch all unhandled errors in main.dart
   - Log to console (and optionally Sentry)
   - Show user-friendly dialog
   - Never show stack traces to users

6. Empty states:
   - No history: "Abhi tak kuch nahi kiya. Shuru karein?"
   - No services found: "Kuch nahi mila. Filter badlo."
   - No network: Offline mode illustration
```

### Prompt 10.3 — Accessibility Audit
```
Ensure full accessibility:

1. Semantics:
   - Add Semantics widget to all buttons, cards, icons
   - Meaningful labels for screen readers
   - Announce state changes (loading, success, error)

2. Touch targets:
   - Verify minimum 48x48dp for all interactive elements
   - Add invisible hit area if visual is smaller

3. Text scaling:
   - Test with system font at 200%
   - Ensure no clipping or overflow
   - Use flexible layouts

4. Color:
   - Verify 4.5:1 contrast for all text
   - Don't rely on color alone (add icons/text)
   - Test with color blindness simulator

5. Focus:
   - Logical tab order
   - Visible focus indicators
   - Focus trapping in modals

6. Screen reader testing:
   - Test complete flows with TalkBack
   - Ensure all content is announced
   - Fix any missing labels
```

### Prompt 10.4 — Performance Optimization
```
Optimize for low-end devices (2GB RAM):

1. Images:
   - Use WebP format where possible
   - Appropriate sizes (don't load 1000px image for 100px display)
   - Lazy loading with placeholders

2. Lists:
   - Use ListView.builder (not ListView)
   - Reasonable item extents
   - Pagination for long lists

3. Audio:
   - Compress audio files
   - Stream remote audio (don't pre-load)
   - Release player when not in use

4. Memory:
   - Dispose all controllers in dispose()
   - Avoid holding large objects in state
   - Use weak references where appropriate

5. Build:
   - Run flutter analyze --fatal-infos
   - Fix all warnings and infos
   - Run flutter build apk --analyze-size
   - Target APK size: under 40MB

6. Startup:
   - Defer non-critical initialization
   - Show splash immediately
   - Lazy load features
   - Target cold start: under 3 seconds
```

---

## 🚀 PHASE 11: BUILD & RELEASE

### Prompt 11.1 — Build Configuration
```
Configure production builds:

1. Android signing:
   - Generate keystore: keytool -genkey -v -keystore sathio-release.keystore -alias sathio -keyalg RSA -keysize 2048 -validity 10000
   - Create key.properties (git-ignored)
   - Configure android/app/build.gradle for release signing

2. App icons:
   - Use flutter_launcher_icons package
   - Create 1024x1024 icon (Sathio cat/mascot)
   - Generate all sizes

3. Splash screen:
   - Use flutter_native_splash package
   - Configure for teal background with white logo
   - Generate native splash

4. Build flavors:
   - dev: Mock API, debug logging, localhost
   - staging: Test Supabase, staging Bhashini
   - prod: Production everything
   - Configure different package names, app names

5. Version:
   - Set 1.0.0+1 in pubspec.yaml
   - Document versioning strategy in README

6. ProGuard rules (android/app/proguard-rules.pro):
   - Keep Supabase classes
   - Keep audio classes
```

### Prompt 11.2 — Generate Release Build
```
Build and verify release:

1. Clean build:
   flutter clean
   flutter pub get

2. Build release APK:
   flutter build apk --release --flavor prod

3. Build app bundle:
   flutter build appbundle --release --flavor prod

4. Verify:
   - Install APK on physical device
   - Test complete flow: splash → onboarding → auth → home → voice → services
   - Check APK size (target: <40MB)
   - Measure cold start time (target: <3s)
   - Test on 2GB RAM device if possible

5. Note build outputs:
   - APK: build/app/outputs/flutter-apk/
   - Bundle: build/app/outputs/bundle/

6. Update README with build instructions
```

---

## 📝 USAGE TIPS

### Before Your First Session
1. Run Prompt 0.0 (Context Loading) - ALWAYS do this first
2. Make sure Flutter is installed and configured
3. Have Supabase project ready (or create during setup)
4. Have Android device/emulator ready

### During Development
- After each prompt, **verify the build works**: `flutter run`
- If something breaks, ask: "The last change broke the build. Can you fix it?"
- Use "Continue" if the agent stops mid-task
- Keep FINAL_PRD.md, UI_UX.md open for reference

### Testing Checkpoints
- **After Phase 3:** All shared widgets render without errors
- **After Phase 5:** Core navigation works (splash → onboarding → home)
- **After Phase 7:** Complete user flows work with mock data
- **After Phase 10:** App is polished and handles errors gracefully
- **After Phase 11:** Release APK installs and runs on device

### If You Get Stuck
```
The [feature] isn't working. Please:
1. Show me the error
2. Explain what's wrong
3. Fix it
4. Verify the fix works
```

---

## 🔧 QUICK FIX PROMPTS

### Fix Build Errors
```
The Flutter build is failing. Please:
1. Run flutter analyze and show all errors
2. Fix each error one by one
3. Run flutter build apk and verify it works
4. Show me what was fixed
```

### Fix State Management
```
The [screen/feature] state isn't updating correctly. Please:
1. Review the Riverpod provider
2. Check the state transitions
3. Add debug logging if needed
4. Fix the issue and explain the fix
```

### Test a Complete Flow
```
Test the complete [feature] flow:
1. Start from [starting point]
2. Go through each step
3. Verify each screen renders correctly
4. Check state updates properly
5. Report any issues found and fix them
```

### Add Missing Feature
```
We're missing [feature] from the PRD. Please:
1. Review FINAL_PRD.md for the requirement
2. Check UI_UX.md for the design
3. Implement it following our existing patterns
4. Add appropriate tests
```

---

**Total Prompts:** ~40 prompts across 11 phases  
**Estimated Time:** 15-20 hours of focused vibe coding  
**Result:** Production-ready Sathio MVP

---

**Happy Vibe Coding! 🚀**
