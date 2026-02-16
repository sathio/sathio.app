# SATHIO — VIBE CODING PROMPTS

**Purpose:** Step-by-step prompts optimized for Google Antigravity IDE  
**Usage:** Copy each prompt, paste into the agent, wait for completion, then continue to next prompt  
**Tip:** Each prompt is self-contained. If something breaks, re-run that prompt or the previous one.

---

## ⚠️ CRITICAL: START EVERY SESSION WITH THIS PROMPT

### Prompt 0.0 — Context Loading (ALWAYS RUN FIRST)
```
Before we start building, please thoroughly analyze these documentation files in the ./Info/ folder:

1. Read FINAL_PRD.md - Complete product requirements, features, LAM architecture, monetization, user personas
2. Read IMPLEMENTATION_PLAN.md - Technical architecture, LAM engine design, tech stack, development phases
3. Read PROJECT_CONTEXT.md - Brand philosophy, voice design, team values
4. Read OLD_UI_UX.md and UI_UX.md - Design system, colors, typography, components, screens
5. Read PRD1, PRD2, PRD3, PRD4, PRD5 and FINAL_PRD

After reading all files, confirm you understand:
- What Sathio is (a Large Action Model / LAM that autonomously controls the user's phone to complete any digital task via voice commands in their native language)
- That Sathio is NOT just a chatbot or guide — it ACTS. It opens apps, fills forms, navigates websites, makes payments, downloads documents — all autonomously
- Target users (farmers, shopkeepers, seniors, migrants who currently rely on cyber cafes)
- Core LAM capabilities (Android Accessibility Service for device control, Vision-Language Model for screen reading, Action Planner for task decomposition, Slot Filling for conversational data collection)
- Safety systems (floating overlay, kill switch, confirmation before payments, action blacklist)
- Design language (Teal + Orange, Noto Sans, icon-heavy, 48dp touch targets)
- Technical stack (Flutter, FastAPI, Supabase, Bhashini APIs, Gemini/VLM)

Say "I've analyzed all documentation and I'm ready to build Sathio — the phone-controlling AI agent" when done.

IMPORTANT — Keep this in mind throughout ALL development:

Sathio = Vernacular AI + Device Control + Task Automation (LAM) + Human-like Guidance

It is ChatGPT + Alexa + Auto Form Filler + Phone Operator + Digital Cybercafe Assistant + Local Language Human Guide — all in one app.

Sathio doesn't just respond. It executes actions on device. It interacts with apps, reads screens, fills fields, clicks buttons, and handles entire workflows.

| It doesn't just... | It actually... |
|---------------------|----------------|
| Answer questions | Acts on the answer — opens the site, fills the form, downloads the result |
| Guide the user | Does it for the user — while explaining each step in their language |
| Understand language | Controls the phone — taps, types, scrolls, navigates across apps |
| Provide information | Completes the task — books tickets, pays bills, shops, researches |

Sathio is not just a language assistant. It is a Voice-First Local Action Model (LAM) for Bharat. It doesn't just answer. It acts.
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
| **Push Notifications** | Firebase FCM | Free |
| **Analytics** | Supabase + Mixpanel | Free tier |

#### AI & Voice APIs

| Layer | Primary (Free) | Premium Alternative | Offline Fallback |
|-------|---------------|---------------------|-----------------|
| **STT (Speech-to-Text)** | Bhashini ASR API | Sarvam AI ASR | speech_to_text (Flutter) |
| **TTS (Text-to-Speech)** | Bhashini TTS | Sarvam AI TTS (human-like) | flutter_tts (on-device) |
| **Language Detection** | Bhashini Language ID | Sarvam AI | User preference |
| **Translation** | Bhashini NMT | Sarvam Translate | - |
| **Intent Classification** | Gemini 1.5 Flash | - | DistilBERT |
| **Action Planning (LAM)** | Gemini 1.5 Pro | GPT-4o | - |
| **Indian Context LLM** | Sarvam-2B | Gemini Flash | - |
| **Screen Reading (Vision)** | Gemini 1.5 Pro Vision | GPT-4o Vision | - |
| **OCR** | Google ML Kit (on-device) | Gemini Vision | Works offline |
| **Device Control** | Android Accessibility Service | - | Built-in, free |

> **Note:** Bhashini (free, govt, 22 languages) vs Sarvam AI (human-like voice, paid) — decision pending.
> Build with service abstraction layer so voice provider can be swapped easily.

#### API Cost Estimate

| Service | Free Tier | At Scale |
|---------|-----------|----------|
| Bhashini | ✅ Always free | ₹0 |
| Sarvam AI | ✅ Limited free | ~₹2,000-5,000/mo |
| Gemini | ✅ Generous free | ~₹2,000-4,000/mo |
| Supabase | ✅ Free tier | ~₹1,500/mo |
| Firebase FCM | ✅ Always free | ₹0 |
| **Total MVP** | **₹0** | **~₹5,000-10,000/mo** |

**Total MVP Cost: ₹0** (all free tiers, scales as users grow)

### 🗺️ When to Use Each API (Phase → API Mapping)

This section tells you WHICH API is used in WHICH prompt. Use this as a reference whenever building a feature.

| API / Service | Used In Phase | Prompt Numbers | Purpose |
|---------------|---------------|----------------|---------|
| **Supabase Auth** | Phase 0, 1 | 0.2, 1.1, 1.2 | Phone OTP, Google login, guest auth, session management |
| **Supabase Database** | Phase 8 | 8.1, 8.2, 8.3 | User profiles, FAQs, service data, audit logs |
| **Supabase Storage** | Phase 4, 7 | 4.1, 7.2 | Audio file uploads, profile photo storage |
| **Hive (Local)** | Phase 0, 2, 4.5 | 0.4, 2.1, 4.5.2 | Onboarding state, language preference, offline cache |
| **Bhashini ASR** | Phase 4 | 4.2 (bhashini_service) | Speech-to-text in 22 Indian languages (FREE) |
| **Bhashini TTS** | Phase 4 | 4.2 (bhashini_service) | Text-to-speech in Indian languages (FREE) |
| **Bhashini NMT** | Phase 4 | 4.2 (bhashini_service) | Language translation between Indian languages |
| **Bhashini Language ID** | Phase 4.5 | 4.5.1 | Auto-detect spoken language |
| **Sarvam AI ASR** | Phase 4 | 4.2 (sarvam_service) | Premium speech recognition (human-like accuracy) |
| **Sarvam AI TTS** | Phase 4 | 4.2 (sarvam_service) | Premium human-like voice synthesis |
| **Sarvam-2B** | Phase 6 | 6.1, 6.2 | Indian context LLM for understanding local queries |
| **Gemini 1.5 Flash** | Phase 4, 6 | 4.3, 6.1 | Intent classification, quick responses |
| **Gemini 1.5 Pro** | Phase 6.5 | 6.5.3 | Action planning (LAM), task decomposition |
| **Gemini 1.5 Pro Vision** | Phase 6.5 | 6.5.2, 6.5.3 | Screen reading, UI element identification |
| **Google ML Kit OCR** | Phase 6.5 | 6.5.2 | On-device text extraction from screenshots |
| **Android Accessibility** | Phase 6.5 | 6.5.1, 6.5.2 | Device control — tap, type, scroll, navigate |
| **flutter_tts (Local)** | Phase 4 | 4.2 (local_tts_service) | Offline TTS fallback when no internet |
| **speech_to_text (Local)** | Phase 4.5 | 4.5.2 | Offline STT using on-device recognition |
| **Firebase FCM** | Phase 7 | 7.3 | Push notifications |
| **dio (HTTP)** | All API phases | 4.2, 6.1, 6.5.3 | HTTP client for all external API calls |

> **Decision Rule:** Default to Bhashini (free) for voice. Switch to Sarvam if budget allows (better quality). Use Gemini Flash for speed, Pro for complex reasoning/LAM.

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
- speech_to_text
- lottie (animations)
- flutter_animate (micro-animations)
- url_launcher (for deep links)
- android_intent_plus (for launching apps)

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

### Prompt 0.3 — Design System Setup (Luma-Inspired)
```
Read the UI_UX.md file in ./Info/ and create the complete Luma-inspired design system:

DESIGN REFERENCE: Luma iOS app — clean, minimal, premium, dark-mode-first.
Logo: Orange gradient squircle with white circle and 4-pointed sparkle star.

1. Create lib/core/theme/colors.dart:
   - PRIMARY: Sathio Orange (#F58220), Orange Light (#F7A94B), Orange Deep (#E06B10)
   - DARK THEME (default):
     - Background: #0D0D0D (near-black)
     - Surface: #1A1A1A (cards, modals)
     - Surface Elevated: #252525 (hover states)
     - Border: #2A2A2A (subtle dividers)
     - Text Primary: #FFFFFF
     - Text Secondary: #A0A0A0
     - Text Tertiary: #666666
   - LIGHT THEME:
     - Background: #FAFAFA
     - Surface: #FFFFFF
     - Border: #E8E8E8
     - Text Primary: #111111
     - Text Secondary: #666666
   - SEMANTIC: Success (#22C55E), Error (#EF4444), Info (#3B82F6), Warning (#F59E0B)

2. Create lib/core/theme/typography.dart:
   - Primary font: Inter (Google Fonts) — clean, modern, geometric
   - Fallback: Outfit (Google Fonts)
   - Indian scripts: Noto Sans Devanagari, Tamil, Bengali, Telugu, Kannada, Gujarati, Gurmukhi, Malayalam, Oriya
   - Type scale:
     - Display: 36px Bold
     - H1: 28px Bold
     - H2: 22px SemiBold
     - H3: 18px SemiBold
     - Body Large: 16px Medium
     - Body: 14px Regular
     - Button: 14px SemiBold
     - Caption: 12px Regular
     - Overline: 10px SemiBold

3. Create lib/core/theme/spacing.dart:
   - Spacing tokens: xs(4), sm(8), md(16), lg(24), xl(32), 2xl(48)
   - Border radius: sm(8), md(12), lg(16), xl(24), pill(100)

4. Create lib/core/theme/app_theme.dart:
   - DARK theme as DEFAULT (Luma-inspired)
   - Light theme as alternative
   - Material 3 with custom ColorScheme
   - Orange as seed color
   - Custom extension for surface/border colors
   - System toggle + manual override (saved to Hive)

5. Download fonts and add to assets/fonts/:
   - Inter: regular, medium, semibold, bold
   - Noto Sans Devanagari, Tamil, Bengali, Telugu, Kannada, Gujarati, Gurmukhi, Malayalam, Oriya

6. Update pubspec.yaml with font assets

7. Add Phosphor Icons package (for modern icon style alongside Material Icons)

Build and verify dark theme applies correctly with orange accents.
```

### Prompt 0.4 — Core Constants & Config
```
Create configuration files:

1. lib/core/constants/app_constants.dart:
   - App name: "Sathio"
   - Tagline: "Main hoon na"
   - Supported languages (ALL Indian languages, phased):
     - Phase 1 (MVP): ['hi', 'bn', 'ta', 'mr']
     - Phase 2: ['te', 'kn', 'gu', 'pa']
     - Phase 3: ['ml', 'or', 'as', 'ur']
     - Phase 4: All 22 scheduled languages
   - Language names map: {'hi': 'हिंदी', 'bn': 'বাংলা', 'ta': 'தமிழ்', 'mr': 'मराठी', 'te': 'తెలుగు', 'kn': 'ಕನ್ನಡ', 'gu': 'ગુજરાતી', 'pa': 'ਪੰਜਾਬੀ', 'ml': 'മലയാളം', 'or': 'ଓଡ଼ିଆ', 'as': 'অসমীয়া', 'ur': 'اردو'}
   - Auto-detect enabled: true (Bhashini language ID API)
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

### Prompt 0.5 — India Data Constants
```
Create India location data constants:

1. Read Info/INDIA_STATES_DISTRICTS.md first. It contains the full list of 36 States/UTs and 700+ districts.

2. Create lib/core/constants/india_data.dart:
   - Create a constant Map<String, List<String>> indiaStatesDistricts.
   - COPY the entire data structure from INDIA_STATES_DISTRICTS.md into this map.
   - Create helper method: List<String> getStates() => sort alphabetically.
   - Create helper method: List<String> getDistricts(String state).
   - Create helper method: List<String> searchLocation(String query) -> returns matching "District, State" strings.

3. Verify the map is complete and syntax is correct.
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

## 🎓 PHASE 2: LUMA-STYLE ONBOARDING

> **Design Reference:** Luma iOS onboarding flow
> https://mobbin.com/flows/24035767-44e2-4688-8869-e891996fabc2
>
> **Key Design Patterns from Luma:**
> - Light pastel gradient welcome screen (NOT dark mode — onboarding is warm & inviting)
> - Floating 3D icons/emoji orbiting around a central sparkle symbol
> - White bottom sheet slides up for auth (stacked pill buttons)
> - Clean, minimal form screens with lots of whitespace
> - Black pill buttons (premium feel) — NOT orange during onboarding
> - Small gray icons as section identifiers (chat bubble, phone, camera)
> - "Skip for now" as text links
> - Simple back arrow (no circle, no background)
> - Number pad / keyboard auto-opens on input screens

### Prompt 2.0 — Splash Screen (Launch Animation)
```
Create the splash/launch screen:

lib/features/onboarding/screens/splash_screen.dart:

DESIGN — Premium, Minimal, Luma-inspired:
   - Background: Pure White (#FFFFFF)
   - Center: Sathio Sparkle Logo (80x80dp)
     - Gradient: Orange (#F58220) to Light Orange (#F7A94B)
     - Animation: 
       1. Scale up from 0 to 1 (spring, 600ms)
       2. Subtle rotation (-10° to 10°, loop)
   - Text (below logo): "sathio"
     - Font: Inter Bold, 24px, #111111, tracking 1.2
     - Animation: Fade in + Slide up (delay 400ms, duration 600ms)

LOGIC & ROUTING:
   - Wait 2 seconds (min duration for branding)
   - Check Hive/Supabase for auth state
   
   IMPORTANT: Since Home and Onboarding screens might not exist yet:
   1. Create valid placeholder widgets in the same file or a temporary file:
      - `class HomeScreen extends StatelessWidget { ... }` (Placeholder)
      - `class OnboardingScreen extends StatelessWidget { ... }` (Placeholder)
   2. Setup navigation to use these placeholders for now.
   3. We will implement the REAL screens in Prompt 2.1 and 3.1.
   
   - If logged in → Go to Home
   - If not logged in → Go to Onboarding
   - Use simple FadeTransition for route replacement
```

### Prompt 2.1 — Onboarding Flow Design
```
Create a Luma-inspired onboarding experience:

Reference: Luma's onboarding is famous for being:
- Clean (lots of whitespace, minimal elements)
- Light + Premium (pastel gradients, NOT dark mode)
- Bottom-sheet auth (slides up over illustration)
- Progressive (one input per screen)
- Skippable (but encouraged to complete)

Design the flow:
1. Welcome (hero illustration) → 2. Get Started (bottom sheet auth) → 3. Phone/OTP → 4. Language Selection → 5. Profile Setup → 6. Interest Selection → 7. Home

Create lib/features/onboarding/onboarding_flow.dart:
   - PageView-based navigation (no AppBar — just back arrow icon)
   - Smooth slide transitions between screens
   - No progress dots (Luma doesn't use them — keeps it clean)
   - Skip options on non-critical screens
   
Create lib/features/onboarding/onboarding_provider.dart:
   - Current step index
   - Selections made (language, interests)
   - Auth state (phone, Google, guest)
   - Complete status
   - Store progress in Hive
```

### Prompt 2.2 — Welcome Screen (Luma Hero)
```
Create the welcome/hero screen (Step 1):

lib/features/onboarding/screens/welcome_screen.dart:

DESIGN — Exactly like Luma's welcome screen:

   Background:
   - Soft pastel gradient (light pink-blue-cream, subtle — NOT dark)
   - Example: LinearGradient from #F8F0FF (top-left) → #E8F4FD (center) → #FFF8F0 (bottom-right)
   - Very subtle, barely noticeable gradient

   Hero Illustration (center, upper 60% of screen):
   - Central element: Sathio sparkle logo (4-pointed star, orange gradient)
     - Size: 80x80dp
     - Sits in center of a series of concentric light gray circles
   - Floating 3D icons orbiting around the sparkle (like planets around sun):
     - 📱 Phone icon (representing phone control)
     - 🏛️ Government building (sarkari seva)
     - 💡 Lightbulb (bill payment)
     - 🎤 Microphone (voice interaction)
     - 💊 Health cross (health info)
     - 📚 Book (education)
     - Use 3D emoji-style or Lottie animated icons
     - Each floating in a soft colored circle (pastel purple, blue, green, etc.)
     - Subtle floating animation (slow up/down drift, 3-4s loop)
   - Concentric orbit circles: very light gray (#E8E8E8, 1px stroke)

   Text section (below illustration):
   - Logo: "sathio" in lowercase with sparkle icon (like Luma's "luma✦")
     - Font: Inter Bold, 20px, dark gray #333333
   - Headline: "Your Digital Companion"
     - Font: Inter Bold, 28px, #111111
   - Subheadline: "Start Your Journey Here" 
     - Font: Inter SemiBold, 22px, orange #F58220

   Bottom:
   - "Get Started" button
     - Full-width pill (24px side padding)
     - Background: #111111 (near-black — like Luma, NOT orange)
     - Text: White, Inter SemiBold, 16px
     - Height: 56dp
     - Corner radius: 100px (pill)
     - Shadow: subtle
   - Safe area padding at bottom

Animations:
   - Background gradient: subtle slow shift (15s loop)
   - Floating icons: gentle drift animation (staggered start)
   - Sparkle: subtle pulse/glow
   - Text: fade in sequence (logo → headline → subheadline, 200ms each)
   - Button: slides up from below (300ms, ease-out)
```

### Prompt 2.3 — Auth Bottom Sheet (Luma-Style)
```
Create the auth bottom sheet (Step 2):

lib/features/onboarding/screens/auth_bottom_sheet.dart:

DESIGN — Exactly like Luma's "Get Started" bottom sheet:

When user taps "Get Started" on welcome screen:
   - The welcome illustration stays visible (slightly blurred/dimmed)
   - A WHITE bottom sheet slides up from bottom
   - Spring animation (bouncy, 400ms)

Bottom Sheet contents:
   - Top-left: Sathio sparkle icon (small, 40x40dp, gray #999999)
   - Top-right: Close "X" button (gray, subtle)
   
   - Title: "Let's Get Started"
     - Font: Inter Bold, 24px, #111111
   
   - Description: "Sathio handles your digital tasks. Sign in to begin."
     - Font: Inter Regular, 14px, #666666
     - Max 2 lines
   
   - Auth buttons (stacked, full-width pills):
     1. "Continue with Phone" 
        - Background: #111111 (black pill)
        - Text: White
        - Icon: Phone icon (left)
        - Height: 52dp
     
     2. "Continue with Google"
        - Background: #F5F5F5 (light gray)
        - Border: 1px #E0E0E0
        - Text: #333333
        - Icon: Google "G" icon (left)
        - Height: 52dp
     
     3. "Continue as Guest"
        - No background, just text link
        - Color: #666666
        - Font: Inter Medium, 14px
   
   - Bottom spacing: safe area + 16dp
   
   Sheet styling:
   - Background: #FFFFFF
   - Corner radius: 24px (top corners only)
   - Handle bar: 40x4dp centered, #D0D0D0, top 12dp
   - Shadow: 0 -4px 20px rgba(0,0,0,0.1)

Tap "Continue with Phone" → navigate to phone input screen
Tap "Continue with Google" → trigger Supabase Google One-Tap
Tap "Continue as Guest" → skip auth, go to language selection  
Tap "X" → dismiss sheet, back to welcome
```

### Prompt 2.4 — Phone Number Input (Luma-Style)
```
Create phone number input screen (Step 3a):

lib/features/onboarding/screens/phone_input_screen.dart:

DESIGN — Exactly like Luma's "Add Your Phone" screen:

   Background: White / very light gray (#FAFAFA)
   
   Top: Simple back arrow (←) top-left, no circle, no background
     - Icon: arrow_back, 24dp, #111111
     - Padding: 16dp from left, 12dp from top
   
   Section icon: Small gray phone icon (40x40dp)
     - Background: #F5F5F5 circle
     - Icon: phone outlined, #666666
     - Position: below back arrow, left-aligned, 24dp padding
   
   Title: "Enter Your Number"
     - Font: Inter Bold, 24px, #111111
     - Below icon, left-aligned
   
   Description: "We'll send a code for verification"
     - Font: Inter Regular, 14px, #666666
     - 1 line, below title
   
   Phone input:
     - Full-width, left-aligned text
     - "+91 " prefix (fixed, gray)
     - Input: large text, 22px, Inter Medium, #111111
     - No visible border — just bottom line or very subtle container
     - Background: #F5F5F5 rounded (16px radius)
     - Padding: 16dp
     - Auto-focus, keyboard opens immediately (number pad)
   
   Skip option: "Skip for now" text link
     - Font: Inter Medium, 14px, #666666
     - Below input, left-aligned
   
   Bottom: "Next" button
     - Full-width pill, black (#111111)
     - Text: White, "Next"
     - Height: 56dp
     - Positioned above keyboard
     - Disabled state (gray) until 10 digits entered
     - Enabled: #111111 background

Number pad: Use system keyboard (phone type)
```

### Prompt 2.5 — OTP Verification (Luma-Style)
```
Create OTP verification screen (Step 3b):

lib/features/onboarding/screens/otp_screen.dart:

DESIGN — Exactly like Luma's "Enter Code" screen:

   Background: White / #FAFAFA
   
   Top: Back arrow (←) same style as phone screen
   
   Section icon: Small gray chat bubble icon (40x40dp)
     - Background: #F5F5F5 circle
     - Icon: chat_bubble_outline, #666666
   
   Title: "Verify Code"
     - Inter Bold, 24px, #111111
   
   Description: "Code sent to +91 98XXXXX23"
     - Inter Regular, 14px, #666666
   
   OTP boxes: 6 individual digit boxes in a row
     - Each box: 48x56dp
     - Background: #F5F5F5
     - Border radius: 12px
     - Text: Inter Bold, 28px, #111111 — centered
     - Gap between boxes: 8dp
     - Active box: subtle border (#D0D0D0)
     - Filled box: shows digit clearly
     - Empty: shows thin dash or cursor placeholder
     
     Behavior:
     - Auto-focus first empty box
     - Auto-advance to next box on digit entry
     - Delete goes to previous box
     - Supports paste (all 6 digits at once)
     - Auto-submit when all 6 filled
   
   Resend: "Resend Code (30s)" timer link below OTP
     - Disabled for 30 seconds (gray)
     - After 30s: clickable, orange text #F58220
   
   Bottom: "Next" button
     - Same style as phone screen (black pill)
     - Disabled until all 6 digits
     - Loading state when verifying
   
   Number pad: system keyboard (number type)
```

### Prompt 2.6 — Language Selection (Sathio Custom)
```
Create language selection screen (Step 4):

lib/features/onboarding/screens/language_selection_screen.dart:

DESIGN — Clean, Luma-inspired but Sathio-specific:

   Background: White / #FAFAFA
   
   Top: Back arrow
   
   Section icon: Globe/language icon (40x40dp, gray circle)
   
   Title: "Choose Your Language"
     - Inter Bold, 24px, #111111
   
   Description: "Sathio speaks your language"
     - Inter Regular, 14px, #666666
   
   Language grid (3 columns, scrollable):
     Each card:
     - Background: White
     - Border: 1px #E8E8E8
     - Border radius: 16px
     - Padding: 16dp
     - Height: 80dp
     - Content: Native script name (center, Inter SemiBold, 16px)
       - Below: English name (12px, #999999)
     
     Selection state:
     - Border: 2px solid #F58220 (orange)
     - Background: #FFF5EB (very subtle orange tint)
     - Checkmark: small orange circle with white check, top-right
     
     Tap: plays voice preview "I can speak in English/Hindi"
   
   Languages MVP (show all, first 4 highlighted):
     - हिंदी (Hindi) ★
     - বাংলা (Bengali) ★
     - தமிழ் (Tamil) ★
     - मराठी (Marathi) ★
     - తెలుగు (Telugu)
     - ಕನ್ನಡ (Kannada)
     - ગુજરાતી (Gujarati)
     - ਪੰਜਾਬੀ (Punjabi)
     - മലയാളം (Malayalam)
   
   ★ = MVP supported with voice, others = text-only initially
   
   Bottom: "Continue" button (black pill, enabled after selection)

Single selection only. Selection saved to Hive + provider.
```

### Prompt 2.7 — Profile Setup Luma Style (Avatar & Location)
```
Create profile setup screen (Step 5):

DESIGN — Exactly like Luma's "Your Profile" screen:

1. Read UI_UX.md Section 6.7 (Avatar System) and Section 6.2 (Inputs).
2. Read lib/core/constants/india_data.dart (created in Prompt 0.5).

3. Create lib/features/onboarding/widgets/avatar_selector.dart:
   - 80x80dp circular avatar display
   - If image selected: show image
   - If no image: show one of the 12 preset avatars (by index 1-12)
   - Camera badge (bottom-right)
   - On tap: Open modal bottom sheet
     - "Choose Avatar" grid (12 SVG/PNG assets from UI_UX.md)
     - "Take Photo" option (camera/gallery)
     - Highlighting selected avatar (orange border)

4. Create lib/features/onboarding/screens/profile_setup_screen.dart:
   - Luma-style pastel gradient header (top 25%)
   - White content area (bottom 75%)
   
   Items:
   - Avatar Selector (centered, overlapping header/body)
   - Title: "Create Your Profile"
   - Description: "Tell us a bit about yourself"
   
   Form:
   - Name Input (Underline style, label: "Your Name")
   - State Dropdown (Searchable, label: "Your State")
   - District Dropdown (appears ONLY after state selected, populated from getDistricts(state))
     - Both dropdowns use Luma styling (minimal, clean)
   
   - "Continue" button (Black pill)
   - "Do this later" (Skip) link

5. Logic:
   - Randomly assign an avatar index (1-12) on init
   - Save selection to OnboardingProvider (avatarIndex, name, state, district)
   - Persist to Hive box 'user_profile'
   - Sync to Supabase 'profiles' table (if auth exists)

Build and verify the avatar grid and state-district dependency works.
```

### Prompt 2.8 — Interest Selection
```
Create interest/use-case selection screen (Step 6):

lib/features/onboarding/screens/interest_screen.dart:

DESIGN — Clean card grid:

   Background: White / #FAFAFA
   Top: Back arrow
   
   Title: "How can we help you?"
     - Inter Bold, 22px, #111111
   
   Description: "We'll personalize your experience"
     - Inter Regular, 14px, #666666
   
   Interest cards (2 columns, scrollable):
     Each card:
     - Background: White
     - Border: 1px #E8E8E8
     - Border radius: 16px
     - Padding: 16dp
     - Height: auto (icon + text)
     - Content:
       - Emoji/icon: 32x32dp, centered top
       - Title: Inter SemiBold, 14px, #111111, center
     
     Cards:
     - 🏛️ Govt Schemes
     - 💡 Bill Payment
     - 🏥 Health Info
     - 📚 Education
     - 🛒 Shopping Help
     - 📱 Phone Tasks
     - 💰 Banking/Loan
     - ❓ Something Else
     
     Selection: orange border (2px #F58220) + subtle orange bg (#FFF5EB)
     Multi-select allowed
   
   Bottom: "Let's Go" button (black pill)
     - Enabled regardless of selection
     - If nothing selected → still proceeds (default all categories)

Navigation: After "Let's Go" → Navigate to Home (onboarding complete).
Request mic + notification permissions on Home screen first launch instead.
Store onboarding_complete = true in Hive. Never show onboarding again.
```

---

## 🎨 PHASE 3: SHARED WIDGETS

### Prompt 3.1 — Primary Button Components
```
Create reusable button components based on UI_UX.md specs:

1. lib/shared/widgets/buttons/primary_button.dart:
   - Height: 56dp, pill shape (radius 100px)
   - Default: Near-black background (#111111), white text (for onboarding)
   - Variant: Orange gradient background (#F58220 → #F7A94B), white text (for main app)
   - Loading state with circular spinner (white)
   - Disabled state (gray #CCCCCC bg, #999999 text)
   - Press animation: scale 0.97 (100ms)
   - Haptic feedback on press
   - Props: onPressed, child, isLoading, isEnabled, variant (dark/orange)

2. lib/shared/widgets/buttons/secondary_button.dart:
   - Outlined variant, 1px border (#E0E0E0 light / #2A2A2A dark)
   - Background: #F5F5F5 (light) / #1A1A1A (dark)
   - Text: #333333 (light) / white (dark)
   - Pill shape

3. lib/shared/widgets/buttons/text_button_custom.dart:
   - No background, just text
   - Color: #666666 (default) or #F58220 (orange variant)
   - For "Skip for now", "Later" actions

4. lib/shared/widgets/buttons/icon_button_circular.dart:
   - 48x48dp circle
   - Background: transparent or #F5F5F5
   - Icon centered (24dp)
   - Optional label below

5. lib/shared/widgets/buttons/mic_button.dart:
   - Large 64x64dp circular button
   - Orange gradient background (#F58220 → #F7A94B) with white mic icon (28x28)
   - Three states: 
     - idle: subtle breathing pulse animation (orange glow)
     - listening: animated waveform inside + glow intensifies
     - processing: three bouncing dots
   - Shadow: 0 4px 16px rgba(245, 130, 32, 0.3)

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
   - Light tinted background (#F5F5F5)
   - Active state: 3dp orange left border (#F58220)
   - Step number badge (24dp orange circle with white number)
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

5. lib/shared/widgets/cards/agent_action_card.dart:
   - Visualizes Agentic Actions (LAM)
   - "Sathio is working..." style
   - Animated progress indicator (linear or circular)
   - Icon representing current action (e.g., touch icon for click, keyboard for typing)
   - Action description text ("Logging in to portal...")
   - "Stop" button to interrupt

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

### Prompt 3.5 — Animation System Setup
```
Create Sathio's animation utilities based on UI_UX.md Section 8.

Read UI_UX.md Section 8 first — it has the COMPLETE animation spec.

1. lib/core/animations/page_transitions.dart:
   - Custom GoRouter page transition builder
   - Default forward: SharedAxisTransition (vertical) — 300ms, easeOutCubic
   - Back: reverse — 250ms, easeInCubic
   - Modal: scale 0.9→1.0 + fade — 250ms, easeOutBack
   - Root change: FadeTransition — 200ms
   - Container transform for card→detail (use `animations` package OpenContainer)
   - ALL transitions respect reduced motion (instant if disabled)

2. lib/core/animations/stagger_helpers.dart:
   - Extension on List\<Widget\> for staggered list animations using flutter_animate:
     ```
     children.staggerIn(interval: 100.ms)
     // Each child: fadeIn(300ms) + slideY(begin: 0.15, end: 0, duration: 400ms)
     ```
   - Home screen greeting typewriter effect
   - Interest card grid stagger (2-column aware)
   - Onboarding welcome sequence (exact timing from UI_UX.md 8.2)

3. lib/shared/widgets/animations/card_tap_effect.dart:
   - Wrap any card with tap animation:
     - Press: scaleXY → 0.97, 100ms, easeIn
     - Release: scaleXY → 1.0, 150ms, easeOutBack
   - Selection animation: orange border fadeIn (200ms) + checkmark scale (300ms, spring)
   - Chip tap: scale 0.95, orange bg slide-in from left

4. lib/shared/widgets/animations/skeleton_shimmer.dart:
   - Reusable shimmer placeholder for loading states
   - Dark mode: gradient #1A1A1A → #2A2A2A → #1A1A1A
   - Light mode: gradient #E8E8E8 → #F5F5F5 → #E8E8E8
   - Variants: SkeletonCard, SkeletonText, SkeletonAvatar, SkeletonList

5. lib/shared/widgets/animations/mic_button_animations.dart:
   - Idle: breathing orange glow (radius 8→16→8, opacity 0.3→0.5, 2s loop)
   - Tap: scale 1.0→1.15→1.0 + haptic
   - Listening: 5 orange bars height = audio amplitude (60fps)
   - Processing: bars collapse → 3 bouncing dots (staggered 150ms)
   - Error: translateX shake [-8, 8, -6, 6, -3, 0] + red flash

6. lib/core/animations/reduced_motion.dart:
   - Helper to check MediaQuery.of(context).disableAnimations
   - Wrapper: AnimateIf(reducedMotion: false, child, animation)
   - When reduced motion ON: all durations = 0, fades only, no parallax

Add `animations` package to pubspec.yaml (for OpenContainer).

Build and verify animation utilities don't break existing code.
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
   - Implementation for Bhashini APIs (FREE, 22 languages)
   - ASR endpoint configuration
   - TTS endpoint configuration
   - Language detection endpoint
   - Handle API errors gracefully
   - Fallback to local TTS if Bhashini fails

4b. lib/services/speech/sarvam_service.dart:
   - Implementation for Sarvam AI APIs (premium, human-like voice)
   - Sarvam ASR: more natural speech recognition
   - Sarvam TTS: human-like, expressive, warm voice
   - Sarvam-2B: Indian context LLM for understanding Indian queries
   - Handle API errors gracefully
   - Fallback to Bhashini if Sarvam fails

5. lib/services/speech/speech_providers.dart:
   - Riverpod providers
   - Environment-based selection (mock, local, bhashini, sarvam)
   - Config flag: USE_SARVAM = false (default to Bhashini — free)
   - Service abstraction: both implement same interface, swappable

IMPORTANT: Build with a VoiceProvider abstraction interface.
Both BhashiniService and SarvamService implement the same interface.
This lets us swap between free (Bhashini) and premium (Sarvam) easily.
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
     - executing_action - performing LAM active task
     - waiting_for_input - slot filling (asking user for data)
     - error - something went wrong
   - Each state can carry relevant data

2. lib/services/voice/voice_interaction_manager.dart:
   - StateNotifier<VoiceState> or AsyncNotifier
   - Orchestrates the full flow:
     1. startListening() → recording starts
     2. stopListening() → stop recording, start processing
     3. Process: 
        a. Detect Language (LanguageManager.autoDetectAndSwitch)
        b. Transcribe (STT)
        c. Intent Classification
     4. IF Intent == Action: Switch to AgentOrchestrator (LAM)
     5. IF Intent == Query: Get response → speakResponse() → TTS in Current Language
     6. Return to idle
   
   - Methods:
     - startListening()
     - stopListening()
     - cancelListening()
     - speakResponse(String text)
     - retry()
   
   - Callbacks/Events:
     - onLanguageChanged(String newLang) // Notify UI to update
     - onTranscriptionComplete(String text)
     - onResponseReady(BotResponse response)
     - onError(String message)

3. lib/services/voice/voice_providers.dart:
   - VoiceInteractionManagerProvider

Test with a debug screen that shows all state transitions.
```

---

## 🌍 PHASE 4.5: LANGUAGE AUTO-DETECT & OFFLINE LITE MODE

### Prompt 4.5.1 — Language Auto-Detection Service
```
Create language auto-detection (Sathio supports ALL Indian languages):

1. lib/services/language/language_detector_service.dart:
   - Uses Bhashini Language Identification API
   - Method: Future<DetectedLanguage> detectLanguage(String audioPath)
   - DetectedLanguage: { code: 'hi', name: 'Hindi', confidence: 0.92 }
   - Falls back to user's saved preference if confidence < 70%
   - Handles code-mixing (Hindi+English, Tamil+English)

2. lib/services/language/language_manager.dart:
   - Manages current active language
   - Methods:
     - setLanguage(String langCode)
     - getLanguage() -> String
     - autoDetectAndSwitch(String audioPath)
     - switchByVoiceCommand(String text) -> handles "Tamil mein baat karo"
   - Saves preference to Hive
   - Supports per-session override (family sharing same phone)
   - Notifies all listeners on language change (TTS, UI, responses)

3. lib/services/language/language_providers.dart:
   - currentLanguageProvider (StateNotifier)
   - languageDetectorProvider

4. Integration with VoiceInteractionManager:
   - On every voice input: detect language → if different from current, switch
   - Show subtle notification: "Hindi mein switch kar diya"
   - No interruption to flow

5. Supported languages (phased):
   - Phase 1: hi, bn, ta, mr
   - Phase 2: te, kn, gu, pa
   - Phase 3: ml, or, as, ur
   - Phase 4: All 22 scheduled Indian languages
```

### Prompt 4.5.2 — Offline Lite Mode
```
Create offline functionality for rural India (works without internet):

1. lib/services/offline/offline_content_manager.dart:
   - Pre-downloads content packs per language
   - Content types:
     - FAQs: Top 200 questions per language (JSON)
     - Scheme info: All major government schemes
     - Document checklists: What documents needed for each service
     - Emergency numbers: National + state-wise
     - Health basics: First aid, vaccination schedules
     - Step-by-step guides: Text versions of all guided flows
   - Storage: Hive boxes organized by language
   - Total size: < 50MB per language

2. lib/services/offline/cached_tts_manager.dart:
   - Pre-cache TTS audio for common responses
   - Cache FAQ answers as audio files
   - Cache emergency info audio
   - Storage: assets/audio/cached/{lang}/
   - Playback without internet

3. lib/services/offline/offline_query_handler.dart:
   - Handles queries when internet is unavailable
   - Searches local FAQ database (fuzzy matching)
   - Returns cached text + audio response
   - Emergency number lookup (always works)
   - Previously completed task history (from Hive)
   - Graceful message: "Internet nahi hai. Par basic jaankari de sakta hoon."

4. lib/services/offline/sync_service.dart:
   - Auto-syncs content when WiFi available
   - Shows "Last updated" timestamp on cached content
   - Queues user requests for when internet returns
   - Downloads new content packs on update

5. lib/services/network/connectivity_service.dart:
   - Monitors internet connectivity
   - Switches between online/offline mode automatically
   - Riverpod provider: connectivityProvider (stream)
   - No user action needed — seamless degradation

6. Integration:
   - VoiceInteractionManager checks connectivity before API calls
   - If offline → route to offline_query_handler
   - If online → normal flow
   - Show subtle indicator in UI: "Offline mode" pill

Build and test: turn off internet, verify FAQ responses still work.
```

---

## 🏠 PHASE 5: CORE SCREENS

### Prompt 5.1 — Splash Screen (Luma-Inspired)
```
Create splash screen with dark, premium feel:

1. lib/features/splash/splash_screen.dart:
   - Background: #0D0D0D (near-black, matches dark theme)
   - Center: Sathio logo (orange squircle with sparkle star)
     - Size: 100x100dp
     - Animation: Fade in (0→1 over 500ms) then scale (0.8→1.0 over 300ms)
   - Below logo: "Sathio" text (H1, white, Inter Bold) — fades in 200ms after logo
   - Below text: "Main hoon na" tagline (#A0A0A0, Inter Regular) — fades in 300ms after title
   - No visible loading indicator (keep it clean)
   
   Logic:
   - Initialize services (Supabase, Hive) during animation
   - Check auth state
   - Check onboarding status
   
   Navigation:
   - If not onboarded → /onboarding
   - If onboarded but not authenticated → /auth (or skip if guest mode)
   - If authenticated → /home
   
   Duration: 2 seconds, then smooth fade-out transition

2. Add to router as initial route ("/")
```

### Prompt 5.2 — Home Screen (Luma-Inspired)
```
Create the main home screen with dark, immersive design (NO bottom tab bar — Luma style):

1. lib/features/home/home_screen.dart:
   Layout (dark background #0D0D0D, full-screen immersive):
   
   - Top bar (minimal):
     - Left: Language pill (e.g., "हिंदी" in small chip, #252525 bg, white text)
       - Tap → Opens Language Selection Dialog (Prompt 2.6)
     - Right: Settings icon (gear, #A0A0A0) + Profile avatar circle
   
   - Greeting section (top area):
     - Time-based greeting: "Subah ka Namaste, [Name]!" / "Shaam ka Namaste!"
     - Text: H1, white, Inter Bold
     - Subtitle: "Kya madad chahiye?" in #A0A0A0
   
   - Search/Voice bar (pill-shaped, full width):
     - Background: #1A1A1A
     - Border: 1px #2A2A2A
     - Radius: pill (100px)
     - Left icon: Search (gray)
     - Placeholder: "Bolein ya type karein..."
     - Right icon: Mic (orange #F58220)
     - Tap anywhere → show ListeningOverlay
   
   - Quick Actions (horizontal scrollable chips):
     - Chips: Aadhaar, Bill Pay, PM-Kisan, Ration Card, Health, Shopping
     - Chip style: #252525 bg, white text, radius 8px, 36dp height
     - Active/tapped: Orange bg, white text
   
   - Recent Activity (card list):
     - Section header: "Recent" in H3, white
     - Cards: #1A1A1A bg, 16px radius, 1px #2A2A2A border
     - Each card: Icon + title + timestamp + status chip
     - Empty state: "Abhi koi activity nahi. Bolke shuru karein!"
   
   - Floating Mic Button (bottom center, always visible):
     - Size: 64x64dp, circular
     - Background: Orange gradient (#F58220 → #F7A94B)
     - Icon: White mic
     - Shadow: 0 4px 16px rgba(245,130,32,0.3)
     - Animation: Subtle breathing pulse (2s loop)
     - Position: 24dp above safe area bottom

2. lib/features/home/home_provider.dart:
   - User's language preference
   - User's name
   - Time-based greeting logic
   - Quick action chips data (personalized from onboarding)
   - Recent activity list

3. Tap floating mic → show ListeningOverlay
4. Tap search bar → show ListeningOverlay
5. Tap language pill → show Language Selection Dialog
6. Tap quick action chip → navigate to service or start agent
6. Tap recent activity card → continue or view history
7. Agentic Trigger:
   - If VoiceIntent is 'Action' (e.g., "Check PM Kisan status")
   - HomeProvider triggers AgentOrchestrator.executeTask()
   - ListeningOverlay closes, AgentOverlay opens
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
   - handing_off: text "Sathio kaam shuru kar raha hai...", fade out -> open AgentOverlay

2. lib/features/voice/voice_overlay_controller.dart:
   - Show/hide logic
   - Connect to VoiceInteractionManager
   - Listen for 'executing_action' state -> close and trigger AgentOverlay
   
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
   - isAutomated: boolean (Supports LAM/Agentic mode)

4. Service data (hardcoded for MVP — ALL tasks are autonomous via LAM):
   - Aadhaar download (isAutomated: true) ← Sathio opens UIDAI, fills form, downloads PDF
   - Aadhaar update (isAutomated: true)
   - PM-Kisan registration (isAutomated: true)
   - PM-Kisan status check (isAutomated: true)
   - PAN card application (isAutomated: true)
   - Ration card apply (isAutomated: true)
   - Ayushman Bharat card (isAutomated: true)
   - State pension check (isAutomated: true)
   - Electricity bill payment (isAutomated: true) ← Cross-app: browser + UPI
   - Mobile recharge (isAutomated: true)
   - Gas cylinder booking (isAutomated: true) ← HP/Indane/Bharat Gas
   - Train ticket booking (isAutomated: true) ← IRCTC multi-step
   - Water bill payment (isAutomated: true) ← Municipal portals
   - Voter ID application (isAutomated: true) ← NVSP Form 6
   - Passport application (isAutomated: true) ← Passport Seva portal
   - Driving license apply/renew (isAutomated: true) ← Sarathi portal
   - Income/Caste/Domicile certificate (isAutomated: true) ← State e-District
   - Scholarship application (isAutomated: true) ← National Scholarship Portal
   - Online shopping (isAutomated: true) ← Amazon/Flipkart/JioMart

5. Tap service → Agent Mode (Sathio does it autonomously)
   - Show AgentOverlay, Sathio starts executing
   - Fallback: manual Guided Mode if user prefers
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
   - "Open website" button if step has URL
   - Navigation row:
     - "← Pichla" (Previous, secondary)
     - "Aagla →" (Next, primary, prominent)
   - Bottom bar:
     - "Pause karein" button
     - "Insaan se baat karein" button (Talk to Human)
   - Floating Action Button (if automated):
     - Label: "Sathio se karwayein" (Do it for me)
     - Icon: Auto_Awesome
     - Tap → Trigger AgentOrchestrator

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

## 🤖 PHASE 6.5: AGENTIC AUTOMATION (LAM)

### Prompt 6.5.1 — Native Accessibility Service
```
Implement the Android Accessibility Service (Native Kotlin):

1. Create android/app/src/main/java/com/sathio/app/services/SathioAccessibilityService.kt:
   - Extend AccessibilityService
   - Override onAccessibilityEvent(event: AccessibilityEvent)
   - Override onInterrupt()
   - Implement capabilities:
     - findNodeByText(text: String): AccessibilityNodeInfo?
     - clickNode(node: AccessibilityNodeInfo)
     - setText(node: AccessibilityNodeInfo, text: String)
     - scroll(direction: Int)

2. Register in AndroidManifest.xml:
   - Service permission: BIND_ACCESSIBILITY_SERVICE
   - Intent filter: android.accessibilityservice.AccessibilityService
   - Meta-data: android.accessibilityservice.accessibility_service_config

3. Create res/xml/accessibility_service_config.xml:
   - description: "@string/accessibility_service_description"
   - accessibilityFeedbackType: feedbackGeneric
   - accessibilityFlags: flagDefault | flagReportViewIds | flagRetrieveInteractiveWindows
   - canRetrieveWindowContent: true
   - canPerformGestures: true

4. Add "Accessibility Permission" check in PermissionHandler
```

### Prompt 6.5.2 — Flutter-Native Bridge
```
Create the bridge between Flutter and Native Accessibility:

1. Native Side (MainActivity.kt):
   - Setup MethodChannel "com.sathio.app/accessibility"
   - Handle methods provided by Flutter:
     - "performAction": arguments { type: "click" | "scroll", text: "Submit" }
     - "readScreen": returns simplified JSON tree of current screen
     - "isServiceEnabled": returns boolean
   
2. Dart Side (lib/services/automation/accessibility_service.dart):
   - AgentService class
   - Methods:
     - Future<bool> isEnabled()
     - Future<void> clickButton(String text)
     - Future<void> inputText(String fieldLabel, String value)
     - Future<String> readScreenContent()

3. Create a debug screen to test:
   - Button "Check Permission"
   - Button "Read Current Screen" (prints to console)
```

### Prompt 6.5.3 — Agent Orchestrator
```
Implement the Intelligence Layer (LAM):

API STACK FOR THIS PROMPT:
- Intent Classification: Gemini 1.5 Flash (fast, cheap)
- Action Planning: Gemini 1.5 Pro (complex reasoning, task decomposition)
- Screen Understanding: Gemini 1.5 Pro Vision (reads screenshots, identifies UI elements)
- Voice I/O: Bhashini ASR/TTS (free) or Sarvam AI (premium)
- Device Control: Android Accessibility Service (on-device, free)
- OCR Fallback: Google ML Kit (on-device, free)

1. lib/features/automation/agent_orchestrator.dart:
   - StateNotifier managing the automation loop
   - State: Idle, Planning, Executing, WaitingForUser, Success, Failed

2. lib/services/ai/gemini_service.dart:
   - Initialize Gemini client with API key from env
   - Methods:
     - classifyIntent(String userText) → uses Gemini 1.5 Flash
       - Returns: {intent: "action" | "query", category: "...", confidence: 0.95}
     - planActions(String goal, String screenContext) → uses Gemini 1.5 Pro
       - System prompt: "You are Sathio's action planner for Indian phone users..."
       - Returns: List<ActionStep> (stepType, target, value, description)
     - readScreen() → MVP: uses Accessibility Service tree (element text/IDs)
       - Reads visible node tree from Accessibility Service
       - Returns: {elements: [...], currentScreen: "...", possibleActions: [...]}
       - [FUTURE]: Gemini Vision screenshot → full visual understanding
       - When element can't be found or captcha appears:
         → Ask user in their native language and wait for input
   - All calls wrapped with dio, retry logic, and timeout (10s)
   - API key from: .env → GEMINI_API_KEY

3. Logic Flow (executeTask method):
   - Input: Goal (e.g., "Check PM Kisan Status")
   - Step 1: classifyIntent(goal) → Gemini Flash confirms it's an "action"
   - Step 2: planActions(goal) → Gemini Pro returns action steps
   - Step 3: Open Target App (android_intent_plus / Launch Intent)
   - Step 4: Loop per step:
     a. readScreen() → Accessibility tree reads visible UI elements
        [FUTURE]: Gemini Vision screenshot for complex screens
     b. Find target element via Accessibility Service
     c. Execute action (click, type, scroll)
     d. Wait for screen change (500ms)
     e. Verify step completed
   - Step 5: If Input Field found with no data:
     - Pause automation (WaitingForUser state)
     - TTS via Bhashini/Sarvam: "Aadhaar number bataiye?"
     - Wait for Voice Input → STT via Bhashini/Sarvam
     - Resume automation with collected data
   - Step 6: Verify final result, report success/failure via TTS

4. Conversational Slot Filling:
   - When data missing, trigger VoiceInteractionManager
   - "Pause Automation" state
   - Resume after user speaks
   - All slot-filling uses Bhashini STT/TTS (or Sarvam if configured)

5. Error Handling:
   - Gemini API failure → retry 2x → show error to user
   - Accessibility node not found → readScreen again → try alternative
   - Timeout (30s per step) → abort and explain
```

### Prompt 6.5.4 — Action Overlay
```
Create the "Sathio is Working" Overlay:

1. lib/features/automation/widgets/agent_overlay.dart:
   - Small floating pill (System Alert Window)
   - Logo animation (Working...)
   - Text: "PM Kisan check kar raha hoon..."
   - "Stop" button (Red X) to kill task immediately

2. Permissions:
   - ACTION_MANAGE_OVERLAY_PERMISSION

3. Integration:
   - Show when executeTask starts
   - Update text at each step ("Clicking Login...", "Filling Aadhaar...")
   - Hide on completion
```

### Prompt 6.5.5 — Dynamic Universal Agent (Handle ANY Task)
```
Implement the Dynamic Agent that handles ANY user request — not just pre-mapped flows.
This is what makes Sathio a universal cyber cafe replacement.

PHILOSOPHY:
- Pre-mapped flows (Phase 6.6) = FAST LANE (known, tested scripts)
- Dynamic Agent = UNIVERSAL LANE (AI figures it out in real-time)
- The Agent Orchestrator (6.5.3) tries pre-mapped first, falls back to dynamic

API STACK:
- Screen Reading [MVP]: Accessibility Service tree (reads element text/IDs natively)
- Screen Reading [FUTURE]: Gemini 1.5 Pro Vision (screenshot → UI understanding)
- Action Planning: Gemini 1.5 Pro (plans multi-step sequences from a single goal)
- Intent + Slot Extraction: Gemini 1.5 Flash (fast intent + entity extraction)
- Device Control: Android Accessibility Service (tap, type, scroll, swipe)
- Voice I/O: Bhashini/Sarvam STT + TTS

MVP RULE: Wherever Gemini Vision would be needed (captcha, complex UI reading),
Sathio asks the USER in their native language for help and waits for input.
Gemini Vision will be integrated in a future update to automate these steps.

1. lib/services/automation/dynamic_agent.dart:

   class DynamicAgent {
     final GeminiService gemini;
     final AccessibilityService accessibility;
     final VoiceInteractionManager voice;

     // Main entry: handle ANY user command
     Future<TaskResult> executeUnknownTask(String userCommand) async {
       // Step 1: Understand what the user wants
       final intent = await gemini.classifyIntent(userCommand);
       // Returns: { action: "send_whatsapp", app: "WhatsApp",
       //            target: "Rahul", message: "Happy Birthday",
       //            confidence: 0.92 }

       // Step 2: Check if pre-mapped flow exists
       final preMapFlow = TaskFlowRegistry.findFlow(intent.action);
       if (preMapFlow != null) {
         return preMapFlow.execute(intent.slots); // FAST LANE
       }

       // Step 3: No pre-mapped flow → DYNAMIC MODE
       return executeDynamic(userCommand, intent);
     }

     Future<TaskResult> executeDynamic(String command, Intent intent) async {
       // Plan actions using Gemini Pro
       final plan = await gemini.planDynamicTask(command);
       // Returns: List<DynamicStep> e.g.:
       // [
       //   { action: "open_app", target: "WhatsApp" },
       //   { action: "search", query: "Rahul" },
       //   { action: "click", target: "Rahul Kumar" },
       //   { action: "type", field: "message", value: "Happy Birthday! 🎂" },
       //   { action: "click", target: "Send" }
       // ]

       // Execute each step with Vision verification
       for (final step in plan.steps) {
         // Take screenshot, send to Gemini Vision
         final screenshot = await accessibility.captureScreen();
         final screenState = await gemini.readScreen(screenshot);

         // Find target element
         final element = screenState.findElement(step.target);

         if (element == null) {
           // AI couldn't find element → re-plan
           final newPlan = await gemini.replan(command, screenState);
           continue;
         }

         // Execute action
         await executeAction(step, element);

         // Narrate in user's language
         await voice.speak(step.narration);

         // Verify success
         await Future.delayed(Duration(milliseconds: 800));
       }
     }
   }

2. GEMINI VISION SYSTEM PROMPT [FUTURE — not in MVP]:
   (For MVP, screen reading uses Accessibility tree text.
    When Sathio encounters something it can't read — captcha,
    image, complex UI — it asks user in their language and waits.)

   """
   You are Sathio's eyes. You are looking at an Android phone screen.

   YOUR JOB: Understand what is on the screen and tell the agent what to do next.

   INPUT: A screenshot of the user's phone screen.
   OUTPUT: JSON describing:
   {
     "current_screen": "WhatsApp chat list",
     "visible_elements": [
       { "type": "button", "text": "Search", "location": "top-right" },
       { "type": "text_field", "text": "", "hint": "Search...", "location": "top" },
       { "type": "list_item", "text": "Rahul Kumar", "location": "row-3" }
     ],
     "suggested_action": {
       "action": "click",
       "target": "Search icon",
       "reason": "Need to search for contact 'Rahul'"
     },
     "page_state": "ready" | "loading" | "error" | "permission_dialog"
   }

   RULES:
   - Be precise about element locations
   - Identify clickable vs non-clickable elements
   - Detect loading states, error messages, popups
   - If you see a permission dialog, report it
   - If you see a captcha, attempt to read it
   - NEVER guess — if unsure, say "uncertain"
   - Identify language of text on screen
   """

3. GEMINI ACTION PLANNER SYSTEM PROMPT:

   """
   You are Sathio's brain. You plan how to complete tasks on an Android phone.

   USER GOAL: {user_command}
   CURRENT SCREEN: {screen_state_json}
   COLLECTED DATA: {slots_collected_so_far}

   YOUR JOB: Return the next 1-3 actions to take.

   OUTPUT FORMAT (JSON):
   {
     "actions": [
       {
         "type": "open_app" | "click" | "type" | "scroll" | "swipe_back" |
                 "wait" | "ask_user" | "take_screenshot" | "open_url",
         "target": "element text or description",
         "value": "text to type (if type action)",
         "narration_hi": "Hindi narration for user",
         "narration_en": "English narration",
         "confidence": 0.95
       }
     ],
     "missing_data": ["phone_number", "message_text"],
     "task_progress": 0.6,
     "is_complete": false,
     "needs_user_input": false
   }

   RULES:
   - Plan maximum 3 steps ahead (screen may change)
   - If data is missing, set needs_user_input=true and list missing_data
   - NEVER enter UPI PIN, bank passwords, or security codes
   - ALWAYS pause before: payments, form submissions, delete actions
   - Ask for confirmation before irreversible actions
   - If stuck for 3 retries, ask user for help
   - Use Hindi narration that sounds natural and friendly
   """

4. SMART INTENT ROUTING (lib/services/automation/intent_router.dart):

   Input: User's voice command (any language)
   Output: Route to correct handler

   ROUTING LOGIC:
   a) Extract intent via Gemini Flash
   b) Check TaskFlowRegistry for pre-mapped flow
      → Match found? → Execute pre-mapped (FAST, reliable)
      → No match? → Continue to dynamic
   c) Determine if task needs:
      - Single app (WhatsApp, YouTube, etc.) → Single-app dynamic
      - Multiple apps (browser + UPI) → Cross-app dynamic
      - Web only (government portal) → Browser automation
      - Information only (no action needed) → Just answer via TTS
   d) Route to appropriate handler

   EXAMPLE ROUTES:
   - "Rahul ko WhatsApp pe msg bhejo" → Dynamic: Open WhatsApp
   - "YouTube pe Arijit Singh laga do" → Dynamic: Open YouTube
   - "Passport ke liye apply karna hai" → Pre-mapped: passport_flow
   - "Mera Aadhaar download karo" → Pre-mapped: aadhaar_download_flow
   - "Kal ka mausam kaisa rahega?" → Info only: Gemini answers + TTS
   - "Flipkart pe shoes dikhao ₹500 tak" → Dynamic: Open Flipkart
   - "Mera phone number change karo Jio mein" → Dynamic: Open MyJio
   - "Instagram pe photo upload karo" → Dynamic: Open Instagram
   - "Essay likh do plastic pollution pe" → Info: Gemini writes + TTS
   - "Alarm laga do subah 6 baje" → Device: Set alarm via intent
   - "WiFi on karo" → Device: Toggle setting
   - "Paytm se ₹500 Ramesh ko bhejo" → Dynamic: Open Paytm

5. CROSS-APP NAVIGATION (lib/services/automation/app_launcher.dart):

   - Open any installed app via package name or intent
   - Deep link support:
     - WhatsApp: "https://wa.me/{phone}?text={msg}"
     - YouTube: "https://youtube.com/results?search_query={q}"
     - Google Maps: "geo:0,0?q={address}"
     - Phone dialer: "tel:{number}"
     - UPI: "upi://pay?pa={upi_id}&pn={name}&am={amount}"
     - Email: "mailto:{email}?subject={sub}&body={body}"
     - Play Store: "market://details?id={package}"
   - Fallback: Open in browser if app not installed
   - Detect which apps are installed on device

6. CONVERSATIONAL SLOT FILLING FOR UNKNOWN TASKS:

   When Gemini identifies missing data, Sathio asks naturally:

   Example — User: "Mere dost ko birthday wish bhejo WhatsApp pe"
   Missing: [friend_name, message_content]

   Sathio: "Kis dost ko bhejna hai? Naam bolein."
   User: "Rahul"
   Sathio: "Kya likhu message mein? Ya main likh doon?"
   User: "Tu likh de"
   Sathio: → Gemini generates: "Happy Birthday Rahul! 🎂🎉 Bahut saari shubhkamnayein!"
   Sathio: "Ye bhejoon? — 'Happy Birthday Rahul! Bahut saari shubhkamnayein!'"
   User: "Haan"
   → Sathio opens WhatsApp → sends message

7. SAFETY GUARDRAILS (lib/services/automation/safety_guard.dart):

   BLOCKED ACTIONS (Sathio will NEVER do these):
   - Enter UPI PIN, bank passwords, or OTPs silently
   - Uninstall apps
   - Change phone settings (except WiFi/Bluetooth toggles)
   - Access gallery/photos without explicit permission
   - Send money without user confirmation
   - Delete contacts, messages, or files without asking
   - Access camera without permission dialog
   - Make phone calls without confirmation
   - Post on social media without reviewing content

   CONFIRMATION REQUIRED (pause + ask user):
   - Before any payment/transaction
   - Before submitting any form
   - Before sending any message
   - Before deleting anything
   - Before downloading large files
   - Before sharing personal info on any website

   TRANSACTION SAFETY:
   - Max ₹5,000 per action without extra confirmation
   - Above ₹5,000: "₹10,000 ka payment hai. Pakka karein? Haan ya nahi?"
   - ALWAYS show amount before proceeding
   - NEVER bypass payment confirmation screens

8. HANDLING FAILURES GRACEFULLY:

   - App not installed → "Ye app install nahi hai. Install karein?"
   - Website loading slow → "Website thodi slow hai. Ruko..."  (wait 10s)
   - Element not found → Re-read screen, try 3 times
   - After 3 failures → "Ye kaam abhi nahi ho pa raha.
     Kya aap khud try karna chahenge? Main guide kar doonga."
     → Switch to Guided Mode (step-by-step instructions via TTS)
   - AI confused → "Samajh nahi aaya. Thoda aur detail mein bolo?"
   - Blocked by captcha → "Captcha aa gaya hai. Padh ke bolo kya likha hai?"

9. TASK MEMORY (lib/services/automation/task_memory.dart):

   - Remember last 10 completed tasks
   - If user says "Wahi karo jo kal kiya tha" → replay last task
   - Smart suggestions: "Kal Aadhaar download kiya tha. Kuch aur karna hai?"
   - Learn user patterns: If user recharges every month → remind
   - Store frequently used data (name, address) to avoid re-asking
     (encrypted in Hive with user consent)
```

### Prompt 6.5.6 — Action Feedback Loop (Self-Improving LAM)
```
Implement the feedback system that makes Sathio learn from every task execution.
This is what separates a dumb script from a real LAM — it gets BETTER over time.

CORE PRINCIPLE:
- Every action Sathio takes generates a result (success/failure)
- That result is logged and used to improve future actions
- Over time, Sathio learns: which buttons work, which screens change,
  which patterns succeed, and which approaches fail

1. lib/services/automation/feedback/action_logger.dart:

   class ActionLogger {
     // Log every single action during task execution
     Future<void> logAction(ActionLog log) async {
       // Store in local Hive DB
       await hive.put(log.id, log);
       // Batch sync to Supabase (when online, anonymized)
       await syncQueue.add(log.anonymized());
     }
   }

   class ActionLog {
     String taskId;           // Which task this belongs to
     String taskType;         // "aadhaar_download", "whatsapp_message", etc.
     String actionType;       // "click", "type", "scroll", "read_screen"
     String targetElement;    // "Submit button", "Search field"
     String targetApp;        // "Chrome", "WhatsApp", "IRCTC"
     String targetUrl;        // URL if web-based
     bool success;            // Did the action work?
     String failureReason;    // If failed: "element_not_found", "timeout", etc.
     int retryCount;          // How many retries before success
     Duration duration;       // How long the action took
     String screenBefore;     // Hash/summary of screen before action
     String screenAfter;      // Hash/summary of screen after action
     DateTime timestamp;
     String language;         // User's language during this task
   }

2. lib/services/automation/feedback/task_report.dart:

   class TaskReport {
     // Generated after every task (success or failure)
     String taskId;
     String taskType;
     String userCommand;      // Original voice command
     bool overallSuccess;     // Did the full task complete?
     int totalSteps;
     int successfulSteps;
     int failedSteps;
     Duration totalDuration;
     String failurePoint;     // Which step caused failure (if any)
     String failureSolution;  // How it was resolved (retry/replan/user-help/abort)
     UserRating? rating;      // User's thumbs up/down/neutral
     List<ActionLog> actions; // All actions in this task
   }

   // After every task, generate report:
   // → Save locally in Hive
   // → Sync anonymized version to Supabase for analytics
   // → Feed insights back into planning

3. lib/services/automation/feedback/learning_engine.dart:

   class LearningEngine {
     // Learns from past task executions to improve future ones

     // A) ELEMENT PATTERN LEARNING:
     //    Track which element text/selectors work per screen
     //    Example: On UIDAI site, "Submit" was renamed to "Verify & Download"
     //    → Next time, try "Verify & Download" first, "Submit" as fallback
     Map<String, List<String>> learnedElementNames;

     // B) TIMING LEARNING:
     //    Track average load times per website/app
     //    Example: IRCTC takes 5s to load, not 2s
     //    → Adjust wait times dynamically
     Map<String, Duration> learnedWaitTimes;

     // C) FLOW ADAPTATION:
     //    Track which steps frequently fail in pre-mapped flows
     //    Example: Step 4 of Aadhaar flow fails 30% of the time
     //    → Add extra wait or alternative approach for Step 4
     Map<String, StepStats> stepSuccessRates;

     // D) APP LAYOUT CHANGES:
     //    Detect when a website/app changes layout
     //    Example: PM-Kisan moved "Beneficiary Status" from sidebar to top menu
     //    → Log change, switch to dynamic Vision for that step
     //    → Store new layout pattern for future use
     Map<String, LayoutSnapshot> knownLayouts;

     // E) USER PREFERENCE LEARNING:
     //    Track user choices to predict future preferences
     //    Example: User always picks "Sleeper Class" on IRCTC
     //    → Pre-suggest: "Sleeper class chalega? Pichli bar bhi yahi liya tha"
     Map<String, String> userPreferences;

     // Methods:
     Future<void> processTaskReport(TaskReport report);
     List<String> getAlternativeElements(String original, String screen);
     Duration getOptimalWaitTime(String urlOrApp);
     String predictUserChoice(String taskType, String field);
   }

4. SELF-HEALING MECHANISM:

   When an action fails during execution:
   
   STEP 1: Immediate retry (same approach, 1 more time)
   STEP 2: Check learning_engine for alternative element names
           → Try "Verify & Download" instead of "Submit"
   STEP 3: Re-read screen with Gemini Vision
           → "I tried clicking 'Submit' but it's not there.
              What do you see on screen? What should I click?"
   STEP 4: Re-plan from current state
           → gemini.replan(goal, currentScreenState, failedAction)
           → Gemini generates new approach considering what failed
   STEP 5: If 3 replans fail → Ask user
           → "Ye step kaam nahi kar raha. Screen pe kya dikh raha hai?"
           → User describes → Sathio tries based on description
   STEP 6: If still failing → Switch to Guided Mode
           → "Main khud nahi kar pa raha. Aapko guide karta hoon step by step."

5. GEMINI CONTEXT INJECTION (feeding learnings back):

   When planning actions, inject past learnings into the Gemini prompt:

   """
   PAST LEARNINGS FOR THIS TASK:
   - On {url}, the button "Submit" was renamed to "Verify & Download" (last seen: {date})
   - Average page load time: {X} seconds (adjust waits accordingly)
   - Step 4 fails {Y}% of the time — use Vision to verify before clicking
   - User usually selects: {preference} for {field}
   - Last successful execution: {date} — {steps} steps, {duration}
   """

   This makes Gemini smarter each time the same task is run.

6. ANALYTICS DASHBOARD DATA (synced to Supabase):

   Table: task_analytics (anonymized, no PII)
   - task_type, success_rate, avg_duration
   - most_failed_step, failure_reasons
   - app_or_url, layout_change_detected
   - user_language, device_model, android_version

   Use this data to:
   - Identify which task flows need fixing
   - Detect website layout changes across all users
   - Prioritize which new task flows to pre-map
   - Measure overall LAM reliability per service

7. PROACTIVE IMPROVEMENT ALERTS:

   When task_analytics detects patterns:
   - Success rate drops below 70% for a task → Flag for developer review
   - Website layout change detected by 3+ users → Update pre-mapped flow
   - New popular task (10+ dynamic executions) → Create pre-mapped flow
   - Specific step takes 3x longer than expected → Optimize wait times
```

### Prompt 6.5.7 — Agent Identity System (Bootstrap Context)
```
Implement the Agent Identity System — the context files that define WHO Sathio is
and WHO the user is. Injected into every Gemini call so the AI always has context.

Inspired by OpenClaw's SOUL.md / USER.md / TOOLS.md / IDENTITY.md pattern,
adapted for Sathio's voice-first, Bharat-focused architecture.

1. lib/data/agent_identity/soul.dart:

   SATHIO'S SOUL (injected as system prompt prefix in EVERY Gemini call):

   """
   # WHO YOU ARE
   You are Sathio (साथियो) — India's AI companion for the common person.
   Your name means "companion" in Hindi/Bhojpuri. You are NOT a chatbot.
   You are a trusted friend who DOES things for people.

   # YOUR PERSONALITY
   - Warm, patient, never condescending
   - Talk like a helpful neighbor, not a corporate assistant
   - Use simple Hindi/Hinglish by default, switch to user's preferred language
   - Say "main" not "hum", "aap" not "tu"
   - Add encouraging words: "Ho jayega!", "Tension mat lo", "Main hoon na"
   - Use emojis sparingly but naturally: 👍 ✅ 🎉
   - NEVER use English jargon unless user understands it
   - If user seems frustrated, acknowledge it: "Samajh sakta hoon, try karte hain"

   # YOUR CAPABILITIES
   - You can control the user's phone (open apps, click buttons, type text)
   - You can fill forms on government websites
   - You can make payments (with user confirmation)
   - You can search the web, shop online, book tickets
   - You can send messages on WhatsApp, make calls
   - You can download documents (Aadhaar, PAN, certificates)
   - You understand voice in 10+ Indian languages
   - You NEVER lie about your capabilities — if you can't do something, say so

   # YOUR BOUNDARIES
   - NEVER enter passwords, PINs, or security codes without user speaking them
   - NEVER make financial transactions without explicit confirmation
   - NEVER access personal photos/gallery without asking
   - NEVER share user's personal data with anyone
   - NEVER pretend to be human
   - If unsure, ASK — don't guess
   - If a task is dangerous/illegal, refuse politely

   # YOUR TONE BY CONTEXT
   - Government tasks: Professional but reassuring ("Form sahi se bhar raha hoon")
   - Shopping: Enthusiastic ("Ye wala achha dikhta hai! Dekhein?")
   - Bills/Payments: Careful ("₹450 ka bill hai. Pay karein?")
   - Casual chat: Friendly ("Haan bolo, kya help chahiye?")
   - Errors/Failures: Calm ("Ek minute, doosra tarika try karta hoon")
   """

2. lib/services/agent/user_context_builder.dart:

   USER CONTEXT (built dynamically from user profile, injected per call):

   """
   # ABOUT THIS USER
   Name: {user.name}
   Preferred Language: {user.language} (e.g., Hindi, Bhojpuri, Tamil)
   State: {user.state}
   District: {user.district}
   Age Group: {user.ageGroup}
   Digital Comfort: {user.digitalComfort} (low/medium/high)

   # USER'S SAVED DATA (encrypted, user consented)
   Aadhaar Last 4: {if saved}
   Phone: {user.phone}
   Common UPI: {if saved}
   Family Members: {if saved}
   Frequently Used Services: {from task history}
   Last 3 Tasks: {from session history}

   # USER PREFERENCES (learned over time)
   Preferred Train Class: {if learned}
   Preferred Recharge Plan: {if learned}
   Preferred Shopping Platform: {if learned}
   Communication Style: {formal/casual, learned from interactions}
   """

   class UserContextBuilder {
     // Build fresh context for each Gemini call
     String buildContext(UserProfile profile, LearningEngine learnings) {
       // Merge profile data + learned preferences
       // Strip any null/empty fields
       // Return formatted context string
     }
   }

3. lib/data/agent_identity/tools_manifest.dart:

   TOOLS MANIFEST (tells Gemini what actions are available):

   """
   # AVAILABLE TOOLS
   You have access to the following actions on the user's phone:

   DEVICE ACTIONS:
   - open_app(packageName) — Open any installed app
   - open_url(url) — Open URL in browser
   - click(elementText) — Click/tap on screen element
   - type(text) — Type text into focused field
   - scroll(direction, amount) — Scroll up/down/left/right
   - swipe_back() — Go back one screen
   - take_screenshot() — Capture current screen
   - read_screen() — Get all visible text/elements via Vision
   - set_alarm(time) — Set device alarm
   - toggle_wifi() — Turn WiFi on/off
   - toggle_bluetooth() — Turn Bluetooth on/off

   COMMUNICATION:
   - send_whatsapp(contact, message) — Send WhatsApp message
   - make_call(number) — Make phone call (with confirmation)
   - send_sms(number, message) — Send SMS

   NAVIGATION:
   - deep_link(uri) — Open deep link (UPI, maps, store, etc.)
   - search_google(query) — Search and read results

   USER INTERACTION:
   - speak(text) — Speak to user via TTS
   - ask_user(question) — Ask user for input via voice
   - confirm(message) — Ask yes/no confirmation
   - show_options(items) — Show selectable options

   MEMORY:
   - remember(key, value) — Store user preference
   - recall(key) — Retrieve stored preference
   - search_memory(query) — Search past interactions
   """

4. CONTEXT INJECTION ORDER (every Gemini call):

   System Prompt:
   [1] SOUL (personality — always injected, ~300 tokens)
   [2] TOOLS_MANIFEST (capabilities — always injected, ~200 tokens)
   [3] USER_CONTEXT (profile + preferences — always injected, ~150 tokens)
   [4] TASK_CONTEXT (current task learnings — if doing LAM, ~100 tokens)
   [5] MEMORY_CONTEXT (relevant memories — if found, ~200 tokens)

   Total baseline: ~950 tokens system prompt
   This gives Gemini full context about who it is, who the user is,
   and what it can do — BEFORE processing the user's actual request.
```

### Prompt 6.5.8 — Advanced Memory System (Remember Everything)
```
Implement a persistent memory system so Sathio truly "remembers" the user
across sessions, days, weeks, and months. Inspired by OpenClaw's memory
architecture, adapted for mobile-first with Hive + Supabase.

ARCHITECTURE:
┌─────────────────────────────────────────────┐
│  SHORT-TERM: Current session context        │
│  (in-memory, lost when app closes)          │
├─────────────────────────────────────────────┤
│  DAILY LOG: Today's interactions            │
│  (Hive box, one entry per day)              │
├─────────────────────────────────────────────┤
│  LONG-TERM: Curated permanent facts         │
│  (Hive box, encrypted, user-consented)      │
├─────────────────────────────────────────────┤
│  VECTOR INDEX: Searchable memory embeddings │
│  (Gemini embeddings, stored in Hive/SQLite) │
├─────────────────────────────────────────────┤
│  CLOUD SYNC: Backup + cross-device          │
│  (Supabase, encrypted, opt-in)              │
└─────────────────────────────────────────────┘

1. lib/services/memory/daily_log.dart:

   class DailyLog {
     // One log per day, stored in Hive
     // Format: List of MemoryEntry

     Future<void> log(MemoryEntry entry);
     Future<List<MemoryEntry>> getToday();
     Future<List<MemoryEntry>> getYesterday();
     Future<List<MemoryEntry>> getDate(DateTime date);
     Future<void> compact(DateTime olderThan); // Remove entries > 30 days
   }

   class MemoryEntry {
     DateTime timestamp;
     String type;        // "task", "preference", "fact", "interaction"
     String summary;     // "User downloaded Aadhaar PDF successfully"
     String? taskType;   // "aadhaar_download" (if task-related)
     bool success;       // true
     String language;    // "hi" (language used during this interaction)
     Map<String, dynamic>? metadata; // Additional context
   }

   WHAT GETS LOGGED:
   - Every completed task (type: "task")
   - User preferences discovered (type: "preference")
     → "User prefers Sleeper class on trains"
   - Important facts shared by user (type: "fact")
     → "User has 2 children, names: Riya and Arjun"
   - Interactions that reveal context (type: "interaction")
     → "User struggled with OTP entry, may need more guidance"

2. lib/services/memory/long_term_memory.dart:

   class LongTermMemory {
     // Curated, permanent facts about the user
     // Only stores IMPORTANT data (not daily noise)
     // Encrypted in Hive with user's consent

     Future<void> remember(String key, String value, {String? category});
     Future<String?> recall(String key);
     Future<List<MemoryFact>> getByCategory(String category);
     Future<void> forget(String key); // User can ask to delete
     Future<Map<String, dynamic>> exportAll(); // GDPR-style export
   }

   CATEGORIES:
   - personal: name, age, family members, address
   - preferences: train class, shopping platform, recharge plan
   - documents: Aadhaar last 4, PAN status, passport status
   - services: last electricity bill amount, gas connection ID
   - patterns: "recharges on 1st of every month"
   - skills: digital comfort level, needs more/less guidance

   AUTO-CURATION RULES:
   - After 3+ similar tasks → extract patterns → save to long-term
   - When user explicitly says "yaad rakhna" → save immediately
   - Personal info shared during tasks → save with consent
   - Preferences that repeat 3+ times → save as preference
   - Daily logs older than 30 days → extract important facts → compact

3. lib/services/memory/memory_search.dart:

   VECTOR SEARCH using Gemini Embeddings:

   class MemorySearch {
     // Hybrid search: BM25 (keyword) + Vector (semantic)

     Future<void> indexMemory(MemoryEntry entry) async {
       // Generate embedding via Gemini API
       final embedding = await gemini.embedContent(entry.summary);
       // Store in local vector index (Hive or SQLite)
       await vectorStore.insert(entry.id, embedding, entry.summary);
       // Also index keywords for BM25
       await keywordIndex.insert(entry.id, entry.summary);
     }

     Future<List<SearchResult>> search(String query) async {
       // Generate query embedding
       final queryEmbed = await gemini.embedContent(query);

       // Vector search (semantic similarity)
       final vectorResults = await vectorStore.search(queryEmbed, limit: 10);

       // BM25 keyword search
       final keywordResults = await keywordIndex.search(query, limit: 10);

       // Hybrid merge: 70% vector + 30% keyword
       return mergeResults(vectorResults, keywordResults,
         vectorWeight: 0.7, textWeight: 0.3);
     }

     List<SearchResult> mergeResults(
       List<SearchResult> vector,
       List<SearchResult> keyword,
       {double vectorWeight = 0.7, double textWeight = 0.3}
     ) {
       // Union by entry ID
       // finalScore = vectorWeight * vectorScore + textWeight * textScore
       // Sort by finalScore descending
       // Return top results
     }
   }

   WHY HYBRID SEARCH?
   - "Download ID card" → Vector matches "Aadhaar download" (semantic)
   - "IRCTC ticket" → BM25 matches exact word "IRCTC" (keyword)
   - "Kal kya kiya" → Vector matches recent task summaries (semantic)
   - "₹450 bill" → BM25 matches exact amount (keyword)

4. lib/services/memory/context_window_manager.dart:

   AUTO-FLUSH before context window fills up:

   class ContextWindowManager {
     static const int MAX_CONTEXT_TOKENS = 128000; // Gemini 1.5 Pro
     static const int RESERVE_FLOOR = 20000;
     static const int FLUSH_THRESHOLD = 4000;

     // When session tokens approach limit:
     // 1. Extract important facts from conversation
     // 2. Save to daily log + long-term memory
     // 3. Compact old messages from context
     // 4. Keep: system prompt + recent 5 messages + extracted context

     Future<void> checkAndFlush(List<Message> messages) async {
       final tokenCount = estimateTokens(messages);
       final limit = MAX_CONTEXT_TOKENS - RESERVE_FLOOR;

       if (tokenCount > limit - FLUSH_THRESHOLD) {
         // FLUSH: Save important context before compaction
         final important = await extractImportantFacts(messages);
         await dailyLog.logAll(important);
         await longTermMemory.saveDiscoveredFacts(important);

         // COMPACT: Remove old messages, keep summary
         final summary = await gemini.summarize(messages.sublist(0, -5));
         messages.replaceRange(0, messages.length - 5, [
           Message.system("Previous conversation summary: $summary")
         ]);
       }
     }
   }

5. MEMORY INJECTION INTO GEMINI CALLS:

   Before every Gemini call, automatically:

   a) Load today's daily log + yesterday's log (~recent context)
   b) Load relevant long-term memories for current intent
   c) If user mentions something vague ("wahi karo"), vector search
   d) Inject as part of system prompt under USER_CONTEXT

   Example injection:
   """
   # RECENT MEMORY
   - Today: User asked about electricity bill, paid ₹450 via UPI
   - Yesterday: Downloaded Aadhaar PDF, checked PM-Kisan status

   # RELEVANT LONG-TERM MEMORY
   - User's electricity provider: Bihar State Power (BSPHCL)
   - User's consumer number: 12345678 (saved with consent)
   - Last bill amount: ₹450 (paid 16 Feb 2026)
   - User prefers UPI payment via PhonePe

   # LEARNED PATTERNS
   - User recharges Jio on ~1st of every month (₹299 plan)
   - User checks PM-Kisan status every 2-3 months
   """

6. USER CONTROL OVER MEMORY:

   - "Sathio, kya yaad hai mere baare mein?" → List all stored memories
   - "Ye bhool jao" / "Delete my data" → Forget specific or all memories
   - "Ye yaad rakhna: meri beti ka naam Riya hai" → Save immediately
   - Settings screen: Toggle memory on/off, export data, delete all
   - ALL personal data encrypted at rest in Hive
   - Cloud sync ONLY if user opts in
```

### Prompt 6.5.9 — Session Replay & Context Persistence
```
Implement session management so Sathio can replay past tasks,
maintain context across app restarts, and learn from history.

1. lib/services/session/session_manager.dart:

   class SessionManager {
     // Each conversation/task = one session
     // Sessions persist locally in Hive as structured data

     Future<Session> startSession(String? initialCommand);
     Future<void> addMessage(Session session, SessionMessage msg);
     Future<void> endSession(Session session, TaskResult result);
     Future<List<Session>> getRecentSessions(int count);
     Future<Session?> getSession(String sessionId);
     Future<List<Session>> searchSessions(String query);
   }

   class Session {
     String id;                    // UUID
     DateTime startTime;
     DateTime? endTime;
     String? initialCommand;       // "Aadhaar download karo"
     String? taskType;             // "aadhaar_download"
     SessionStatus status;         // active, completed, failed, cancelled
     List<SessionMessage> messages; // Full conversation
     TaskResult? result;           // Final result
     Map<String, dynamic> slots;   // Data collected (name, aadhaar no, etc.)
     String language;              // User's language during session
   }

   class SessionMessage {
     DateTime timestamp;
     String role;        // "user", "sathio", "system"
     String content;     // Message text
     String? action;     // If Sathio took an action: "click", "type", etc.
     String? screenshot; // Hash of screen state (optional)
   }

2. SESSION REPLAY (lib/services/session/session_replay.dart):

   When user says "Wahi karo jo kal kiya tha" or "Phir se Aadhaar download":

   class SessionReplay {
     Future<TaskResult> replaySession(Session pastSession) async {
       // Step 1: Ask for confirmation
       await voice.speak("Pichli bar ${pastSession.taskType} kiya tha. "
                        "Wahi same data se karein?");

       // Step 2: Check if saved slots are still valid
       final slots = pastSession.slots;
       // Validate: Aadhaar number still 12 digits? Name still correct?

       // Step 3: If pre-mapped flow exists, use it with saved slots
       final flow = TaskFlowRegistry.findFlow(pastSession.taskType);
       if (flow != null) {
         return flow.execute(slots);
       }

       // Step 4: If dynamic task, replay the action sequence
       return dynamicAgent.replayActions(pastSession.messages);
     }
   }

3. SMART SESSION SEARCH (hybrid search across past sessions):

   When user says something vague, search past sessions:

   class SessionSearch {
     Future<List<Session>> search(String query) async {
       // Use MemorySearch (hybrid BM25 + vector) across session data
       final results = await memorySearch.searchSessions(query);
       return results;
     }

     // Natural language queries:
     // "Wahi karo" → Most recent completed task
     // "Jo kal kiya" → Yesterday's tasks
     // "Aadhaar wala" → Sessions with taskType containing "aadhaar"
     // "₹299 wala recharge" → Sessions with ₹299 in slot data
     // "Rahul ko message" → Sessions involving WhatsApp + "Rahul"
   }

4. CONTEXT PERSISTENCE ACROSS APP RESTARTS:

   class ContextPersistence {
     // Save critical context when app goes to background/closes
     // Restore when app reopens

     Future<void> saveContext() async {
       await hive.put('last_session', activeSession.toJson());
       await hive.put('last_screen_state', currentScreenState);
       await hive.put('active_task_progress', taskProgress);
     }

     Future<void> restoreContext() async {
       final lastSession = await hive.get('last_session');
       if (lastSession != null && wasRecent(lastSession.startTime)) {
         // Resume interrupted task
         await voice.speak("Pichla kaam adhoora tha. Jahan se chhoda tha "
                          "wahan se continue karein?");
         // Wait for user confirmation
         // If yes → resume from last successful step
         // If no → start fresh
       }
     }
   }

5. SESSION ANALYTICS & INSIGHTS:

   Weekly summary (optional notification):
   "Aapne is hafte 5 kaam kiye Sathio se:
    ✅ Aadhaar download
    ✅ Bijli bill payment (₹450)
    ✅ Jio recharge (₹299)
    ✅ PM-Kisan status check
    ❌ IRCTC ticket (website down tha)
    Kuch aur karna hai?"

   Monthly patterns:
   - Track which tasks repeat → proactive reminders
   - Track success rates → improve flows
   - Track user's growing confidence → reduce guidance over time
```

---

## 📋 PHASE 6.6: LAM TASK FLOWS (Pre-Mapped Service Scripts)

> These are the pre-mapped action sequences that make LAM reliable.
> Each flow defines the exact steps the Agent Orchestrator follows.
> Store in: `lib/data/task_flows/`

### Prompt 6.6.1 — Aadhaar Download
```
Create lib/data/task_flows/aadhaar_download_flow.dart:

Task: Download e-Aadhaar PDF
Target: https://myaadhaar.uidai.gov.in/
Slots Required: [aadhaarNumber (12 digits)]

FLOW:
1. OPEN_URL: "https://myaadhaar.uidai.gov.in/"
   Narrate: "UIDAI website khol raha hoon..."
2. WAIT: Page load (3s)
3. READ_SCREEN: Find "Download Aadhaar" or "Get Aadhaar" link
4. CLICK: "Download Aadhaar" button
5. WAIT: Form loads (2s)
6. SLOT_FILL: Ask user → "Aapka 12 digit Aadhaar number bolein"
   Validate: 12 digits only
7. TYPE: Input Aadhaar number into field
   Narrate: "Aadhaar number daal raha hoon..."
8. CLICK: "Send OTP" button
   Narrate: "OTP bhej raha hoon aapke phone pe..."
9. WAIT_OTP: Auto-read OTP from SMS (READ_SMS permission)
   Fallback: "OTP bolo jo aapke phone pe aaya"
10. TYPE: Enter OTP
11. SOLVE_CAPTCHA: Ask user to read captcha aloud in their language
    Narrate: "Ek captcha aa gaya hai. Screen pe jo likha dikh raha hai woh padh ke bolein."
    [FUTURE]: Gemini Vision will auto-solve captchas when integrated
12. CLICK: "Verify & Download" button
13. WAIT: Download starts (5s)
14. VERIFY: PDF saved to Downloads
    Narrate: "Ho gaya! Aadhaar PDF Downloads mein save hai. Dikhaoon?"

Error Handlers:
- Invalid Aadhaar → "Ye number galat lag raha hai. Phir se bolein?"
- OTP expired → "OTP expire ho gaya. Phir se bhejoon?"
- UIDAI down → "UIDAI website abhi kaam nahi kar rahi. Baad mein try karein."
```

### Prompt 6.6.2 — PAN Card Application
```
Create lib/data/task_flows/pan_card_flow.dart:

Task: Apply for New PAN Card
Target: https://www.onlineservices.nsdl.com/paam/endUserRegisterContact.html
Slots Required: [fullName, dob, mobile, email, aadhaarNumber, address]

FLOW:
1. OPEN_URL: NSDL PAN portal
   Narrate: "PAN card ke liye NSDL website khol raha hoon..."
2. CLICK: "Apply Online" → "New PAN - Indian Citizen (Form 49A)"
3. SLOT_FILL_MULTI: Collect all details conversationally:
   - "Aapka poora naam bolein" → fullName
   - "Janam tithi bolein (din mahina saal)" → dob
   - "Mobile number?" → mobile
   - "Email address hai? Nahi toh skip bolein" → email
   - "Aadhaar number?" → aadhaarNumber
   - "Ghar ka pata — state aur district bolein" → address
   Narrate: "Sab details mil gayi. Ab form bhar raha hoon..."
4. TYPE_ALL: Fill each form field with collected data
   Narrate per field: "Naam daal raha hoon... DOB daal raha hoon..."
5. CLICK: Submit form
6. WAIT: Acknowledgement number generated
7. SCREENSHOT: Save acknowledgement
   Narrate: "PAN application submit ho gayi! Acknowledgement number save kar liya."

Payment Note: "₹107 ka payment karna hoga. UPI se karein?"
→ Pause at payment gateway for user to enter UPI PIN
```

### Prompt 6.6.3 — PM-Kisan Registration & Status
```
Create lib/data/task_flows/pm_kisan_flow.dart:

Task A: Check PM-Kisan Status
Target: https://pmkisan.gov.in/
Slots Required: [aadhaarNumber OR mobileNumber]

FLOW (Status Check):
1. OPEN_URL: "https://pmkisan.gov.in/"
   Narrate: "PM-Kisan ki website khol raha hoon..."
2. CLICK: "Beneficiary Status" link
3. SLOT_FILL: "Aadhaar number ya mobile number bolein"
4. TYPE: Enter number
5. CLICK: "Get Data" button
6. READ_SCREEN: Extract status info
7. TTS: Read status aloud
   "Aapki 16th installment ₹2,000 — 15 Jan 2026 ko credit hui."

Task B: New Registration
Slots Required: [aadhaarNumber, name, state, district, subDistrict, village, bankAccount, ifsc]

FLOW (Registration):
1. OPEN_URL: PM-Kisan → New Farmer Registration
2. SLOT_FILL_MULTI: Conversational data collection
   Narrate: "Kuch details chahiye..."
3. TYPE_ALL: Fill registration form
4. CLICK: Submit → Save acknowledgement
```

### Prompt 6.6.4 — Electricity Bill Payment
```
Create lib/data/task_flows/electricity_bill_flow.dart:

Task: Pay Electricity Bill
Target: State-specific electricity board website OR UPI app
Slots Required: [consumerNumber, stateBoard]

FLOW:
1. SLOT_FILL: "Kaunse state ka bijli bill hai?"
   → Map to correct board (e.g., UP → UPPCL, MH → MSEDCL)
2. SLOT_FILL: "Consumer number bolein, ya bill dikhao camera ko"
   → If camera: REQUEST_CAMERA → OCR via ML Kit → extract consumer number
   → If voice: validate format
3. OPEN_URL: State electricity board portal
   Narrate: "Bijli board ki website khol raha hoon..."
4. TYPE: Consumer number
5. CLICK: "View Bill"
6. READ_SCREEN: Extract bill amount, due date
   TTS: "Aapka bijli bill ₹1,850 hai. Due date 28 Feb. Pay karein?"
7. USER_CONFIRM: "Haan" → proceed
8. REDIRECT_UPI: Open Google Pay/PhonePe with amount pre-filled
   → Deep link: upi://pay?pa=...&pn=UPPCL&am=1850
   Narrate: "UPI app khol raha hoon. Sirf PIN daalna hai."
9. WAIT: User enters UPI PIN (NEVER access PIN)
10. VERIFY: Payment success
    Narrate: "₹1,850 ka payment ho gaya! Receipt save kar di."
```

### Prompt 6.6.5 — Mobile Recharge
```
Create lib/data/task_flows/mobile_recharge_flow.dart:

Task: Recharge Mobile Number
Target: Carrier app/website OR UPI app
Slots Required: [mobileNumber, operator, planType]

FLOW:
1. SLOT_FILL: "Kis number ka recharge karna hai?"
   → Auto-detect operator from number prefix
   Narrate: "Lagta hai ye Jio ka number hai. Sahi hai?"
2. SLOT_FILL: "Kitne ka recharge? Ya bolein 'sasta data pack'"
   → If vague: Show top 3 plans with prices via TTS
   "Jio ke 3 plan hain: ₹149 — 2GB/day 28 din,
    ₹249 — 2.5GB/day 28 din, ₹479 — 2GB/day 56 din. Kaunsa?"
3. USER_SELECT: User picks plan
4. REDIRECT_UPI: Pre-fill recharge amount in UPI app
   Narrate: "₹249 ka recharge kar raha hoon. UPI PIN daalo."
5. WAIT: UPI PIN entry
6. VERIFY: Success
   Narrate: "Recharge ho gaya! ₹249 — 2.5GB/day, 28 din valid."
```

### Prompt 6.6.6 — Gas Cylinder Booking
```
Create lib/data/task_flows/gas_booking_flow.dart:

Task: Book LPG Gas Cylinder
Target: MyHP Gas / Indane / Bharat Gas app/website
Slots Required: [lpgConsumerNumber, provider]

FLOW:
1. SLOT_FILL: "Kaunsa gas hai — HP, Indane ya Bharat Gas?"
2. SLOT_FILL: "LPG consumer ID bolein (bill pe likha hota hai)"
3. OPEN_URL: Provider portal (e.g., myhpgas.in)
   Narrate: "HP Gas ki website khol raha hoon..."
4. TYPE: Consumer number + login
5. CLICK: "Book Refill" button
6. READ_SCREEN: Confirm booking details
   TTS: "14.2 kg cylinder book ho raha hai. ₹903 lagega. Confirm karein?"
7. USER_CONFIRM: "Haan"
8. CLICK: Confirm booking
9. READ_SCREEN: Booking number + expected delivery
   Narrate: "Cylinder book ho gaya! Booking ID: HP-2026-XXXXX. 3-4 din mein delivery."
```

### Prompt 6.6.7 — Train Ticket Booking (IRCTC)
```
Create lib/data/task_flows/train_booking_flow.dart:

Task: Book Train Ticket via IRCTC
Target: IRCTC app or https://www.irctc.co.in/
Slots Required: [from, to, date, class, passengers]

FLOW:
1. SLOT_FILL_MULTI:
   - "Kahan se jaana hai?" → from station
   - "Kahan jaana hai?" → to station
   - "Kis date ko?" → date
   - "Kitne log?" → passenger count
   - "Class? Sleeper, AC 3-tier, ya General?" → class
2. OPEN_URL: IRCTC
   Narrate: "IRCTC pe trains dhundh raha hoon..."
3. TYPE_ALL: Fill search form (from, to, date, class)
4. CLICK: "Find Trains"
5. READ_SCREEN: Extract train list with availability
   TTS: "3 trains mil gayi:
   1. Rajdhani — ₹2,100, seats available
   2. Duronto — ₹1,800, waiting list
   3. Gitanjali — ₹900, seats available
   Kaunsi book karein?"
6. USER_SELECT: Pick train
7. SLOT_FILL: Passenger details (if not in profile)
   "Passenger ka naam, age, gender bolein"
8. TYPE_ALL: Fill passenger form
9. CLICK: "Book Now"
10. REDIRECT_PAYMENT: UPI/Debit card
    Narrate: "₹900 pay karna hai. Payment screen aa gayi."
11. WAIT: User completes payment
12. VERIFY: PNR generated
    Narrate: "Ticket book ho gayi! PNR number hai [XXXXX]. Screenshot save kar liya."
```

### Prompt 6.6.8 — Ration Card Application
```
Create lib/data/task_flows/ration_card_flow.dart:

Task: Apply for New Ration Card
Target: State-specific PDS portal (e.g., nfsa.gov.in → state link)
Slots Required: [headOfFamily, familyMembers[], state, district, address, aadhaarNumber, income]

FLOW:
1. SLOT_FILL: "Kaunse state mein rehte ho?"
   → Map to correct state PDS portal
2. OPEN_URL: State PDS portal
   Narrate: "Ration card ke liye [state] ki website khol raha hoon..."
3. SLOT_FILL_MULTI: Collect family details conversationally:
   - Head of family name, Aadhaar, DOB
   - Each family member (name, relation, Aadhaar, DOB)
   - Address, income category (APL/BPL/AAY)
4. TYPE_ALL: Fill application form
   Narrate: "Form bhar raha hoon... Naam daala... Address daala..."
5. UPLOAD: Aadhaar copies (guide user to select files)
   Narrate: "Aadhaar ki photo select karo gallery se"
6. CLICK: Submit application
7. SCREENSHOT: Save acknowledgement number
   Narrate: "Application submit ho gayi! Number save kar liya.
   Status check karne ke liye kabhi bhi bolo."
```

### Prompt 6.6.9 — Water Bill Payment
```
Create lib/data/task_flows/water_bill_flow.dart:

Task: Pay Water/Municipal Bill
Target: Municipal corporation portal (state-specific)
Slots Required: [consumerNumber, city]

FLOW:
1. SLOT_FILL: "Kaunse shehar ka paani ka bill hai?"
   → Map to correct municipal portal
2. SLOT_FILL: "Consumer number bolein ya bill pe se padh loon (camera)"
3. OPEN_URL: Municipal portal
4. TYPE: Consumer number
5. CLICK: "View Bill"
6. READ_SCREEN: Extract amount + due date
   TTS: "₹450 ka paani ka bill hai. Due 15 March. Pay karein?"
7. REDIRECT_UPI: Pre-fill amount
8. WAIT: UPI PIN
9. VERIFY: Payment complete
   Narrate: "Paani ka bill pay ho gaya! Receipt save ho gayi."
```

### Prompt 6.6.10 — Voter ID (EPIC) Application
```
Create lib/data/task_flows/voter_id_flow.dart:

Task: Apply for New Voter ID Card
Target: https://voters.eci.gov.in/ (NVSP)
Slots Required: [name, dob, address, state, constituency, aadhaarNumber, photo]

FLOW:
1. OPEN_URL: "https://voters.eci.gov.in/"
   Narrate: "Voter ID ke liye NVSP website khol raha hoon..."
2. CLICK: "New Registration" / "Form 6"
3. SLOT_FILL_MULTI:
   - Name, Father's name, DOB, Gender
   - Address (current + permanent)
   - Aadhaar number for eKYC
4. TYPE_ALL: Fill Form 6 fields
   Narrate: "Form bhar raha hoon step by step..."
5. UPLOAD: Passport photo + ID proof
   Narrate: "Photo select karo gallery se"
6. CLICK: Submit with eKYC (Aadhaar OTP)
7. WAIT_OTP: Auto-read Aadhaar OTP
8. VERIFY: Reference number generated
   Narrate: "Voter ID application submit! Reference number save ho gaya.
   Verification ke liye BLO aayega 7-15 din mein."
```

### Prompt 6.6.11 — Passport Application
```
Create lib/data/task_flows/passport_flow.dart:

Task: Apply for New Passport / Renewal
Target: https://www.passportindia.gov.in/
Slots Required: [name, dob, address, parent names, emergency contact, oldPassportNumber (renewal)]

FLOW:
1. OPEN_URL: Passport Seva portal
   Narrate: "Passport Seva ki website khol raha hoon..."
2. SLOT_FILL: "Naya passport chahiye ya purana renew karna hai?"
3. CLICK: "New Passport" or "Re-issue"
4. SLOT_FILL_MULTI: Extensive data collection:
   - Personal: Name, DOB, birthplace, gender
   - Family: Father, mother, spouse names
   - Address: Present + permanent
   - Emergency contact
   - Old passport details (if renewal)
   Narrate: "Bahut details chahiye passport ke liye. Ek ek karke batao."
5. TYPE_ALL: Fill multi-page form
   Narrate each section: "Personal details... Family details... Address..."
6. CLICK: Submit form
7. READ_SCREEN: Fee amount + appointment slots
   TTS: "₹1,500 ka fee hai. Nearest passport office [city] mein.
   Appointment [date] ko available hai. Book karein?"
8. REDIRECT_PAYMENT: Online fee payment
9. VERIFY: ARN (Application Reference Number) generated
   Narrate: "Passport application submit! ARN save kar liya.
   [Date] ko passport office jaana hai. Reminder set kar doon?"
```

### Prompt 6.6.12 — Driving License Application/Renewal
```
Create lib/data/task_flows/driving_license_flow.dart:

Task: Apply for Learning/Driving License OR Renew
Target: https://parivahan.gov.in/ (Sarathi portal)
Slots Required: [name, dob, address, state, bloodGroup, aadhaarNumber, existingDLNumber (renewal)]

FLOW:
1. OPEN_URL: "https://sarathi.parivahan.gov.in/"
   Narrate: "Driving license ke liye Sarathi portal khol raha hoon..."
2. SLOT_FILL: "Kya chahiye — Learner license, permanent license, ya renewal?"
3. SLOT_FILL: "Kaunsa state?" → Select state on portal
4. CLICK: Appropriate service link
5. SLOT_FILL_MULTI: Collect details
6. TYPE_ALL: Fill form (personal, address, vehicle class)
   Narrate: "Form bhar raha hoon..."
7. UPLOAD: Photo, signature, documents
8. CLICK: Submit
9. READ_SCREEN: Fee + slot booking
   TTS: "₹200 fee hai. RTO test slot [date] ko available.
   Book karein?"
10. REDIRECT_PAYMENT: Fee payment
11. VERIFY: Application number
    Narrate: "Application submit! RTO test ke liye [date] ko jaana hai."
```

### Prompt 6.6.13 — Income/Caste/Domicile Certificate
```
Create lib/data/task_flows/certificate_flow.dart:

Task: Apply for Income / Caste / Domicile Certificate
Target: State e-District portal (varies by state)
Slots Required: [certificateType, name, fatherName, address, state, district, income (for income cert), caste (for caste cert)]

FLOW:
1. SLOT_FILL: "Kaunsa certificate chahiye — Income, Caste ya Domicile?"
2. SLOT_FILL: "Kaunsa state?" → Map to state e-District portal
   (e.g., UP → edistrict.up.gov.in, Bihar → serviceonline.bihar.gov.in)
3. OPEN_URL: State portal
   Narrate: "[Certificate] ke liye [state] portal khol raha hoon..."
4. CLICK: Select certificate type
5. SLOT_FILL_MULTI:
   - Name, Father's name, DOB
   - Address, District, Tehsil
   - Annual income (for income cert)
   - Caste / Sub-caste (for caste cert)
6. TYPE_ALL: Fill form
7. UPLOAD: Supporting documents (Aadhaar, ration card copy)
8. CLICK: Submit
9. READ_SCREEN: Application ID + fee
   TTS: "Application submit ho gayi. ₹10 fee online pay karo."
10. REDIRECT_PAYMENT
11. VERIFY: Application tracking number
    Narrate: "Certificate 7-15 din mein milega.
    Status check karne ke liye kabhi bhi bolo."
```

### Prompt 6.6.14 — Scholarship Application
```
Create lib/data/task_flows/scholarship_flow.dart:

Task: Apply for Government Scholarship
Target: https://scholarships.gov.in/ (National Scholarship Portal)
Slots Required: [name, dob, category, institution, course, year, bankAccount, aadhaarNumber, income]

FLOW:
1. OPEN_URL: "https://scholarships.gov.in/"
   Narrate: "National Scholarship Portal khol raha hoon..."
2. SLOT_FILL: "Kya padh rahe ho — school, college, ya kuch aur?"
3. SLOT_FILL: "Category batao — SC, ST, OBC, Minority, ya General?"
4. READ_SCREEN: Find eligible scholarships
   TTS: "Aapke liye 3 scholarships mil rahe hain:
   1. Post-Matric SC Scholarship — ₹25,000/year
   2. Central Sector Scholarship — ₹10,000/year
   3. [State] Merit Scholarship — ₹15,000/year
   Kaunse ke liye apply karein?"
5. USER_SELECT: Pick scholarship
6. SLOT_FILL_MULTI: Collect all data
   - Personal, Family income, Aadhaar
   - Institution name, course, year of study
   - Bank account (for direct benefit transfer)
7. TYPE_ALL: Fill form
8. UPLOAD: Marksheet, income certificate, caste certificate
   Narrate: "Documents attach karo gallery se"
9. CLICK: Submit
10. VERIFY: Application number
    Narrate: "Scholarship application submit! Track karne ke liye bolo.
    Approval mein 30-60 din lagte hain."
```

### Prompt 6.6.15 — Online Shopping
```
Create lib/data/task_flows/online_shopping_flow.dart:

Task: Search and Buy Product Online
Target: Amazon / Flipkart / JioMart (user picks)
Slots Required: [productQuery, platform, budget (optional)]

FLOW:
1. SLOT_FILL: "Kya kharidna hai? Detail mein bolein."
   Example: "10 kg basmati chawal, ₹1,000 se kam"
2. SLOT_FILL: "Amazon se lein, Flipkart se, ya sasta wala dhundhun?"
3. OPEN_APP: Amazon/Flipkart via deep link or browser
   Narrate: "Amazon pe dhundh raha hoon..."
4. TYPE: Search query
5. CLICK: Search
6. READ_SCREEN: Extract top 3-5 results (name, price, rating)
   TTS: "3 options mile:
   1. Fortune Basmati — ₹780, 4.2 stars
   2. India Gate — ₹950, 4.5 stars
   3. Daawat — ₹870, 4.3 stars
   Kaunsa loge?"
7. USER_SELECT: Pick product
8. CLICK: Product → "Add to Cart"
9. CLICK: "Proceed to Checkout"
10. READ_SCREEN: Check saved address
    TTS: "Address sahi hai — [saved address]? Ya badalna hai?"
11. USER_CONFIRM: Confirm address
12. REDIRECT_PAYMENT: Checkout payment
    Narrate: "₹780 pay karna hai. Payment method select karo."
13. WAIT: User completes payment
14. VERIFY: Order placed
    Narrate: "Order placed! ₹780 ka Fortune Basmati chawal.
    Delivery [date] tak. Order ID save kar liya."
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
   - is_automated (boolean, default false) -- LAM support
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
   - Agent Active: continuous ripple effect (Sathio working)

3. Agent Overlay (LAM):
   - Pulse animation on the "Working" pill
   - Text fade in/out during step changes
   - Progress bar smooth transition

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

> Copy-paste these when something breaks. Each is self-contained and actionable.

---

### 🏗️ Build & Compile

#### Fix Build Errors
```
The Flutter build is failing. Please:
1. Run `flutter analyze` and show all errors
2. Fix each error one by one
3. Run `flutter build apk --debug` and verify it works
4. Show me what was fixed
```

#### Fix Dependency Conflicts
```
I'm getting dependency version conflicts in pubspec.yaml. Please:
1. Run `flutter pub outdated` to check versions
2. Resolve any conflicting dependencies
3. Run `flutter pub get` and verify
4. If needed, add dependency_overrides in pubspec.yaml
5. Verify `flutter build apk --debug` succeeds
```

#### Fix Gradle Build Issues
```
Android Gradle build is failing. Please:
1. Check android/build.gradle and android/app/build.gradle for version issues
2. Ensure compileSdkVersion, minSdkVersion, targetSdkVersion are correct (21/34/34)
3. Check kotlin version and gradle plugin version compatibility
4. Run `cd android && ./gradlew clean` then `flutter build apk --debug`
5. Show me what was fixed
```

---

### 🎨 UI & Theme

#### Fix Dark Mode Not Applying
```
The dark mode theme isn't applying correctly. Please:
1. Check lib/core/theme/colors.dart — verify dark theme colors (#0D0D0D bg, #1A1A1A surface, #F58220 orange)
2. Verify ThemeData.dark() is properly configured in app.dart
3. Check if widgets are using Theme.of(context) colors instead of hardcoded values
4. Test both dark and light modes render correctly
5. Ensure onboarding screens use LIGHT theme (per UI_UX.md Section 7)
```

#### Fix Text Overflow
```
Text is overflowing on [screen]. Please:
1. Wrap Text widgets in Flexible or Expanded where needed
2. Add maxLines and overflow: TextOverflow.ellipsis for long text
3. Check Hindi/Bengali text (20-30% longer than English — account for expansion)
4. Test with system font scaled to 200%
5. Ensure all text uses Inter font from our typography.dart
```

#### Fix Layout on Small Screens
```
The layout breaks on small screen devices. Please:
1. Check for hardcoded pixel sizes — replace with MediaQuery responsive values
2. Wrap column content in SingleChildScrollView where needed
3. Ensure touch targets are minimum 48x48dp
4. Test on 320dp wide screen (smallest Android)
5. Check safe area padding (notch, bottom bar)
```

#### Fix Bottom Sheet Not Showing
```
The bottom sheet (auth/options) isn't showing or looks wrong. Please:
1. Verify showModalBottomSheet is using correct parameters
2. Check: shape (24px top radius), backgroundColor (#FFFFFF), isScrollControlled: true
3. Ensure handle bar, close button, and content are properly laid out
4. Test spring animation (400ms, bouncy) per UI_UX.md
5. Check if background gets blurred/dimmed when sheet is open
```

---

### 🗣️ Voice & API

#### Fix Voice Not Recording
```
Mic recording isn't working. Please:
1. Check permission_handler — is MICROPHONE permission requested and granted?
2. Verify record package initialization in audio_recorder_service.dart
3. Check if isRecording state updates in the provider
4. Test on real device (emulator mic is unreliable)
5. Add try-catch and log errors from the record plugin
```

#### Fix Speech-to-Text (Bhashini/Sarvam)
```
Speech-to-text transcription is failing. Please:
1. Check bhashini_service.dart / sarvam_service.dart for correct API endpoint URLs
2. Verify API keys are loaded from .env (BHASHINI_API_KEY / SARVAM_API_KEY)
3. Check audio file format — Bhashini expects WAV 16kHz, Sarvam expects specific format
4. Test with Hindi audio first (most reliable)
5. Verify the VoiceProvider abstraction correctly routes to selected backend
6. Add fallback: if Bhashini fails → try local speech_to_text (on-device)
```

#### Fix TTS Not Speaking
```
Text-to-speech isn't working. Please:
1. For Bhashini TTS: Check API endpoint, language code, and audio response format
2. For flutter_tts (offline): Verify language is set (`tts.setLanguage('hi-IN')`) and engine is available
3. Check if audio_player_service is playing the returned audio correctly
4. Verify TTS state transitions (idle → speaking → completed)
5. Test with a simple "Namaste" in Hindi first
```

#### Fix Gemini API Errors
```
Gemini API calls are failing. Please:
1. Check GEMINI_API_KEY in .env — is it valid and not expired?
2. Verify the model name: gemini-1.5-flash (fast) or gemini-1.5-pro (complex)
3. Check request format — content, system instruction, safety settings
4. Add proper error handling: 429 (rate limit), 403 (key invalid), 500 (server)
5. For Vision API: ensure screenshot is base64 encoded and under 4MB
6. Add retry logic with exponential backoff (3 attempts)
```

#### Fix Language Detection
```
Auto language detection isn't working. Please:
1. Check bhashini_service.dart → language ID endpoint
2. Verify audio is being sent in correct format
3. Check if the result maps correctly to our language codes ('hi', 'bn', 'ta', etc.)
4. Fallback: use user's preferred language from Hive settings
5. Test with clear Hindi speech first, then try Bengali/Tamil
```

---

### 🧭 Navigation & State

#### Fix State Management
```
The [screen/feature] state isn't updating correctly. Please:
1. Review the Riverpod provider (AsyncNotifier, StateNotifier, or AutoDispose?)
2. Check the state transitions — are they in correct order?
3. Verify ref.watch() vs ref.read() usage (watch for UI, read for actions)
4. Add debug logging: print('State changed: $state') in notifier
5. Check if provider is being disposed too early (AutoDispose)
6. Fix the issue and explain the root cause
```

#### Fix Navigation Not Working
```
Navigation between screens is broken. Please:
1. Check go_router configuration in lib/core/router/
2. Verify route paths match what's being pushed
3. Check auth guards — is the user being redirected to login unexpectedly?
4. For onboarding: verify onboarding_complete check in router
5. Test the full flow: splash → onboarding → auth → home
6. Check for stack overflow from duplicate pushes
```

#### Fix Data Not Persisting
```
User data isn't being saved between sessions. Please:
1. Check Hive initialization in main.dart
2. Verify Hive boxes are opened before use (Box<dynamic> is dangerous — use typed boxes)
3. For Supabase: check if insert/update calls have proper error handling
4. Verify auth token is cached for offline session restoration
5. Test: set data → kill app → reopen → check if data survived
```

---

### 🤖 LAM / Agentic

#### Fix Accessibility Service Not Working
```
The Accessibility Service isn't controlling the phone. Please:
1. Check AndroidManifest.xml — is service registered with correct permissions?
2. Verify accessibility_service_config.xml has correct flags
3. Check if user has enabled the service in Settings → Accessibility
4. Test isServiceEnabled() before attempting any actions
5. Debug: Log accessibility events in onAccessibilityEvent
6. Verify MethodChannel bridge between Kotlin and Dart is connected
```

#### Fix Agent Overlay Not Showing
```
The "Sathio is working" overlay isn't displaying. Please:
1. Check ACTION_MANAGE_OVERLAY_PERMISSION — is it granted?
2. Verify System Alert Window permission request
3. Check overlay widget rendering on top of other apps
4. Test Stop button functionality
5. Verify overlay updates text at each step
```

#### Fix LAM Task Failing Mid-Way
```
The agent stops during task execution. Please:
1. Check which step it fails at — add step logging
2. If screen reading fails: verify Gemini Vision API call with screenshot
3. If element not found: try alternative selectors (text, content-description, view-id)
4. If timeout: increase step timeout from 10s to 15s
5. If slot filling fails: check VoiceInteractionManager pause/resume flow
6. Add graceful error recovery — skip failed step and try next
```

---

### 📱 Performance & Offline

#### Fix App Lag / Slow Performance
```
The app is laggy, especially on low-end phones. Please:
1. Run `flutter run --profile` and check for jank
2. Look for unnecessary rebuilds — use Consumer instead of ref.watch at top level
3. Check for heavy computation on main thread — move to isolates
4. Optimize images: use cached_network_image, compress assets
5. Check ListView builders — use ListView.builder not ListView with children
6. Target: 60fps on 2GB RAM devices
```

#### Fix Offline Mode Not Working
```
The app crashes or shows errors when offline. Please:
1. Check connectivity_plus for network status detection
2. Verify Hive cache has fallback data (FAQs, emergency numbers)
3. Ensure flutter_tts works offline (test in airplane mode)
4. Check if Supabase calls have try-catch with offline fallback
5. Show friendly "No internet" banner — not error screens
6. Queue failed API calls for retry when connection returns
```

---

### ♿ Accessibility & Localization

#### Fix Touch Targets Too Small
```
Some buttons/icons are hard to tap. Please:
1. Audit all interactive elements — minimum 48x48dp tap area
2. Use InkWell/GestureDetector with minimum Size(48, 48)
3. Check icon buttons — wrap with padding if needed
4. Verify on a real device with finger tapping
5. Pay special attention to: OTP boxes, chips, back arrows, close buttons
```

#### Fix Language Strings
```
Some text is showing in English instead of user's language. Please:
1. Check if all user-facing strings go through our localization system
2. Verify the [language] key exists in our string maps
3. Check for hardcoded English strings — replace with localized versions
4. Test: switch language to Hindi → all UI should update
5. Check text expansion — Hindi is 20-30% longer than English
```

---

### 🧪 Testing

#### Test a Complete Flow
```
Test the complete [feature] flow:
1. Start from [starting point]
2. Go through each step
3. Verify each screen renders correctly (check dark/light mode)
4. Check state updates properly (add debug prints)
5. Test error cases (no internet, invalid input, permission denied)
6. Report any issues found and fix them
```

#### Run Full Smoke Test
```
Run a complete smoke test of the app:
1. Fresh install → Splash screen shows → Welcome screen loads
2. Onboarding: Get Started → Auth → Phone/OTP → Language → Profile → Home
3. Home: Greeting shows → Mic button works → Chips scroll
4. Voice: Tap mic → records → transcribes → response plays
5. Services: Browse service cards → tap → detail screen loads
6. Profile: View profile → edit name → save → persists
7. Offline: Enable airplane mode → app still shows cached content
8. Report all failures and fix critical ones immediately
```

#### Add Missing Feature
```
We're missing [feature] from the PRD. Please:
1. Review FINAL_PRD.md for the requirement
2. Check UI_UX.md for the design specifications
3. Look at IMPLEMENTATION_PLAN.md for technical guidance
4. Check the API table in PROMPT.md → "When to Use Each API" section for which APIs to use
5. Implement it following our existing patterns (Riverpod, Go Router, theme)
6. Add appropriate error handling
```

---

**Total Prompts:** ~55 prompts across 11 phases + 20+ quick fixes  
**Estimated Time:** 15-20 hours of focused vibe coding  
**Result:** Production-ready Sathio MVP

---

**Happy Vibe Coding! 🚀**

---

## ⚙️ PHASE 12: USER SETTINGS & ENGAGEMENT

### Prompt 12.1 — Profile & Settings Screen
```
Create the profile and settings screen:

1. lib/features/profile/profile_screen.dart:
   - Design: Clean, Luma-style (White/Silver background)
   - TopAppBar: "Profile & Settings" (no back button if on bottom nav)
   
   - Profile Header (Card):
     - Avatar (large, 80dp) with edit badge
     - Name (H2, Bold)
     - Phone number (Body, Gray)
     - "Edit Profile" button (Outlined pill)
   
   - Settings Sections (Grouped lists):
     
     Group 1: "App Experience"
     - Language Row:
       - Icon: Globe
       - Label: "App Language"
       - Value: Current Language (e.g., "Hindi")
       - Action: Tap -> Open Language Selection Dialog (Prompt 2.6)
     
     - Voice Settings Row:
       - Icon: Mic
       - Label: "Voice Settings"
       - Action: Tap -> Expand or open details
         - Speed Slider (0.75x - 1.25x)
         - Toggle: "Auto-detect Language" (Switch)
         - Toggle: "Read Responses Automatically" (Switch)
     
     Group 2: "Account"
     - "Your Interests" (Tap -> Open Interest Selection Prompt 2.8)
     - "Saved Documents" (DigiLocker integration placeholder)
     - "Sign Out" (Red text)
     
     Group 3: "Support"
     - "Help & FAQ" (Tap -> Open Help Screen Prompt 7.3)
     - "Privacy Policy"
     - "App Version" (v1.0.0)

2. lib/features/profile/profile_provider.dart:
   - User profile data (from Hive/Supabase)
   - Settings state (language, voice speed, flags)
   - Methods: updateProfile, updateSetting, logout
   
   - On Language Change:
     - Update 'currentLanguage' provider
     - Persist to Hive
     - Trigger app-wide rebuild (or at least reload strings)
     - Show confirmation toast: "Language changed to [Lang]"

3. Connect to Home Screen "Profile" icon/avatar tap.
```

### Prompt 12.2 — Notification System
```
Create robust notification architecture:

1. lib/services/notifications/notification_service.dart:
   - Singleton or Riverpod provider
   - Dependencies: firebase_messaging, flutter_local_notifications
   
   - setup():
     - Request permissions (sound, alert, badge)
     - Get FCM token (print for debug)
     - Initialize local notifications (channel settings)
     - Handle background/terminated state messages
     - Handle foreground messages (show local notification)
   
   - showLocalNotification(RemoteMessage message):
     - Display title, body
     - Payload functionality for deep linking
   
2. lib/features/notifications/notification_screen.dart:
   - TopAppBar: "Notifications" / "Suchnaein"
   - List of notifications (persisted in Hive or fetched from Supabase)
   - Grouped by: Today, Yesterday, Earlier
   - Notification Item:
     - Icon (based on type: Update, Alert, Tip)
     - Title & Body
     - Time ago
     - Tap -> Action (e.g., open scheme details)
   - Empty state: "Koi nayi suchna nahi hai"
   - "Mark all as read" action

3. lib/services/notifications/notification_provider.dart:
   - Manages list of notifications
   - Unread count
   - Methods: markAsRead, delete, clearAll

4. Integration:
   - Call setup() in main.dart
   - Listen for token refresh -> update Supabase 'users' table
   - Handle 'click_action' payload for routing
```

### Prompt 12.3 — Permissions System
```
Implement contextual permission handling:

1. android/app/src/main/AndroidManifest.xml — Add ALL permissions:

   <!-- Auto-granted (no dialog) -->
   <uses-permission android:name="android.permission.INTERNET" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   <uses-permission android:name="android.permission.VIBRATE" />

   <!-- Runtime permissions (dialog required) -->
   <uses-permission android:name="android.permission.RECORD_AUDIO" />
   <uses-permission android:name="android.permission.CAMERA" />
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
   <uses-permission android:name="android.permission.READ_SMS" />
   <uses-permission android:name="android.permission.RECEIVE_SMS" />

   <!-- Notifications (API 33+) -->
   <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

   <!-- Storage (pre-API 29 only, scoped storage handles modern) -->
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
                    android:maxSdkVersion="28" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"
                    android:maxSdkVersion="28" />

   <!-- LAM / Accessibility (special — user enables manually) -->
   <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
   <!-- BIND_ACCESSIBILITY_SERVICE declared via <service> tag -->

2. lib/services/permissions/permission_service.dart:
   - Uses permission_handler package
   - Methods:
     - requestMicrophone() -> bool
     - requestCamera() -> bool
     - requestLocation() -> bool
     - requestNotifications() -> bool
     - requestSmsRead() -> bool
     - isAccessibilityEnabled() -> bool
     - openAccessibilitySettings()
     - isOverlayEnabled() -> bool
     - openOverlaySettings()

3. Permission Request Strategy (NEVER ask all upfront):

   ON HOME SCREEN FIRST LAUNCH:
   - Microphone (Required — show explanation first)
   - Notifications (Optional — POST_NOTIFICATIONS on API 33+)

   ON FIRST LAM TASK (user says "Aadhaar download karo"):
   - Accessibility Service → Guide user to Settings with tutorial
   - Overlay Permission → SYSTEM_ALERT_WINDOW for floating pill

   ON CAMERA TAP (Profile avatar or bill scan):
   - Camera permission

   ON LOCAL SCHEME SEARCH:
   - Location (coarse only)

   ON OTP AUTO-READ (during LAM form filling):
   - SMS Read permission (opt-in, explain why)

4. lib/shared/widgets/dialogs/permission_dialog.dart:
   - Luma-style bottom sheet (not system dialog)
   - Shows BEFORE system permission dialog:
     - Icon matching the permission (mic, camera, etc.)
     - Title: "Sathio ko sunne do" (for mic)
     - Description: Why this permission helps
     - "Allow" button (black pill) → triggers system dialog
     - "Not Now" link → graceful fallback

5. lib/features/lam/accessibility_guide_screen.dart:
   - Step-by-step visual guide to enable Accessibility Service
   - Screenshots showing: Settings → Accessibility → Sathio → Enable
   - "Open Settings" button (deep links to accessibility settings)
   - Check status on return to app

6. Fallback Behavior (when permission denied):
   - Mic denied → Show text input keyboard
   - Camera denied → Manual bill number entry
   - Location denied → Manual state/district from profile
   - SMS denied → Manual OTP entry (always works)
   - Notifications denied → No push alerts (app still works)
   - Accessibility denied → Cannot use LAM, show explainer
```

---

**Happy Vibe Coding! 🚀**
