# SATHIO — UI/UX DESIGN SYSTEM

**Version:** 2.0  
**Date:** February 10, 2026  
**Purpose:** Comprehensive Design Guidelines  
**Audience:** Designers, Frontend Developers, Product Team

---

## 1. DESIGN PHILOSOPHY

### Core Principles

| Principle | Implementation |
|-----------|----------------|
| **Warmth & Trust** | Cream backgrounds, rounded corners, friendly orange accents |
| **Simplicity** | Split-screen layouts, focus on single actions |
| **Voice First** | Large touch targets, prominent mic interactions |
| **Accessible** | High contrast, Poppins font for readability |
| **Personal** | Addresses user by name ("Namaste Ayan") |

### Design Aesthetics

> **"Premium, Warm, and Alive."**
> Design uses deep orange for energy and warm cream for comfort. Animations are smooth and purposeful.

---

## 2. BRAND IDENTITY

**Primary Mark:** Friendly black cat face with warm orange accents.

### Logo Usage
- **App Icon:** Cat face only.
- **Headers:** "Sathio" text in Poppins Bold.

---

## 3. COLOR PALETTE

### Primary Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Saffron Orange** | `#E65100` | Primary Brand, Headers, Active States, Buttons |
| **Warm Cream** | `#FBF4E2` | Primary Background, Content Panels |
| **Pure White** | `#FFFFFF` | Cards, Input Fields, FABs |
| **Deep Text** | `#000000` | Primary Headings |
| **Body Text** | `#4A4A4A` | Secondary Text, Subtitles |

### Secondary Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Success Green** | `#4CAF50` | Completion, Validation |
| **Error Red** | `#E53935` | Errors, Warnings |
| **Teal** | `#00BFA5` | (Legacy/Accent) Occasional use |

### Accessibility
- **Contrast:** Black text on Cream/White passes WCAG AA. White text on Orange passes WCAG AA.

---

## 4. TYPOGRAPHY

### Font Family
**Primary:** **Poppins** (Google Fonts)  
**Why:** Modern, geometric, friendly, and highly legible.

### Type Scale

| Level | Size | Weight | Usage |
|-------|------|--------|-------|
| **Display** | 64px | Black (900) | Large Greetings ("Login", "User") |
| **H1** | 32px | Bold (700) | Screen Titles, Success Messages |
| **H2** | 24px | Bold (700) | Section Headers |
| **Body Large** | 18px | Medium (500) | Prompts, subtitles |
| **Body** | 16px | Regular (400) | Inputs, list items |
| **Button** | 16px | SemiBold (600) | Call to Actions |
| **Caption** | 12px | Regular (400) | Helper text |

---

## 5. LAYOUT SYSTEM

### Split-Screen Architecture
Most screens follow a split layout:
1.  **Top 30% (Header):**
    *   Background: **Saffron Orange**
    *   Content: Large Display Text, Titles.
    *   purpose: Sets context and tone.
2.  **Bottom 70% (Content):**
    *   Background: **Warm Cream**
    *   Shape: Top corners rounded (`Radius.circular(40)`).
    *   Content: Inputs, Cards, Lists.
    *   purpose: Interaction area.
    *   Padding: typically `32px`.

### Navigation
-   **Floating Action Button (FAB):**
    *   White circular button (`64x64`) with shadow.
    *   Icon: Arrow Forward (`AppsColors.black` or `orange`).
    *   Position: Bottom Right (or center in some flows).
-   **Back Button:**
    *   Top Left circular white button (when needed).

---

## 6. COMPONENT LIBRARY

### 6.1 Buttons
-   **Primary (Elevated):**
    *   Background: Orange.
    *   Text: White.
    *   Shape: Rounded Pill (`Radius 30`).
    *   Shadow: Soft elevation.
-   **Secondary (Outlined):**
    *   Border: Orange (2px).
    *   Text: Orange.
    *   Background: Transparent/White.
-   **Social/Auth Buttons:**
    *   White Pill with Icon (Google/Phone).
    *   Shadow: Soft.
    *   Text: Black/Gray.

### 6.2 Inputs
-   **Text Fields:**
    *   Background: White.
    *   Border: None (Shadow only) or subtle Gray border.
    *   Radius: `16px`.
    *   Padding: `16px`.
    *   Typography: Poppins Medium.

### 6.3 Cards
-   **Visual:** White background, `Radius 32px`, Soft Orange shadow.
-   **Interaction:** Scale animation on press.
-   **Selection:** Orange border (`3px`) + Check icon when selected.

---

## 7. USER FLOWS (ONBOARDING)

### 7.1 Start Screen
-   **Visual:** Full screen animation (Lottie).
-   **Action:** "Get Started" FAB.

### 7.2 Language Selection
-   **Grid:** 2x2 Language cards (Hindi, Tamil, Bengali, Marathi).
-   **Action:** Select -> Audio Feedback -> Next.

### 7.3 Authentication
-   **Options:**
    1.  **Google:** One-tap sign in (Supabase).
    2.  **Phone:** Mobile Input -> OTP Verification.
    3.  **Guest:** "Continue as Guest" link (bypasses auth).
-   **Outcome:** Retrieves/Creates User profile.

### 7.4 Profile Setup
-   **Input:** Name (Pre-filled if Auth available), State, Avatar.
-   **Purpose:** Personalization.

### 7.5 Use Case Selection
-   **Header:** "Namaste [Name]" or "User".
-   **Content:** Scrollable list of needs (Govt, Bills, Health, etc.).
-   **Interaction:** Multi-select cards. Snap scrolling.

### 7.6 Voice Demo
-   **Interaction:** "Tap mic to speak".
-   **Visual:** Breathing animation.
-   **Feedback:** TTS response.

### 7.7 Quick Win
-   **Task:** "Check Weather".
-   **Permission:** Location request.
-   **Result:** Real-time temperature display card.

---

## 8. ANIMATIONS

-   **Page Transitions:** Orange fade/fill effect.
-   **Mic:** Pulse/Breathing animation (`flutter_animate`).
-   **Cards:** Scale in/out, Slide up.
-   **Loading:** Circular progress (Orange).

---

## 9. TECHNICAL STACK

-   **Framework:** Flutter (Mobile/Web).
-   **State Management:** Riverpod.
-   **Backend/Auth:** Supabase.
-   **Storage:** Hive (Local prefs).
-   **Typography:** Google Fonts.

---
**END OF DOCUMENT**
