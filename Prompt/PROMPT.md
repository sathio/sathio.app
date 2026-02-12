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
4. Read UI_UX.md - Design system, colors, typography, components, screens
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
1. Welcome (hero illustration) → 2. Get Started (bottom sheet auth) → 3. Phone/OTP → 4. Language Selection → 5. Profile Setup → 6. Interest Selection → 7. Voice Demo → 8. Permissions → 9. Home

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
```

### Prompt 2.9 — Voice Demo & Permissions
```
Create voice demo + permission screen (Step 7):

lib/features/onboarding/screens/voice_demo_screen.dart:

DESIGN — Simple, encouraging:

   Background: White / #FAFAFA
   
   Center content:
   - Sathio sparkle icon (64x64, orange gradient, subtle pulse)
   - Title: "Give it a Try!"
     - Inter Bold, 24px, #111111
   - Description: "Tap the mic and say: Hello Sathio"
     - Inter Regular, 16px, #666666
   
   Large mic button (center):
   - Size: 80x80dp, circular
   - Background: #111111 (black)
   - Icon: mic, white, 32dp
   - Tap → request mic permission (if not granted)
   - On permission granted → start listening
   - On speech recognized:
     - Show "Namaste! Main sun sakta hoon! 🎉" response
     - Success animation (Lottie checkmark)
   
   "Skip for now" text link below mic
   
   Bottom: "Aage Badhein" button (black pill)
   
   Permission flow:
   - Mic permission requested on first tap
   - If denied → friendly message, allow to skip
   - Notification permission: requested via system dialog after voice demo
   
After this → Navigate to Home (onboarding complete)
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
     - readScreen(Uint8List screenshot) → uses Gemini 1.5 Pro Vision
       - Sends screenshot image to Vision model
       - Returns: {elements: [...], currentScreen: "...", possibleActions: [...]}
   - All calls wrapped with dio, retry logic, and timeout (10s)
   - API key from: .env → GEMINI_API_KEY

3. Logic Flow (executeTask method):
   - Input: Goal (e.g., "Check PM Kisan Status")
   - Step 1: classifyIntent(goal) → Gemini Flash confirms it's an "action"
   - Step 2: planActions(goal) → Gemini Pro returns action steps
   - Step 3: Open Target App (android_intent_plus / Launch Intent)
   - Step 4: Loop per step:
     a. readScreen(screenshot) → Gemini Vision identifies UI elements
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

---

**Happy Vibe Coding! 🚀**
