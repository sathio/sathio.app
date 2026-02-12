# SATHIO — UI/UX DESIGN SYSTEM (v3.0 — Luma-Inspired)

**Version:** 3.0  
**Date:** February 12, 2026  
**Purpose:** Comprehensive Design Guidelines  
**Audience:** Designers, Frontend Developers, Product Team  
**Design Reference:** [Luma iOS Onboarding Flow](https://mobbin.com/flows/24035767-44e2-4688-8869-e891996fabc2)

> **Previous versions:** v1.0 (Teal + Cat Logo) archived. This version reflects the Luma-inspired dark-mode-first premium design with the new orange squircle logo.

---

## 1. DESIGN PHILOSOPHY

### Design Reference: Luma iOS App

Sathio's UI/UX is inspired by the **Luma iOS app** — clean, minimal, premium:
- Effortless onboarding — guided signup, verification, profile, discovery
- Dark mode first — sophisticated dark backgrounds with crisp contrast
- Smooth micro-animations — subtle transitions, scale effects, fade reveals
- Card-based layout — content in soft-rounded cards
- Minimal chrome — content takes center stage

### Core Principles

| Principle | Implementation |
|-----------|----------------|
| **Premium & Clean** | Dark backgrounds (#0D0D0D), crisp white/orange text, subtle glassmorphism |
| **Warm & Trustworthy** | Saffron orange (#F58220) accents from logo, rounded corners, friendly tone |
| **Voice First** | Prominent mic interaction, animated voice states, minimal typing |
| **Minimal & Focused** | One action per screen, clean hierarchy, no clutter |
| **Alive & Responsive** | Micro-animations on every interaction, smooth page transitions |
| **Accessible** | High contrast, 48dp+ touch targets, vernacular text |
| **Personal** | Addresses user by name, remembers preferences |

### Design Mantras

> **"Premium, Warm, and Alive — like a trusted companion that knows your language."**

> **"If Ramesh can't understand it in 3 seconds, redesign it."**

> **"Design for 2GB RAM phones. Dark mode saves battery."**

---

## 2. BRAND IDENTITY

### Logo

**Logo:** Orange gradient squircle with white circle containing a 4-pointed star (sparkle)

| Element | Detail |
|---------|--------|
| **Outer Shape** | Squircle with organic, flowing curves |
| **Gradient** | Warm saffron orange → lighter orange at edges |
| **Inner** | White circle with 4-pointed star (sparkle/compass) in solid orange |

### Logo Usage

| Context | Specification |
|---------|---------------|
| App Icon | Full squircle logo |
| In-App Header | "Sathio" text in Inter Bold |
| Splash Screen | Centered logo with scale-in animation |
| Favicon/Small | Star sparkle only (inner element) |
| Marketing | Logo + "Main hoon na" tagline |

---

## 3. COLOR PALETTE

### Primary Colors (From Logo)

| Color | Hex | Usage |
|-------|-----|-------|
| **Sathio Orange** | `#F58220` | Primary brand, CTAs, active states |
| **Orange Light** | `#F7A94B` | Gradients, highlights |
| **Orange Deep** | `#E06B10` | Pressed states, emphasis |

### Dark Theme (Default)

| Color | Hex | Usage |
|-------|-----|-------|
| **Background** | `#0D0D0D` | Primary background |
| **Surface** | `#1A1A1A` | Cards, modals |
| **Surface Elevated** | `#252525` | Hover states |
| **Border** | `#2A2A2A` | Subtle dividers |
| **Text Primary** | `#FFFFFF` | Headings |
| **Text Secondary** | `#A0A0A0` | Subtitles |
| **Text Tertiary** | `#666666` | Placeholders |

### Light Theme

| Color | Hex | Usage |
|-------|-----|-------|
| **Background** | `#FAFAFA` | Primary background |
| **Surface** | `#FFFFFF` | Cards, modals |
| **Border** | `#E8E8E8` | Subtle dividers |
| **Text Primary** | `#111111` | Headings |
| **Text Secondary** | `#666666` | Subtitles |

### Semantic Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Success** | `#22C55E` | Completion, validation |
| **Error** | `#EF4444` | Errors, warnings |
| **Info** | `#3B82F6` | Links, badges |
| **Warning** | `#F59E0B` | Caution states |

### Color Accessibility
- White on `#0D0D0D` → 21:1 (WCAG AAA ✅)
- `#F58220` on `#0D0D0D` → 4.8:1 (WCAG AA ✅)
- `#111111` on `#FAFAFA` → 19.2:1 (WCAG AAA ✅)

---

## 4. TYPOGRAPHY

### Font Family
**Primary:** **Inter** (Google Fonts)  
**Alternative:** **Outfit** (Google Fonts)  
**Indian Scripts:** Noto Sans family (Devanagari, Tamil, Bengali, Telugu, Kannada, Gujarati, Gurmukhi, Malayalam, Oriya)  
**Fallback:** System default, Roboto

### Type Scale

| Level | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| Display | 36px | Bold (700) | 1.2 | Splash, hero |
| H1 | 28px | Bold (700) | 1.3 | Screen titles |
| H2 | 22px | SemiBold (600) | 1.35 | Section headers |
| H3 | 18px | SemiBold (600) | 1.4 | Card titles |
| Body Large | 16px | Medium (500) | 1.5 | Important body |
| Body | 14px | Regular (400) | 1.5 | Default text |
| Button | 14px | SemiBold (600) | 1.0 | CTA labels |
| Caption | 12px | Regular (400) | 1.4 | Helper text |
| Overline | 10px | SemiBold (600) | 1.6 | Labels, badges |

### Typography Rules
- Support system font size up to 200%
- Use Noto Sans variants for Indian scripts
- Maximum 65 characters per line
- No all caps (difficult for Indic scripts)

---

## 5. ICONOGRAPHY

### Icon Style

| Attribute | Specification |
|-----------|---------------|
| Library | Phosphor Icons (primary) + Material Icons (fallback) |
| Style | Outlined, rounded, modern |
| Size | 24x24dp (default), 32x32dp (navigation) |
| Touch Target | 48x48dp minimum |
| Color | White (dark mode), Dark gray (light mode), Orange (active) |

### Core Icons
🎤 Mic, 🏠 Home, 🔍 Search, ⚙️ Settings, 👤 Profile, 📋 Services, ⚡ Utilities, 💊 Health, 📚 Education, 🔔 Notifications, ← Back, ✓ Success

---

## 6. COMPONENT LIBRARY

### 6.1 Buttons

**Primary Button:**
- Background: Orange gradient (`#F58220` → `#F7A94B`)
- Text: White, Inter SemiBold 14px
- Shape: Pill (radius 100px)
- Height: 52px
- Shadow: `0 4px 16px rgba(245, 130, 32, 0.3)`
- Press: Scale 0.97

**Secondary Button:**
- Background: `#1A1A1A` (dark) / `#FFFFFF` (light)
- Border: `1px solid #2A2A2A`
- Shape: Pill, Height: 48px

**Mic Button (Hero):**
- Size: 64x64dp, Circular
- Background: Orange gradient
- Icon: White mic, 28x28dp
- Animation: Breathing pulse (idle), Waveform (listening)
- Shadow: Orange glow

### 6.2 Cards
- Background: `#1A1A1A` / `#FFFFFF`
- Radius: 16px
- Border: `1px solid #2A2A2A` / `1px solid #E8E8E8`
- Padding: 16px
- Selection: `2px solid #F58220` + subtle orange glow
- Press: Scale 0.98

### 6.3 Input Fields
- Background: `#1A1A1A` / `#FFFFFF`
- Border: `1px solid #2A2A2A`, Focus: `#F58220`
- Radius: 12px
- Height: 52px
- Padding: 16px

### 6.4 Chips & Tags
- Background: `#252525` / `#F0F0F0`
- Radius: 8px
- Padding: 6px 12px
- Active: Orange bg, white text

### 6.5 Bottom Sheet
- Background: `#1A1A1A` / `#FFFFFF`
- Top handle: 40x4px bar
- Radius: 24px (top corners)
- Animation: Spring slide-up

---

## 7. LAYOUT SYSTEM

### Screen Architecture (Luma-Inspired)
- Full-screen dark background (no split-screen)
- Floating content cards
- Sticky minimal header
- Bottom-aligned primary CTAs
- No bottom tab bar (Luma-style single-purpose screens)

### Spacing Tokens

| Token | Value |
|-------|-------|
| xs | 4px |
| sm | 8px |
| md | 16px |
| lg | 24px |
| xl | 32px |
| 2xl | 48px |

### Corner Radii

| Token | Value | Usage |
|-------|-------|-------|
| sm | 8px | Tags, badges |
| md | 12px | Inputs, small cards |
| lg | 16px | Primary cards |
| xl | 24px | Bottom sheets |
| pill | 100px | Buttons, search bars |

---

## 8. KEY SCREENS

### 8.1 Splash Screen
- Background: `#0D0D0D`
- Center: Sathio logo (100x100dp) with fade+scale animation
- "Sathio" in white, Inter Bold, fades in after logo
- "Main hoon na" in `#A0A0A0`, fades in after title
- Duration: 2 seconds, smooth fade-out

### 8.2 Onboarding (Luma-Style — LIGHT backgrounds)

> **IMPORTANT:** Onboarding uses LIGHT backgrounds with BLACK pill buttons.
> Dark mode begins only on the Home Screen.

**Welcome Screen:**
- Soft pastel gradient background (`#F8F0FF` → `#E8F4FD` → `#FFF8F0`)
- Floating 3D icons orbiting a central sparkle (like Luma's emoji orbits)
- Icons: Phone, Government, Bills, Mic, Health, Education (in pastel circles)
- Concentric orbit lines: light gray `#E8E8E8`
- "sathio✦" logo + "Aapka Digital Saathi" + "Yahan Se Shuru Karein" (orange)
- "Get Started" — black pill button (`#111111`)

**Auth Bottom Sheet:**
- White sheet slides up over blurred welcome illustration
- Sparkle icon + Close "X"
- "Shuru Karein" title + description
- "Continue with Phone" — black pill
- "Continue with Google" — light gray pill (`#F5F5F5`)
- "Continue as Guest" — text link

**Phone Input:**
- White bg, back arrow, gray phone icon in `#F5F5F5` circle
- "+91" prefix + large input, auto-focus number pad
- "Skip for now" text link, "Next" black pill

**OTP Verification:**
- White bg, gray chat bubble icon
- 6 individual digit boxes (48x56dp, `#F5F5F5` bg, 12px radius)
- Auto-advance, paste, auto-submit
- "Next" black pill

**Language Selection:**
- 3-column grid, white cards, orange border on selection
- Voice preview on tap

**Profile Setup:**
- Pastel gradient header (25%), white content area (75%)
- Avatar with camera badge, name + state form
- "Continue" black pill

**Interest Selection:**
- 2-column emoji cards, multi-select, orange border on selection
- "Shuru Karein" black pill

**Voice Demo:**
- Centered sparkle + black mic button (80x80dp)
- Permission request on tap, success animation
- → Home (onboarding complete, stored in Hive)

### 8.3 Home Screen
- Dark background, full-screen immersive
- Top: Language pill (left), settings + profile (right)
- Greeting: Time-based "Namaste [Name]!" in H1 white
- Search bar: Pill shape, `#1A1A1A`, mic icon (orange)
- Quick chips: Horizontal scroll (Aadhaar, Bill Pay, etc.)
- Recent activity: Card list
- Floating mic: Bottom center, 64x64, orange, breathing pulse

### 8.4 Listening Overlay
- Full overlay: `rgba(0,0,0,0.85)`
- Center: Animated waveform (orange bars)
- Text: "Sun raha hoon..." → "Samajh raha hoon..."
- Tap to cancel

### 8.5 Response Screen
- Response card slides up from bottom
- Typewriter text animation + TTS
- Play/speed controls
- Follow-up mic button

---

## 9. ANIMATIONS & MICRO-INTERACTIONS

> **Packages:** flutter_animate + Lottie + animations (OpenContainer)
> **Rule:** Every animation serves a purpose. Respect reduced motion settings.

### 9.1 Page Transitions

| Transition | Style | Duration | Curve |
|------------|-------|----------|-------|
| Forward | Shared Axis fade-through | 300ms | easeOutCubic |
| Back | Reverse shared axis | 250ms | easeInCubic |
| Bottom Sheet | Spring slide-up | 400ms | elasticOut |
| Modal | Scale 0.9→1.0 + fade | 250ms | easeOutBack |
| Hero | Shared element morph | 350ms | fastOutSlowIn |
| Card→Detail | Container Transform (OpenContainer) | 350ms | fastOutSlowIn |

### 9.2 Onboarding Entry Sequence
```
0ms:   Gradient bg fades in (600ms)
200ms: Sparkle scales in (spring) + rotation
400ms: Orbit circles draw in (800ms)
600ms: Floating icons appear staggered (100ms interval each)
1000ms: Logo fades in → headline slides up → subheadline → button
```
- Floating icons: sin/cos drift, 3-5s loop, staggered phase
- Auth sheet: spring slide-up, contents stagger in (100ms intervals)
- Between steps: slide-left exit (250ms) → slide-from-right enter (300ms)

### 9.3 Home Screen Entry
```
0ms:   Background white→dark fade (500ms)
200ms: Top bar items fade-slide down
400ms: Greeting typewriter (40ms/char)
800ms: Search bar slides up (easeOutBack)
1000ms: Chips stagger left→right (80ms interval)
1200ms: Cards stagger upward (100ms interval)
1400ms: Mic button bounces in (spring)
```
- Parallax greeting on scroll (0.5x speed, fades)
- Search bar: sticky, shrinks 56→48dp on scroll
- Pull-to-refresh: sparkle rotates → spins loading → checkmark

### 9.4 Card & Chip Interactions
- **Press:** scale 0.97, shadow shrinks (100ms)
- **Release:** scale 1.0, shadow returns with overshoot (150ms, easeOutBack)
- **Selection:** orange border fadeIn (200ms) + checkmark scale (300ms, spring)
- **Chip tap:** scale 0.95 → bounce → orange bg slides from left

### 9.5 Voice State Machine
```
IDLE → LISTENING → PROCESSING → SPEAKING → IDLE
```
| State | Animation |
|-------|-----------|
| Idle | Breathing glow (radius 8→16dp, 2s loop) |
| Listening | 5 waveform bars, height = amplitude (60fps) |
| Processing | Bars collapse → 3 bouncing dots (staggered 150ms) |
| Speaking | Typewriter (30ms/char) + soft waveform |
| Error | Shake [-8,8,-6,6,-3,0] + red flash |

### 9.6 Loading States
- **Skeleton shimmer:** Dark `#1A1A1A→#2A2A2A→#1A1A1A` / Light `#E8E8E8→#F5F5F5→#E8E8E8`
- **Content load-in:** crossFade (300ms) + staggered list items
- **Button loading:** orange spinner replaces text (24dp, 1.2s rotation)

### 9.7 Floating Mic FAB
- Scroll down: slides down + fades out (200ms)
- Scroll up: slides up + fades in (300ms, easeOutBack)
- Tap: scale 1.0→1.15→1.0 + haptic → listening state

### 9.8 Toasts & Celebrations
- **Success toast:** slide-down from top (300ms) + green accent + auto-dismiss 3s
- **Error toast:** slide-down + shake + red accent
- **Onboarding complete:** Lottie confetti (1.5s) + text scale overshoot
- **Achievement:** badge scales in (spring) + particle ring

### 9.9 Reduced Motion
- Check `MediaQuery.of(context).disableAnimations`
- When ON: all durations = 0, fades only, no parallax, static loading spinner

---

## 10. VOICE DESIGN

### Audio Cues

| Event | Sound | Duration |
|-------|-------|----------|
| Mic activated | Soft blip | 100ms |
| Recording started | Rising tone | 150ms |
| Success | Pleasant chime | 300ms |
| Error | Soft low tone | 200ms |

### TTS Guidelines
- Speed: 140 wpm (adjustable)
- Pauses: 0.5s between sentences
- Numbers: Spoken naturally
- All sounds user-disablable

---

## 11. ACCESSIBILITY

| Requirement | Implementation |
|-------------|----------------|
| Touch targets | 48x48dp minimum |
| Text scaling | Support 200% system font |
| Contrast | All text passes WCAG AA |
| Screen reader | Full TalkBack support |
| Reduced motion | Respects system setting |
| One-hand use | Critical actions in bottom 60% |
| Vernacular | All UI text in active language |

---

## 12. LOCALIZATION

### Language Support (All 22 Scheduled Languages)

| Phase | Languages |
|-------|-----------|
| MVP | Hindi, Bengali, Tamil, Marathi |
| Phase 2 | Telugu, Kannada, Gujarati, Punjabi |
| Phase 3 | Malayalam, Odia, Assamese, Urdu |
| Phase 4 | All remaining scheduled languages |

### Rules
- Never hardcode strings
- Account for 20-30% text expansion
- Indian date format (DD/MM/YYYY)
- Indian numbering (lakhs, crores)
- RTL-ready architecture

---

## 13. DESIGN TOKENS (Flutter/CSS Reference)

### Colors
```dart
// Primary
static const sathioOrange = Color(0xFFF58220);
static const orangeLight = Color(0xFFF7A94B);
static const orangeDeep = Color(0xFFE06B10);

// Dark Theme
static const darkBg = Color(0xFF0D0D0D);
static const darkSurface = Color(0xFF1A1A1A);
static const darkSurfaceElevated = Color(0xFF252525);
static const darkBorder = Color(0xFF2A2A2A);
static const darkTextPrimary = Color(0xFFFFFFFF);
static const darkTextSecondary = Color(0xFFA0A0A0);

// Light Theme
static const lightBg = Color(0xFFFAFAFA);
static const lightSurface = Color(0xFFFFFFFF);
static const lightBorder = Color(0xFFE8E8E8);
static const lightTextPrimary = Color(0xFF111111);
```

### Spacing
```dart
static const xs = 4.0;
static const sm = 8.0;
static const md = 16.0;
static const lg = 24.0;
static const xl = 32.0;
static const xxl = 48.0;
```

### Border Radius
```dart
static const radiusSm = 8.0;
static const radiusMd = 12.0;
static const radiusLg = 16.0;
static const radiusXl = 24.0;
static const radiusPill = 100.0;
```

---

## 14. TECHNICAL STACK

- **Framework:** Flutter (Android-first)
- **State Management:** Riverpod
- **Backend/Auth:** Supabase
- **Local Storage:** Hive
- **Typography:** Google Fonts (Inter + Noto Sans family)
- **Animations:** flutter_animate + Lottie
- **Icons:** Phosphor Icons + Material Icons

---

**Document Version:** 3.0  
**Last Updated:** February 12, 2026  
**Status:** Design System Ready (Luma-Inspired)

---

**END OF UI/UX DESIGN SYSTEM**
