# SATHIO — UI/UX DESIGN SYSTEM

**Version:** 3.0 (Luma-Inspired, Orange Brand)  
**Date:** February 12, 2026  
**Purpose:** Comprehensive Design Guidelines  
**Audience:** Designers, Frontend Developers, Product Team  
**Design Reference:** [Luma iOS Onboarding Flow](https://mobbin.com/flows/24035767-44e2-4688-8869-e891996fabc2)

---

## 1. DESIGN PHILOSOPHY

### Design Reference: Luma iOS App

Sathio's UI/UX is inspired by the **Luma iOS app** — a clean, minimal, premium design with:
- **Effortless onboarding** — guided signup, verification, profile, and landing on a discovery screen
- **Dark mode first** — sophisticated dark backgrounds with crisp contrast
- **Smooth micro-animations** — subtle transitions between screens, scale effects, and fade reveals
- **Modern card-based layout** — content organized in clean, rounded cards
- **Minimal chrome** — UI fades into the background, content takes center stage

### Core Principles

| Principle | Implementation |
|-----------|----------------|
| **Premium & Clean** | Dark backgrounds, crisp white/orange text, subtle glassmorphism |
| **Warm & Trustworthy** | Saffron orange accents from logo, rounded corners, friendly tone |
| **Voice First** | Prominent mic interaction, animated voice states, minimal typing |
| **Minimal & Focused** | One action per screen, clean hierarchy, no clutter |
| **Alive & Responsive** | Micro-animations on every interaction, smooth page transitions |
| **Accessible** | High contrast, large touch targets (48dp min), vernacular text |
| **Personal** | Addresses user by name ("Namaste Ayan"), remembers preferences |

### Design Aesthetics

> **"Premium, Warm, and Alive — like a trusted companion that knows your language."**
> Dark, polished surfaces with warm orange energy. Every interaction feels smooth and intentional.

---

## 2. BRAND IDENTITY

### Logo

**Logo:** Orange gradient squircle with white circle containing a 4-pointed star (sparkle)

| Element | Detail |
|---------|--------|
| **Outer Shape** | Squircle with organic, flowing curves |
| **Gradient** | Warm saffron orange → lighter orange at edges |
| **Inner** | White circle with 4-pointed star (sparkle/compass) in solid orange |
| **Style** | Modern, warm, approachable |

### Logo Usage
- **App Icon:** Full squircle logo (as provided)
- **In-App Header:** "Sathio" text in Inter Bold or Outfit Bold
- **Splash Screen:** Centered logo with subtle scale-in animation
- **Favicon/Small:** Star sparkle only (inner element)

---

## 3. COLOR PALETTE

### Primary Colors (Derived from Logo)

| Color | Hex | Usage |
|-------|-----|-------|
| **Sathio Orange** | `#F58220` | Primary brand, CTAs, active states, logo |
| **Orange Light** | `#F7A94B` | Gradients, highlights, secondary buttons |
| **Orange Deep** | `#E06B10` | Pressed states, emphasis |

### Dark Theme (Default — Luma-Inspired)

| Color | Hex | Usage |
|-------|-----|-------|
| **Background** | `#0D0D0D` | Primary background (near-black) |
| **Surface** | `#1A1A1A` | Cards, modals, elevated surfaces |
| **Surface Elevated** | `#252525` | Hover states, secondary cards |
| **Border** | `#2A2A2A` | Subtle dividers, card borders |
| **Text Primary** | `#FFFFFF` | Headings, primary text |
| **Text Secondary** | `#A0A0A0` | Subtitles, helper text, timestamps |
| **Text Tertiary** | `#666666` | Placeholders, disabled text |

### Light Theme

| Color | Hex | Usage |
|-------|-----|-------|
| **Background** | `#FAFAFA` | Primary background (warm white) |
| **Surface** | `#FFFFFF` | Cards, modals |
| **Surface Elevated** | `#F5F5F5` | Hover states |
| **Border** | `#E8E8E8` | Subtle dividers |
| **Text Primary** | `#111111` | Headings, primary text |
| **Text Secondary** | `#666666` | Subtitles |

### Semantic Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Success** | `#22C55E` | Completion, validation, checkmarks |
| **Error** | `#EF4444` | Errors, warnings, destructive actions |
| **Info** | `#3B82F6` | Links, informational badges |
| **Warning** | `#F59E0B` | Caution states (close to orange, use sparingly) |

### Accessibility
- White text on `#0D0D0D` → **21:1 contrast** (WCAG AAA ✅)
- Orange `#F58220` on `#0D0D0D` → **4.8:1 contrast** (WCAG AA ✅)
- Black text on `#FAFAFA` → **19.2:1 contrast** (WCAG AAA ✅)

---

## 4. TYPOGRAPHY

### Font Family
**Primary:** **Inter** (Google Fonts)  
**Alternative:** **Outfit** (Google Fonts)  
**Why:** Clean, modern, geometric, excellent readability at all sizes. Works well with Noto Sans for Indian scripts.

**Indian Script Fonts:** Noto Sans family (Devanagari, Tamil, Bengali, Telugu, Kannada, Gujarati, Gurmukhi, Malayalam, Oriya)

### Type Scale

| Level | Size | Weight | Line Height | Usage |
|-------|------|--------|-------------|-------|
| **Display** | 36px | Bold (700) | 1.2 | Splash greeting, hero text |
| **H1** | 28px | Bold (700) | 1.3 | Screen titles |
| **H2** | 22px | SemiBold (600) | 1.35 | Section headers |
| **H3** | 18px | SemiBold (600) | 1.4 | Card titles, subheaders |
| **Body Large** | 16px | Medium (500) | 1.5 | Prompts, important body text |
| **Body** | 14px | Regular (400) | 1.5 | Default body text |
| **Button** | 14px | SemiBold (600) | 1.0 | CTA labels |
| **Caption** | 12px | Regular (400) | 1.4 | Helper text, timestamps |
| **Overline** | 10px | SemiBold (600) | 1.6 | Labels, badges, status |

---

## 5. LAYOUT SYSTEM

### Screen Architecture (Luma-Inspired)

Unlike the previous split-screen design, the new layout follows Luma's **full-screen immersive** pattern:

1. **Full-Screen Dark Background** — content lives on a single dark canvas
2. **Floating Content Cards** — information presented in soft-rounded cards
3. **Sticky Header** — minimal top bar with back button + title + action
4. **Bottom-Aligned Actions** — primary CTAs anchored to bottom with safe area padding

### Grid & Spacing

| Token | Value | Usage |
|-------|-------|-------|
| `space-xs` | `4px` | Icon gaps, tight spacing |
| `space-sm` | `8px` | Inner card padding, tag spacing |
| `space-md` | `16px` | Card content padding, list item spacing |
| `space-lg` | `24px` | Section spacing, screen padding |
| `space-xl` | `32px` | Major section breaks |
| `space-2xl` | `48px` | Screen top/bottom safe areas |

### Corner Radii (Consistent Rounded Feel)

| Token | Value | Usage |
|-------|-------|-------|
| `radius-sm` | `8px` | Tags, badges, small elements |
| `radius-md` | `12px` | Input fields, small cards |
| `radius-lg` | `16px` | Primary cards, modals |
| `radius-xl` | `24px` | Bottom sheets, large cards |
| `radius-pill` | `100px` | Buttons, pills, search bars |

### Navigation

- **No Bottom Tab Bar** (Luma-style: single-purpose screens)
- **Back Arrow:** Top-left, icon only, no label
- **Primary Action:** Bottom-center pill button (full width with side padding)
- **Floating Mic Button:** Bottom-center, `64x64`, always visible on home

---

## 6. COMPONENT LIBRARY

### 6.1 Buttons

**Primary Button:**
- Background: Orange gradient (`#F58220` → `#F7A94B`)
- Text: White, Inter SemiBold 14px
- Shape: Pill (`radius-pill`)
- Height: `52px`
- Shadow: `0 4px 16px rgba(245, 130, 32, 0.3)`
- Press effect: Scale down to 0.97 + deeper shadow

**Secondary Button:**
- Background: `Surface` (`#1A1A1A` dark / `#FFFFFF` light)
- Border: `1px solid #2A2A2A`
- Text: White (dark) / Black (light)
- Shape: Pill
- Height: `48px`

**Ghost/Text Button:**
- Background: Transparent
- Text: Orange `#F58220`
- No border

**Social/Auth Buttons (Luma-style):**
- Background: White or `#1A1A1A`
- Icon: Google/Phone icon on left
- Text: "Continue with Google" / "Continue with Phone"
- Shape: Pill, full-width
- Height: `52px`
- Stacked vertically with `8px` gap

### 6.2 Input Fields

- Background: `#1A1A1A` (dark) / `#FFFFFF` (light)
- Border: `1px solid #2A2A2A` (dark) / `1px solid #E8E8E8` (light)
- Focus border: `#F58220` (orange glow)
- Radius: `radius-md` (12px)
- Padding: `16px`
- Height: `52px`
- Label: Above field, Caption size, `#A0A0A0`
- Placeholder: `#666666`

### 6.3 Cards

- Background: `#1A1A1A` (dark) / `#FFFFFF` (light)
- Radius: `radius-lg` (16px)
- Border: `1px solid #2A2A2A` (dark) / `1px solid #E8E8E8` (light)
- Padding: `16px`
- Shadow: None in dark mode / subtle in light mode
- Selection state: Orange border (`2px solid #F58220`) + subtle orange glow
- Press animation: Scale to 0.98

### 6.4 Voice Interaction Components

**Mic Button (Home — Always Visible):**
- Size: `64x64` dp
- Background: Orange gradient, circular
- Icon: Microphone (white)
- Position: Bottom-center, floating above safe area
- Animation: Subtle breathing pulse when idle

**Listening State (Full-Screen Overlay):**
- Background: Semi-transparent black overlay (`rgba(0,0,0,0.85)`)
- Center: Animated waveform / sound visualizer (orange curves)
- Text below: "Bol raha hoon... sun raha hoon" (listening text)
- Tap anywhere to cancel

**Processing State:**
- Waveform freezes → morphs into loading dots
- Text: "Samajh raha hoon..."

**Response State:**
- Response card slides up from bottom
- Text appears with typewriter animation
- TTS plays simultaneously
- Card has "Speak Again" and "OK" buttons

### 6.5 Chips & Tags

- Background: `#252525` (dark) / `#F0F0F0` (light)
- Text: `#A0A0A0` (dark) / `#666666` (light)
- Radius: `radius-sm` (8px)
- Padding: `6px 12px`
- Active state: Orange background, white text

### 6.6 Bottom Sheet

- Background: `#1A1A1A` (dark) / `#FFFFFF` (light)
- Top handle: `40x4px` centered bar, `#666666`
- Radius: `radius-xl` (24px) on top corners only
- Slides up with spring animation
- Backdrop: `rgba(0,0,0,0.5)` blur

### 6.7 Avatar System (Minimalist Cute Characters)

> **Style:** Soft pastel blob characters — round, kawaii-inspired, simple dot eyes, tiny smile.
> **Reference:** Like the lavender ghost-blob with camera icon from Luma.

**12 Default Avatars (Pre-built SVG/PNG):**

| # | Name | Color | Hex | Expression |
|---|------|-------|-----|------------|
| 1 | Gudiya | Lavender | `#C8B6FF` | Happy 😊 |
| 2 | Pappu | Soft Orange | `#FFB074` | Cheerful 😄 |
| 3 | Mithai | Mint Green | `#A8E6CF` | Calm 😌 |
| 4 | Neelu | Pastel Blue | `#89CFF0` | Curious 🤔 |
| 5 | Gulabi | Coral Pink | `#FF9AA2` | Surprised 😯 |
| 6 | Peelu | Soft Yellow | `#FFDAC1` | Sleepy 😴 |
| 7 | Rani | Peach | `#FFB7B2` | Winking 😉 |
| 8 | Tara | Teal | `#88D8B0` | Starry-eyed ✨ |
| 9 | Chandu | Soft Purple | `#B5A7E6` | Determined 😤 |
| 10 | Laddoo | Warm Gold | `#FFD700` | Laughing 😂 |
| 11 | Neel Kamal | Sky Blue | `#87CEEB` | Dreamy 💭 |
| 12 | Champa | Rose | `#E8A0BF` | Loving 🥰 |

**Avatar Design Spec:**
```
Shape: Soft blob/circle (not perfect circle — organic, slightly squishy)
Size: 80x80dp (profile), 40x40dp (home header), 120x120dp (profile edit)
Eyes: Two small dots (4-5dp), slightly above center
Mouth: Tiny curved line (varies by expression)
Body: Single solid pastel color with very subtle gradient (5% lighter at top)
Shadow: Soft drop shadow (0 2px 8px rgba(0,0,0,0.1))
Border: 2px white stroke around blob (creates depth against any background)
Camera badge: 20x20dp circle, #F5F5F5 bg, camera icon, bottom-right position
```

**Where Avatars Appear:**

| Screen | Avatar Use | Size |
|--------|-----------|------|
| **Onboarding Profile** | Selected avatar shown above form, camera badge to change | 120x120dp |
| **Home Screen** | Top-right corner, greeting area, tappable → profile | 40x40dp |
| **Profile Screen** | Large, centered below header gradient, edit badge | 100x100dp |
| **Settings** | Small, next to user name | 36x36dp |

**Avatar Selection Flow (Onboarding 7.7 & Profile Edit):**
- Tap avatar/camera badge → bottom sheet slides up
- Sheet contains: 4×3 grid of all 12 avatars (scrollable if needed)
- Each avatar: 64x64dp in grid, tap to select
- Selected: orange border (`2px #F58220`) + checkmark overlay
- "Take Photo" option at top (opens camera) — custom photo crops to circle
- "Choose Avatar" label above grid
- Confirm button ("Done" black pill)

**Default Assignment:**
- First-time user gets random avatar from the 12
- Stored in Hive (`user_avatar_index`) and synced to Supabase profile
- Custom photo stored in Supabase Storage → URL cached locally

---

## 7. USER FLOWS (Luma-Inspired Onboarding)

> **IMPORTANT:** Onboarding uses **LIGHT backgrounds** (not dark mode!) with **black pill buttons** — matching Luma's warm, inviting welcome flow. Dark mode kicks in only after onboarding, on the Home screen.

### 7.1 Splash Screen
- **Background:** `#0D0D0D` (dark — only screen that's dark in onboarding)
- **Center:** Sathio logo (orange squircle), 100x100dp
- **Animation:** Fade in (500ms) → scale 0.8→1.0 (300ms) → "Sathio" text fades in → tagline fades in
- **Tagline:** "Main hoon na" in `#A0A0A0`, Inter Regular
- **Duration:** 2 seconds → smooth fade-out transition

### 7.2 Welcome Screen (Luma Hero)
- **Background:** Soft pastel gradient — `#F8F0FF` → `#E8F4FD` → `#FFF8F0` (NOT dark!)
- **Hero illustration (upper 60%):**
  - Central sparkle logo (4-pointed star, orange gradient, 80x80dp)
  - Concentric orbit circles (light gray `#E8E8E8`, 1px stroke)
  - Floating 3D icons orbiting the sparkle (like planets):
    - 📱 Phone, 🏛️ Government, 💡 Bills, 🎤 Mic, 💊 Health, 📚 Education
    - Each in a soft pastel-colored circle (purple, blue, green, pink)
    - Gentle drift animation (slow up/down, 3-4s loop, staggered)
- **Text below:**
  - "sathio✦" logo (Inter Bold 20px, `#333333`)
  - "Aapka Digital Saathi" (Inter Bold 28px, `#111111`)
  - "Yahan Se Shuru Karein" (Inter SemiBold 22px, `#F58220` orange)
- **Button:** "Get Started" — full-width black pill (`#111111`, white text, 56dp)

### 7.3 Auth Bottom Sheet (Luma-Style)
- Welcome illustration stays visible (slightly blurred)
- **White bottom sheet** slides up with spring animation
- **Sheet contents:**
  - Sparkle icon (40x40, gray) + Close "X" button
  - "Shuru Karein" title (Inter Bold 24px `#111111`)
  - Description text (Inter Regular 14px `#666666`)
  - **"Continue with Phone"** — black pill (`#111111`)
  - **"Continue with Google"** — light gray pill (`#F5F5F5`, border `#E0E0E0`)
  - **"Continue as Guest"** — text link (`#666666`)
- Sheet: white bg, 24px top radius, handle bar

### 7.4 Phone Input (Luma-Style)
- **Background:** White `#FAFAFA`
- **Back arrow:** Simple ← icon, top-left, no circle
- **Section icon:** Gray phone icon in `#F5F5F5` circle (40x40dp)
- **Title:** "Apna Phone Number Daalein" (Inter Bold 24px)
- **Input:** `#F5F5F5` bg, 16px radius, "+91" prefix, auto-focus, number pad
- **"Skip for now"** text link (Inter Medium 14px `#666666`)
- **"Next" button:** Black pill, disabled until 10 digits

### 7.5 OTP Verification (Luma-Style)
- Same light bg + back arrow pattern
- **Section icon:** Gray chat bubble in `#F5F5F5` circle
- **Title:** "Code Daalein"
- **6 OTP boxes:** 48x56dp each, `#F5F5F5` bg, 12px radius, Inter Bold 28px
- Auto-focus, auto-advance, paste support, auto-submit when complete
- **"Next" button:** Black pill, disabled until all 6 digits

### 7.6 Language Selection
- Clean white bg, back arrow, globe icon
- **3-column card grid** (scrollable)
- Cards: white bg, 1px `#E8E8E8` border, 16px radius, 80dp height
- Selected: 2px `#F58220` orange border, `#FFF5EB` bg tint, checkmark
- Tap: plays voice preview
- "Continue" black pill button

### 7.7 Profile Setup (Luma-Style)
- **Top 25%:** Pastel gradient (like welcome screen but lighter), subtle star pattern
- **Avatar:** 80x80dp, overlapping gradient/white boundary, camera badge
- **Title:** "Apni Profile Banaein" (center-aligned)
- **Form:** Name input (underline style), State dropdown (searchable)
- **"Baad mein karein"** skip link + **"Continue"** black pill

### 7.8 Interest Selection
- White bg, 2-column card grid
- Cards: emoji + title, white bg, 1px `#E8E8E8` border, 16px radius
- Selected: orange border + `#FFF5EB` bg
- Multi-select, "Shuru Karein" black pill

### 7.9 Voice Demo & Permissions
- White bg, centered sparkle icon (orange, 64x64dp)
- "Ek Baar Try Karein!" title
- Black mic button (80x80dp) — requests mic permission
- Speech response + Lottie checkmark on success
- "Skip for now" + "Aage Badhein" black pill → **Home** (onboarding complete)

### 7.10 Home Screen (Dark Mode Begins)
- **Background:** `#0D0D0D` (dark mode starts here)
- **Top:** Language pill (left), Settings + Profile (right)
- **Greeting:** Time-based "Namaste [Name]!" (H1, white)
- **Search/Voice Bar:** Pill `#1A1A1A`, mic icon orange
- **Quick Actions:** Horizontal scrollable chips (`#252525` bg)
- **Recent Activity:** Card list (`#1A1A1A` bg, `#2A2A2A` border)
- **Floating Mic:** Bottom-center, 64x64, orange gradient, breathing pulse

---

## 8. ANIMATIONS & MICRO-INTERACTIONS

> **Package:** `flutter_animate` for declarative animations + `Lottie` for complex illustrations.
> **Principle:** Every animation must serve a purpose — inform, delight, or guide. Never animate just to animate.

### 8.1 Page Transitions (Luma-Inspired)

| Transition | Style | Duration | Curve | When Used |
|------------|-------|----------|-------|-----------|
| **Forward** | Shared Axis (vertical fade-through) | 300ms | `Curves.easeOutCubic` | Onboarding steps, screen push |
| **Back** | Reverse shared axis | 250ms | `Curves.easeInCubic` | Back navigation |
| **Bottom Sheet** | Slide up + spring physics | 400ms | `Curves.elasticOut` (damping: 0.8) | Auth sheet, options |
| **Modal** | Scale from center (0.9→1.0) + fade | 250ms | `Curves.easeOutBack` | Dialogs, alerts |
| **Tab Switch** | Cross-fade (no slide) | 200ms | `Curves.easeInOut` | Tab bar content swap |
| **Hero** | Shared element morph | 350ms | `Curves.fastOutSlowIn` | Card → detail, avatar expand |

**Container Transform (Premium Feel):**
- Card taps → card morphs into full-screen detail (Material 3 container transform)
- Service card → Service detail screen
- Profile avatar → Profile edit screen
- Uses `OpenContainer` from `animations` package

### 8.2 Onboarding Animations (Luma Hero)

**Welcome Screen:**
```
Entry sequence (staggered, auto-plays on screen load):
├─ 0ms:    Background gradient fades in (opacity 0→1, 600ms)
├─ 200ms:  Central sparkle scales in (0→1, spring, 500ms) + rotation 0→360°
├─ 400ms:  Orbit circles draw in (stroke-dasharray, 800ms)
├─ 600ms:  Floating 3D icons appear one by one (100ms interval)
│          Each: fadeIn + scale(0.5→1.0) + slideY(20→0)
├─ 1000ms: Logo text fades in (300ms)
├─ 1200ms: Headline slides up + fades in (400ms, easeOutCubic)
├─ 1400ms: Subheadline slides up + fades in (400ms)
└─ 1600ms: Button slides up from bottom (500ms, easeOutBack)
```

**Floating Icons (Perpetual):**
- 6 icons drift gently in orbits around sparkle
- Each has unique: amplitude (8-15dp), speed (3-5s), phase offset
- Uses `sin(time)` and `cos(time)` for organic floating
- Subtle shadow follows each icon (depth illusion)

**Auth Bottom Sheet:**
- Trigger: "Get Started" button tap
- Welcome bg: blur(10) + dim(0.3) over 300ms
- Sheet: spring slide-up (400ms, elasticOut, damping 0.75)
- Sheet contents stagger in: icon (0ms) → title (100ms) → desc (200ms) → buttons (300ms, 100ms each)
- Dismiss: reverse spring (250ms) + background un-blur

**Between Onboarding Steps:**
- Exit: current screen slides left + fades out (250ms)
- Enter: new screen slides from right + fades in (300ms)
- Back: reverse direction

### 8.3 Home Screen Animations

**Entry (first load after onboarding):**
```
├─ 0ms:    Screen background fades from white → dark (#0D0D0D, 500ms)
├─ 200ms:  Top bar items fade-slide down (language pill, settings)
├─ 400ms:  Greeting text types out letter-by-letter ("N-a-m-a-s-t-e, Kaushal!")
│          Speed: 40ms/char, cursor blink at end
├─ 800ms:  Search bar slides up from bottom + fades in (400ms, easeOutBack)
├─ 1000ms: Quick action chips stagger in left→right (80ms interval each)
│          Each: fadeIn + slideX(-20→0, 300ms)
├─ 1200ms: Recent activity cards stagger upward (100ms interval)
│          Each: fadeIn + slideY(30→0, 400ms)
└─ 1400ms: Floating mic button bounces in from bottom (500ms, spring)
```

**Scroll Interactions:**
- Greeting text: parallax effect — scrolls at 0.5x speed, fades as you scroll
- Search bar: sticky — shrinks from 56dp→48dp on scroll, background becomes more opaque
- Quick chips: sticky below search bar
- Floating mic: hides when keyboard open, shows on scroll-up (slide + fade, 200ms)

**Pull-to-Refresh:**
- Overscroll: orange Sathio sparkle appears at top (scale 0→1)
- Pull threshold: sparkle rotates with pull distance
- Release: sparkle spins fast (loading) → checkmark morphs in → bounce dismiss

### 8.4 Card & Chip Interactions

**Card Tap (Service Cards, Interest Cards):**
```dart
// flutter_animate syntax
card.animate()
  .scaleXY(end: 0.97, duration: 100.ms, curve: Curves.easeIn)
  .then()
  .scaleXY(end: 1.0, duration: 150.ms, curve: Curves.easeOutBack);
```
- Press down: scale 0.97 + shadow shrinks (100ms)
- Release: scale 1.0 + shadow returns with overshoot (150ms, easeOutBack)
- Selection: border fades to orange (200ms) + checkmark scales in (300ms, spring)
- Deselection: reverse (200ms)

**Chip Tap (Quick Actions):**
- Press: scale 0.95 + background darkens slightly
- Release: scale 1.0 + tiny bounce
- Active state: orange bg slides in from left (200ms)

**Card Long-Press (Future — Context Menu):**
- Scale to 0.95 → haptic feedback → context menu fades in above

### 8.5 Voice Interaction Animations

**Mic Button State Machine:**
```
IDLE ──tap──→ LISTENING ──stop──→ PROCESSING ──done──→ SPEAKING ──end──→ IDLE
  │                │                    │                  │
  └─breathing      └─waveform           └─morphing         └─typewriter
    pulse             bars                dots               + waveform
```

| State | Animation | Details |
|-------|-----------|---------|
| **Idle** | Breathing glow | Orange shadow pulses: `radius 8→16→8dp`, opacity `0.3→0.5→0.3`, 2s loop |
| **Listening** | Live waveform | 5 bars, height varies with `AudioRecorder.amplitude`, range 8-40dp, orange gradient, 60fps |
| **Processing** | Morphing dots | Waveform bars collapse → 3 bouncing dots (staggered 150ms), scale 0.5→1.0 loop |
| **Speaking** | Typewriter + wave | Response text: char-by-char (30ms/char). Soft waveform below (lower amplitude, TTS output) |
| **Error** | Shake + flash | Mic button: translateX [-8, 8, -6, 6, -3, 0] (300ms) + red flash overlay |

**Full-Screen Listening Overlay:**
- Entry: black overlay fades in (`rgba(0,0,0,0.9)`, 300ms) + waveform scales up from mic position
- Real-time: waveform bars animate with audio amplitude
- Cancel: tap anywhere → overlay fades out (200ms) + mic button returns to normal

### 8.6 Loading & Skeleton States

**Skeleton Shimmer (Luma-style):**
```dart
Container(color: Color(0xFF1A1A1A))
  .animate(onPlay: (c) => c.repeat())
  .shimmer(
    duration: 1200.ms,
    colors: [Color(0xFF1A1A1A), Color(0xFF2A2A2A), Color(0xFF1A1A1A)],
    angle: 0.5,
  );
```
- Applied to: cards, text blocks, avatars while loading
- Direction: left-to-right sweep
- Dark mode shimmer: `#1A1A1A → #2A2A2A → #1A1A1A`
- Light mode shimmer: `#E8E8E8 → #F5F5F5 → #E8E8E8`

**Content Load-In (after data fetches):**
- Skeleton → real content: crossFade (300ms)
- Each item in a list: staggered fadeIn + slideY (100ms interval)

**Circular Progress:**
- Orange ring (`#F58220`), 2dp stroke, 24dp diameter
- Rotates 360° per 1.2s
- Used in buttons (replaces text during loading)

### 8.7 Navigation Bar Animations

> Sathio doesn't have a traditional tab bar — it uses a minimal top bar + floating mic. But for settings/profile nav:

**Screen-to-Screen (Go Router):**
- Forward: `SlideTransition` from right (300ms, easeOutCubic)
- Back: `SlideTransition` to right (250ms, easeInCubic)
- Root change (like Home → Settings): `FadeTransition` crossfade (200ms)

**Floating Mic Button:**
- Default: floating at bottom-center, 16dp above safe area
- Scroll down: mic slides down + fades out (200ms)
- Scroll up/idle: mic slides up + fades in (300ms, easeOutBack)
- On keyboard: mic dismisses with slide-down (200ms)
- Tap: scale 1.0→1.15→1.0 (haptic) → transitions to listening state

### 8.8 Toast & Notification Animations

**Success Toast:**
- Slides down from top (300ms, easeOutBack)
- Green left accent bar + checkmark icon (scales in, 200ms)
- Auto-dismiss: 3s → slides up + fades (250ms)

**Error Toast:**
- Same slide-down, red accent
- Shake effect on appearing: translateX [-4, 4, -3, 3, 0] (200ms)

**Inline Feedback (Input Validation):**
- Error: field border turns red + gentle shake (200ms) + error text slides in from below
- Success: field border turns green + checkmark fades in right of field

### 8.9 Celebration & Delight

**Onboarding Complete:**
- Lottie confetti burst (1.5s, full-screen, plays once)
- "Bahut accha!" text scales up with overshoot (500ms, easeOutBack)
- Auto-transitions to Home after 2s

**First Task Complete:**
- Orange sparkle particles emit from completed task card (500ms)
- Card glows briefly with orange shadow

**Streak / Achievement:**
- Badge scales in from center (0→1, spring, 400ms)
- Subtle particle ring radiates outward

### 8.10 Accessibility: Reduced Motion

```dart
// Check system setting
final reducedMotion = MediaQuery.of(context).disableAnimations;

// If reduced motion enabled:
// - All durations = 0ms (instant)
// - No parallax, no floating icons
// - Fade transitions only (no slide/scale)
// - Loading = static spinner, no shimmer
// - Voice waveform = static icon change, no bars
```

- All animations respect `AccessibilityFeatures.disableAnimations`
- Graceful degradation: animations become instant state changes
- Always test with "Remove animations" in Android Developer Options

---

## 9. DARK MODE / LIGHT MODE

### Default: Dark Mode (Luma-Inspired)
- Most users will be in dark mode (battery saving on low-end phones)
- Orange accents pop beautifully on dark backgrounds
- Reduced eye strain for extended voice interactions

### Light Mode
- Available via settings toggle
- Same components, inverted surfaces
- Orange stays consistent across modes

### System Toggle
- Defaults to system preference
- Manual toggle in Settings → Appearance
- Persisted in Hive local storage

---

## 10. ACCESSIBILITY

- **Touch Targets:** Minimum `48x48dp` for all interactive elements
- **Font Scaling:** Supports system font size (1x to 2x)
- **High Contrast:** All text passes WCAG AA on both themes
- **Screen Reader:** TalkBack labels on all interactive elements
- **Reduced Motion:** Respects system reduce-motion setting
- **One-Hand Use:** All critical actions reachable in bottom 60% of screen
- **Vernacular:** All UI text available in user's selected language

---

## 11. TECHNICAL STACK

- **Framework:** Flutter (Mobile — Android first)
- **State Management:** Riverpod
- **Backend/Auth:** Supabase
- **Local Storage:** Hive
- **Typography:** Google Fonts (Inter + Noto Sans family)
- **Animations:** flutter_animate + Lottie
- **Icons:** Material Icons + Phosphor Icons (for modern look)

---
**END OF DOCUMENT**
