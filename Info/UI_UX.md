# SATHIO — UI/UX DESIGN SYSTEM

**Version:** 1.0  
**Date:** February 8, 2026  
**Purpose:** Comprehensive Design Guidelines  
**Audience:** Designers, Frontend Developers, Product Team

---

## 1. DESIGN PHILOSOPHY

### Core Principles

| Principle | Implementation |
|-----------|----------------|
| **Voice First** | Big mic button, minimal text, spoken everything |
| **Simplicity Over Features** | Maximum 3-4 options per screen |
| **Trust Through Calm** | No urgency, no red warnings, patient guidance |
| **Icon-Heavy** | Universal symbols over language-specific text |
| **Big Touch Targets** | Minimum 48x48 dp, recommended 72dp for primary actions |
| **High Contrast** | WCAG AA compliant, visible in bright sunlight |

### Design Mantras

> **"If Ramesh (our farmer persona) can't understand it in 3 seconds, redesign it."**

> **"Every extra button costs us a user."**

> **"Design for 2GB RAM phones in bright sunlight with one hand."**

---

## 2. BRAND IDENTITY

### Logo Concept

**Primary Mark:** Friendly black cat face with warm orange accents  
**Rationale:** 
- Cat = approachable, friendly, helpful companion
- Black + Orange = high contrast, visible, distinctive
- Rounded features = warmth, accessibility, trust

### Logo Usage

| Context | Specification |
|---------|---------------|
| App Icon | Cat face only, 48x48 to 512x512 |
| In-App Header | Full logo with "Sathio" text |
| Splash Screen | Centered logo + tagline |
| Marketing | Logo + "Bharat AI Assistant" tagline |

### Logo Clear Space

- Minimum clear space: 1x height of the cat face on all sides
- Never distort, rotate, or add effects
- Black cat face on light backgrounds
- White/light outline on dark backgrounds

---

## 3. COLOR PALETTE

### Primary Colors

| Color | Hex | RGB | Usage |
|-------|-----|-----|-------|
| **Sathio Teal** | #00BFA5 | 0, 191, 165 | Primary brand, CTAs, active states |
| **Saffron Orange** | #FF9800 | 255, 152, 0 | Logo accent, warmth, success |
| **Deep Blue** | #1E3A5F | 30, 58, 95 | Text, headers, trustworthy |

### Secondary Colors

| Color | Hex | RGB | Usage |
|-------|-----|-----|-------|
| **Success Green** | #4CAF50 | 76, 175, 80 | Task complete, positive feedback |
| **Alert Amber** | #FFC107 | 255, 193, 7 | Warnings, attention (not critical) |
| **Error Red** | #E53935 | 229, 57, 53 | Critical errors only (rare) |

### Neutral Colors

| Color | Hex | RGB | Usage |
|-------|-----|-----|-------|
| **Off-White** | #F5F5F5 | 245, 245, 245 | Background primary |
| **Light Gray** | #E0E0E0 | 224, 224, 224 | Dividers, borders |
| **Medium Gray** | #9E9E9E | 158, 158, 158 | Secondary text |
| **Dark Gray** | #424242 | 66, 66, 66 | Body text |
| **Near Black** | #212121 | 33, 33, 33 | Headers, emphasis |

### Dark Mode (Phase 2)

| Element | Light Mode | Dark Mode |
|---------|------------|-----------|
| Background | #F5F5F5 | #121212 |
| Surface | #FFFFFF | #1E1E1E |
| Primary Text | #212121 | #E0E0E0 |
| Secondary Text | #9E9E9E | #757575 |
| Teal | #00BFA5 | #00E5CC |

### Color Accessibility

- All text-background combinations: **4.5:1 contrast ratio** minimum
- Large text (24sp+): **3:1 contrast ratio** minimum
- Test in bright sunlight conditions
- Test with color blindness simulators

---

## 4. TYPOGRAPHY

### Font Family

**Primary:** Noto Sans  
**Rationale:** 
- Supports all Indian scripts (Devanagari, Tamil, Bengali, etc.)
- Highly legible at small sizes
- Google-backed, freely available
- Excellent Unicode support

**Fallback:** System default, Roboto

### Type Scale

| Level | Size (sp) | Weight | Line Height | Usage |
|-------|-----------|--------|-------------|-------|
| H1 | 28-32 | Bold | 1.3 | Screen titles |
| H2 | 22-24 | Semi-Bold | 1.35 | Section headers |
| H3 | 18-20 | Medium | 1.4 | Card titles |
| Body Large | 18 | Regular | 1.5 | Primary content |
| Body | 16 | Regular | 1.5 | Default text |
| Body Small | 14 | Regular | 1.5 | Secondary info |
| Caption | 12 | Regular | 1.4 | Labels, hints |
| Button | 16-18 | Medium | 1.2 | Button text |

### Typography Guidelines

- **Scalable fonts:** Support system font size up to 200%
- **Indic scripts:** Use dedicated Noto variants (Noto Sans Devanagari, etc.)
- **Line length:** Maximum 65 characters per line
- **Paragraph spacing:** 1.5× font size between paragraphs
- **No all caps:** Difficult for dyslexic users and non-English scripts

---

## 5. ICONOGRAPHY

### Icon Style

| Attribute | Specification |
|-----------|---------------|
| Style | Outlined, rounded corners (Material Icons) |
| Stroke | 2dp default, 2.5dp for emphasis |
| Size | 24x24 dp (default), 32x32 dp (navigation) |
| Touch Target | 48x48 dp minimum around icon |
| Color | Inherit from text or explicit teal/gray |

### Core Icon Set

| Icon | Usage | Material Icon Name |
|------|-------|-------------------|
| 🎤 | Voice input | `mic` |
| 🏠 | Home | `home` |
| 📋 | Government services | `assignment` |
| ⚡ | Utilities | `bolt` |
| 💊 | Health | `local_hospital` |
| 📚 | Education | `school` |
| 💰 | Payments | `account_balance_wallet` |
| ⚙️ | Settings | `settings` |
| 🔔 | Notifications | `notifications` |
| 👤 | Profile | `person` |
| ❓ | Help | `help_outline` |
| ← | Back | `arrow_back` |
| ✓ | Success | `check_circle` |
| ⏯ | Play/Pause | `play_circle` / `pause_circle` |
| 🔄 | Repeat | `replay` |

### Icon + Label Pattern

- Always pair icons with short labels (2-3 words max)
- Labels in user's selected language
- Icon above or left of label

---

## 6. COMPONENT LIBRARY

### 6.1 Buttons

#### Primary Button (CTA)
```
Specs:
- Height: 56 dp
- Corner Radius: 28 dp (fully rounded)
- Background: Sathio Teal (#00BFA5)
- Text: White, 18sp, Medium weight
- Padding: 24 dp horizontal
- Shadow: Elevation 4 dp
- States:
  - Default: Teal
  - Pressed: Darker teal (#009688)
  - Disabled: Gray (#BDBDBD)
```

#### Microphone Button (Hero)
```
Specs:
- Size: 72x72 dp (touch target: 88x88 dp)
- Shape: Circle
- Background: Sathio Teal
- Icon: White microphone, 36x36 dp
- Animation: Pulse effect when ready
- Recording state: Animated waveform inside
- Shadow: Elevation 8 dp
```

#### Secondary Button
```
Specs:
- Height: 48 dp
- Corner Radius: 8 dp
- Background: Transparent
- Border: 2 dp Teal
- Text: Teal, 16sp, Medium weight
```

#### Icon Button
```
Specs:
- Size: 48x48 dp
- Corner Radius: 24 dp (circle)
- Background: Transparent or light gray
- Icon: 24x24 dp
```

### 6.2 Cards

#### Service Card
```
Specs:
- Corner Radius: 16 dp
- Background: White
- Shadow: Elevation 2 dp
- Padding: 16 dp
- Content:
  - Icon: 48x48 dp, top-center
  - Title: H3, center-aligned
  - Subtitle: Body Small, gray, optional
- Touch: Entire card tappable
```

#### Step Card (Guided Mode)
```
Specs:
- Corner Radius: 12 dp
- Background: #FAFAFA (slightly tinted)
- Border-left: 4 dp Teal (current step)
- Padding: 16 dp
- Content:
  - Step number badge: Circle, Teal
  - Instruction text: Body Large
  - Play button: Secondary, right-aligned
```

### 6.3 Navigation

#### Bottom Navigation Bar
```
Specs:
- Height: 64 dp
- Background: White
- Shadow: Elevation 8 dp (top)
- Items: 4 (Home, History, Profile, Help)
- Item width: Equal distribution
- Active: Teal icon + label
- Inactive: Gray icon + label
- Icon: 24x24 dp
- Label: 12sp, Caption
```

#### Top App Bar
```
Specs:
- Height: 56 dp
- Background: White
- Shadow: Elevation 2 dp
- Left: Back arrow or Menu
- Center: Screen title (H2)
- Right: Action icons (Settings, Language)
```

### 6.4 Input Components

#### Text Input (Backup/Typing)
```
Specs:
- Height: 56 dp
- Corner Radius: 8 dp
- Border: 2 dp, gray (default), Teal (focused)
- Padding: 16 dp
- Placeholder: Medium gray, Body
- Text: Dark gray, Body
- Error state: Red border, red helper text
```

#### Language Selector
```
Specs:
- Type: Large button grid (2x2)
- Button size: 80x80 dp
- Content: Flag icon + native script name
- Selected: Teal border, check overlay
- Tap: Voice preview of "Main Hindi mein baat kar sakta hoon"
```

### 6.5 Feedback Components

#### Loading State
```
Specs:
- Type: Animated waveform (for voice processing)
- Color: Teal
- Size: 48x48 dp
- Text below: "Samajh raha hoon..." (Body)
- Duration indicator: Optional progress ring
```

#### Success State
```
Specs:
- Icon: Green checkmark in circle (64x64 dp)
- Animation: Scale up + bounce
- Text: "Ho gaya!" (H2, green)
- Sound: Soft chime (optional)
```

#### Error State
```
Specs:
- Icon: Amber warning triangle (48x48 dp)
- Text: Friendly message (Body, amber)
- Example: "Network thoda slow hai. Phir try karein?"
- Action: Retry button (primary)
```

#### Toast / Snackbar
```
Specs:
- Position: Bottom, 16 dp margin
- Height: 48 dp
- Corner Radius: 8 dp
- Background: Near Black (#212121)
- Text: White, Body
- Duration: 4 seconds
- Action: Optional text button (Teal)
```

---

## 7. LAYOUT SYSTEM

### Grid System

- **Margins:** 16 dp minimum on all sides
- **Gutters:** 16 dp between elements
- **Columns:** Single column for most screens (mobile-first)
- **Card grid:** 2 columns for service selection

### Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| xs | 4 dp | Tight text spacing |
| sm | 8 dp | Between related elements |
| md | 16 dp | Standard padding, margins |
| lg | 24 dp | Section spacing |
| xl | 32 dp | Major section breaks |
| xxl | 48 dp | Hero spacing |

### Safe Zones

- **Bottom safe zone:** 64 dp (for bottom navigation)
- **Top safe zone:** 56 dp (for app bar)
- **Floating button:** 16 dp from bottom nav, 16 dp from right edge

---

## 8. KEY SCREENS

### 8.1 Splash Screen
```
Layout:
- Background: Off-white
- Center: Sathio logo (cat face) — 120x120 dp
- Below logo: "Sathio" text — H1
- Below text: Tagline "Main hoon na" — Body, gray
- Bottom: Loading indicator — subtle

Duration: 2-3 seconds max
```

### 8.2 Language Selection (First Launch)
```
Layout:
- Header: "Kaunsi bhasha mein baat karein?" (all 4 scripts)
- Grid: 2x2 language buttons
  - Each: Flag + Native script name + Voice preview icon
  - Hindi: 🇮🇳 हिंदी
  - Tamil: 🇮🇳 தமிழ்
  - Bengali: 🇮🇳 বাংলা
  - Marathi: 🇮🇳 मराठी
- Tap: Plays voice preview before selection
- Bottom: "Continue" button (after selection)
```

### 8.3 Home Screen
```
Layout:
- Top bar: Language flag (left), Settings (right)
- Hero section:
  - Sathio avatar/logo — 80x80 dp
  - Greeting: "Namaste! Batao, kya madad chahiye?" — H2
- Primary CTA:
  - Microphone button — 72x72 dp, center
  - Label below: "Tap karke bolo" — Body
- Quick access grid (2x2):
  - Government services
  - Bill payments
  - Health info
  - Education
- Bottom nav: Home, History, Profile, Help
```

### 8.4 Listening State
```
Layout:
- Full screen overlay (semi-transparent)
- Center: Large microphone icon (96x96 dp)
- Below mic: Animated waveform
- Text: "Sun raha hoon..." — H2, Teal
- Timer: "0:05 / 1:00" — Caption
- Cancel: "X" button in corner
```

### 8.5 Response Screen
```
Layout:
- Top bar: Back, "Aadhaar Download" (context) 
- Avatar: Sathio speaking animation
- Response card:
  - Text: Bot response — Body Large
  - Play button: Replays audio
  - Speed toggle: 0.75x, 1x, 1.25x
- Action buttons (if applicable):
  - "Aage badhein" (Primary)
  - "Repeat karein" (Secondary)
- Bottom: Microphone button (for follow-up)
```

### 8.6 Guided Mode (Steps)
```
Layout:
- Top bar: Back, "Step 2 of 5", Close
- Progress bar: Horizontal, showing completion
- Current step card:
  - Step number badge: "2"
  - Instruction: "Ab 'Download' button pe click karein" — Body Large
  - Visual hint: Screenshot/illustration (optional)
  - Play button: Hear instruction
- Navigation:
  - "Previous" (Secondary, left)
  - "Next" (Primary, right, large)
- Bottom: "Pause" and "Talk to Human" buttons
```

### 8.7 Task Complete Screen
```
Layout:
- Celebration animation (confetti, brief)
- Success icon: Green check — 96x96 dp
- Text: "Ho gaya! Aapka Aadhaar download ho gaya." — H1
- Summary card: Task details
- Actions:
  - "Naya task shuru karein" (Primary)
  - "Home jaayein" (Secondary)
- Rating prompt: "Kya task easy tha?" — thumbs up/down
```

### 8.8 Human Escalation
```
Layout:
- Context: "Is sawaal ka jawab mushkil hai."
- Options card:
  - Call Expert: "₹50 mein 10 minute" + Phone icon
  - WhatsApp: "Free text support" + WhatsApp icon
  - Callback: "Baad mein call karein" + Clock icon
- Trust elements: "Expert verified ✓", "Private ✓"
- Cancel: "Nahi, main khud try karunga"
```

---

## 9. ANIMATIONS & MOTION

### Principles

| Principle | Application |
|-----------|-------------|
| **Purposeful** | Animations communicate state, not decorate |
| **Quick** | 150-300ms for most transitions |
| **Smooth** | 60fps, no jank |
| **Subtle** | No flashy effects, respect low-end devices |

### Key Animations

| Element | Animation | Duration |
|---------|-----------|----------|
| Screen transition | Slide from right | 250ms |
| Modal open | Fade + scale up | 200ms |
| Button press | Ripple + slight scale | 150ms |
| Mic listening | Pulse glow | Continuous |
| Waveform | Audio-reactive bars | Continuous |
| Success | Scale up + bounce | 400ms |
| Error shake | Horizontal shake | 300ms |
| Card tap | Slight lift (elevation) | 100ms |

### Microphone States

1. **Idle:** Solid teal, subtle pulse
2. **Listening:** Glowing border, waveform inside
3. **Processing:** Spinning/pulsing indicator
4. **Ready to speak:** Brief glow before TTS

### Loading States

- Voice processing: Animated waveform with "Samajh raha hoon..."
- Network request: Subtle progress bar or spinner
- Content loading: Skeleton screens (not blank)

---

## 10. VOICE DESIGN

### Audio Cues

| Event | Sound | Duration |
|-------|-------|----------|
| Mic activated | Soft "blip" | 100ms |
| Recording started | Rising tone | 150ms |
| Recording ended | Falling tone | 150ms |
| Processing | None (prefer silence) | - |
| Success | Pleasant chime | 300ms |
| Error | Soft low tone | 200ms |
| Notification | Gentle ping | 250ms |

### TTS Guidelines

| Aspect | Specification |
|--------|---------------|
| Speed | 140 words/minute (adjustable) |
| Pauses | 0.5s between sentences |
| Emphasis | Moderate (not robotic, not dramatic) |
| Numbers | Spoken naturally (not "one-oh-oh" for 100) |
| Names | Respect local pronunciation |

### Notification Sounds

- **Engagement:** Friendly chime (bird-like)
- **Reminder:** Gentle bell
- **Success:** Happy completion tone
- **All sounds:** User can disable in settings

---

## 11. ACCESSIBILITY

### WCAG 2.1 AA Compliance

| Requirement | Implementation |
|-------------|----------------|
| Color contrast | 4.5:1 for text, 3:1 for large text |
| Touch targets | 48x48 dp minimum |
| Text scaling | Support 200% system font |
| Screen reader | Full TalkBack support |
| Focus indicators | Visible outline on all interactive elements |
| Alt text | All images and icons labeled |

### Voice-First Benefits

- Entire app usable without reading
- All text content can be spoken
- No reliance on color alone for meaning
- Large buttons reduce motor skill requirements

### Specific Accommodations

| Need | Solution |
|------|----------|
| Low vision | High contrast mode, large text |
| Dyslexia | Simple fonts, short lines |
| Cognitive load | Minimal choices, clear labels |
| Motor impairment | Large touch targets, voice control |
| Hearing impairment | Visual confirmations, text captions |

### Testing Requirements

- Test with TalkBack enabled
- Test at 200% font size
- Test in bright outdoor light
- Test with slow network (3G simulation)
- Test on 2GB RAM devices

---

## 12. LOCALIZATION

### Language Support Matrix

| Language | Script | Flag | Native Name | Status |
|----------|--------|------|-------------|--------|
| Hindi | Devanagari | 🇮🇳 | हिंदी | MVP |
| Bengali | Bengali | 🇮🇳 | বাংলা | MVP |
| Tamil | Tamil | 🇮🇳 | தமிழ் | MVP |
| Marathi | Devanagari | 🇮🇳 | मराठी | MVP |
| Telugu | Telugu | 🇮🇳 | తెలుగు | Phase 2 |
| Kannada | Kannada | 🇮🇳 | ಕನ್ನಡ | Phase 2 |
| Gujarati | Gujarati | 🇮🇳 | ગુજરાતી | Phase 2 |
| Punjabi | Gurmukhi | 🇮🇳 | ਪੰਜਾਬੀ | Phase 2 |

### Localization Rules

1. **Never hardcode strings** — All text from localization files
2. **Account for text expansion** — Hindi 20-30% longer than English
3. **Test all scripts** — Each script has unique rendering needs
4. **Right-to-left ready** — Architecture supports Urdu/Arabic (future)
5. **Date formats** — DD/MM/YYYY (Indian standard)
6. **Number formats** — Indian numbering (lakhs, crores) with commas

### Content Localization

| Content Type | Approach |
|--------------|----------|
| UI strings | Professional translation + native review |
| FAQs | Expert translation per language |
| Error messages | Casual, friendly tone maintained |
| Notifications | Culturally appropriate timing/tone |
| Legal text | Certified translation |

---

## 13. DESIGN TOKENS (CSS/Kotlin Reference)

### Colors

```css
:root {
  /* Primary */
  --color-teal-500: #00BFA5;
  --color-teal-600: #009688;
  --color-orange-500: #FF9800;
  --color-blue-800: #1E3A5F;
  
  /* Secondary */
  --color-green-500: #4CAF50;
  --color-amber-500: #FFC107;
  --color-red-500: #E53935;
  
  /* Neutrals */
  --color-gray-50: #F5F5F5;
  --color-gray-200: #E0E0E0;
  --color-gray-400: #9E9E9E;
  --color-gray-700: #424242;
  --color-gray-900: #212121;
  
  /* Semantic */
  --color-background: var(--color-gray-50);
  --color-surface: #FFFFFF;
  --color-primary: var(--color-teal-500);
  --color-on-primary: #FFFFFF;
  --color-text-primary: var(--color-gray-900);
  --color-text-secondary: var(--color-gray-400);
}
```

### Spacing

```css
:root {
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 32px;
  --space-xxl: 48px;
}
```

### Typography

```css
:root {
  --font-family: 'Noto Sans', system-ui, sans-serif;
  
  --font-size-caption: 12px;
  --font-size-body-sm: 14px;
  --font-size-body: 16px;
  --font-size-body-lg: 18px;
  --font-size-h3: 20px;
  --font-size-h2: 24px;
  --font-size-h1: 32px;
  
  --font-weight-regular: 400;
  --font-weight-medium: 500;
  --font-weight-semibold: 600;
  --font-weight-bold: 700;
  
  --line-height-tight: 1.2;
  --line-height-normal: 1.5;
}
```

### Elevation (Shadows)

```css
:root {
  --elevation-1: 0 1px 3px rgba(0,0,0,0.12);
  --elevation-2: 0 2px 6px rgba(0,0,0,0.15);
  --elevation-4: 0 4px 12px rgba(0,0,0,0.15);
  --elevation-8: 0 8px 24px rgba(0,0,0,0.15);
}
```

### Border Radius

```css
:root {
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 16px;
  --radius-xl: 24px;
  --radius-full: 9999px;
}
```

---

## 14. DESIGN CHECKLIST

### Before Development Handoff

- [ ] All screens designed for all 4 languages
- [ ] All states covered (loading, error, empty, success)
- [ ] Touch targets verified (48dp+)
- [ ] Color contrast checked (4.5:1)
- [ ] Text at 200% font size tested
- [ ] Animations specified with timing
- [ ] Voice prompts written for each screen
- [ ] Error messages written in friendly tone
- [ ] Component specs in design tokens

### Before Release

- [ ] User testing with target personas
- [ ] Field testing in low-light and bright conditions
- [ ] Testing on 2GB RAM devices
- [ ] Testing on 3G network
- [ ] TalkBack accessibility testing
- [ ] All languages reviewed by native speakers
- [ ] Voice recordings reviewed for clarity

---

**Document Version:** 1.0  
**Last Updated:** February 8, 2026  
**Status:** Design System Ready

---

**END OF UI/UX DESIGN SYSTEM**
