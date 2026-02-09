# 📘 Product Requirements Document (PRD)
## Product Name: Sathio – Bharat AI Assistant

---

## 1. Product Overview

### Product Name
**Sathio**

### One-Line Product Summary
A voice-first, multilingual AI assistant that helps non-English Indians confidently complete essential digital tasks in their own language.

### Vision & Long-Term Goals
Sathio’s vision is to eliminate language as a barrier to India’s digital economy. Over the next 3–5 years, Sathio aims to become the **default conversational interface for government services, daily utilities, and essential information** across Bharat’s languages.

Long-term goals:
- Enable every Indian to access digital services without English literacy
- Become the trusted vernacular layer for public and private institutions
- Expand into education, agriculture, financial inclusion, and healthcare guidance
- Scale to other multilingual, emerging markets globally

---

## 2. Problem Statement

### Core Problem
A significant portion of India’s population struggles to use digital services because most apps and portals default to English or complex Hindi. With 22 official languages and hundreds of dialects, millions—especially in rural and semi-urban areas—are digitally excluded.

This leads to:
- Failed government applications (subsidies, pensions, IDs)
- Dependence on cyber cafés or middlemen
- Loss of time, money, and dignity
- Low trust in digital platforms

### Why Existing Solutions Are Inadequate
- Big tech assistants offer **shallow Indic language support**
- Government portals are **text-heavy and confusing**
- Existing chatbots lack **local context and task focus**
- No solution combines **voice-first UX + deep vernacular understanding + step-by-step task guidance**

---

## 3. Target Users

### Primary Users
1. **Rural & Semi-Urban Citizens**
   - Farmers
   - Daily wage workers
   - Elderly users
   - Limited English literacy

2. **Small Business Owners**
   - Shopkeepers
   - Kirana owners
   - Micro-entrepreneurs

### Secondary Users
- Vernacular-first youth
- Urban migrants from villages
- Government departments (B2B)
- Banks, NBFCs, insurance providers

### Key Pain Points
- Can’t understand English/Hindi apps
- Fear of making mistakes online
- Repeated travel to government offices
- Dependence on intermediaries

---

## 4. User Journeys & Use Cases

### User Journey 1: Aadhaar Download
1. User opens Sathio
2. Speaks: “Mera Aadhaar kaise download karun?”
3. Sathio acknowledges: “Samajh gaya.”
4. Step-by-step guided mode:
   - Step 1: Open official site
   - Step 2: Enter Aadhaar number
   - Step 3: OTP verification
5. Option to repeat steps or open link directly

### User Journey 2: PM-Kisan Status Check
1. User asks via voice
2. Sathio explains eligibility
3. Guides to official portal
4. Offers WhatsApp share of instructions

### User Journey 3: AI Confusion → Human Help
1. Sathio says: “Iska exact jawab mere paas abhi nahi hai”
2. Offers “Talk to Human”
3. Redirects to CSC helpline / partner support

---

## 5. Core Features (MVP)

| Feature | Description | User Value | Priority |
|------|------------|-----------|---------|
| Voice-First Interface | Tap-to-talk with spoken responses | Removes literacy barrier | P0 |
| Multilingual Support | Hindi, Bengali, Tamil, Marathi/Telugu | Native language trust | P0 |
| Intent-Based NLU | Task-driven understanding | Accuracy over breadth | P0 |
| Guided Step-by-Step Mode | Voice + on-screen steps | Prevents mistakes | P0 |
| Govt Services Guidance | Aadhaar, PAN, PM-Kisan | High trust use cases | P0 |
| Utility Guidance | Electricity, gas, recharge | Daily relevance | P1 |

---

## 6. Advanced / Future Features

### Phase 2 (Post-MVP)
- Auto language detection
- Offline Lite Mode
- Human escalation (call / WhatsApp)
- User preference memory

### Phase 3
- Auto form filling
- Bank & insurance onboarding
- Farmer market prices
- Dialect-level tuning
- WhatsApp & IVR interface
- Feature phone support

---

## 7. Functional Requirements

### Conversational Behavior
- Must follow **Sathio Personality Rules**
- Never use words like “Error”, “Invalid”, “Processing”
- Always acknowledge before responding
- Ask polite clarifying questions when unsure

### Guided Mode
- “Next”, “Repeat”, “Exit” options
- Voice + minimal text
- Highlight UI elements during steps

### Permissions
- Microphone access
- Optional storage (offline mode)
- No access to personal data without consent

### Edge Cases
- Low network → graceful degradation
- Accent mismatch → clarification
- Unsupported task → human escalation

---

## 8. Non-Functional Requirements

### Performance
- Voice response latency < 2.5 seconds
- CPT (Cost Per Task) tracked continuously

### Security
- No storage of Aadhaar / sensitive IDs
- End-to-end encrypted communications
- Compliance with India IT & DPDP Act

### Scalability
- Modular API-based backend
- Language modules plug-and-play

### Localization
- Regional scripts + voice
- Dialect adaptability over time

---

## 9. UX / UI Guidelines

### Design Principles
- Voice-first, text-light
- Large buttons, clear icons
- Minimal cognitive load

### Accessibility
- Elderly-friendly contrast
- Slow TTS option
- Repeatable instructions

### Information Architecture
- Home → Speak
- Simple domain shortcuts
- No complex menus

---

## 10. Technical Architecture (High-Level)

### Frontend
- Android-first (low RAM optimized)
- Lightweight UI framework

### Backend
- Modular microservices
- Intent classification layer
- Task orchestration engine

### AI / ML
- STT: Bhashini / Whisper (fine-tuned)
- NLP: Lightweight LLM + intent classifier
- TTS: Indian language TTS
- Dialect fine-tuning pipeline

### Integrations
- Govt portals (link-outs)
- UPI redirections
- WhatsApp share APIs

---

## 11. Monetization Strategy

### B2C
- Task-based micro fees (₹5–₹10)
- Premium human help (₹50–₹100)
- Sachet passes (daily/weekly)

### B2B
- **Sahayak Plan**
  - NBFCs: ₹2L setup + ₹50/lead
  - Govt: ₹25L+/year/state
- Affiliate voice commerce (2–5%)

### Credit System
Credits act as a unified payment layer across tasks, experts, and passes.

---

## 12. Analytics & KPIs

### Core Metrics
- DAU / MAU
- Task completion rate
- SVR (Voice accuracy)
- 7-day retention
- CPT (Cost per task)
- LTV (3-year user value)

---

## 13. Risks & Constraints

### Technical
- Accent & dialect variability
- Voice recognition failures

### Market
- Trust erosion from early mistakes
- Competition from Big Tech

### Legal
- Misinformation liability
- Data privacy compliance

**Mitigation:** Human escalation, conservative scope, authoritative data sources.

---

## 14. Assumptions & Open Questions

### Assumptions
- Users prefer voice over text
- Task-based pricing beats subscriptions
- Govt & banks will partner early

### Open Questions
- First pilot state selection
- Preferred human escalation partners
- Regulatory approvals for deeper integrations

---

## Suggested by Product Analysis
- Credit system as primary pricing abstraction
- Offline Lite Mode as retention lever
- Dialect-level personalization as moat
- Community ambassadors as GTM edge

---

## 15. Notifications & Alerts (Very Important for Retention)

### Objectives
- Gently re-engage users without being spammy
- Deliver high-value, time-sensitive information
- Build habit and trust, not pressure

Sathio notifications must feel like a **helpful nudge from a friend**, not a system alert.

---

### Notification Principles
- Soft, respectful tone (never urgent unless critical)
- Simple mixed-language (Hindi + English or regional)
- Low frequency, high relevance
- Opt-in with clear consent

❌ Never use:
- “Error”
- “Action required immediately”
- “Your account will be blocked”

✅ Prefer:
- “Yaad dilana tha…”
- “Aaj ka kaam yaad aaya”
- “Agar chaho toh…”

---

### Notification Types

### 1️⃣ Daily / Light Engagement Notifications
(Frequency: Max once per day)

Purpose: Habit building

Examples:
- “Aaj kuch poochhna tha?”
- “Kisi cheez mein madad chahiye?”
- “Main hoon na.”

Triggered:
- If user has been inactive for 24–48 hours

---

### 2️⃣ Task Reminder Notifications
(Frequency: Contextual)

Purpose: Help users complete unfinished tasks

Examples:
- “Kal Aadhaar download dekh rahe the… aage badhein?”
- “Gas booking ka step baaki hai.”

Triggered:
- User exits mid-guided flow
- User explicitly asks for a reminder

---

### 3️⃣ Government Scheme Alerts (High Value)
(Frequency: Occasional, opt-in)

Purpose: Trust & usefulness

Examples:
- “PM-Kisan ka naya update aaya hai.”
- “Scholarship form bharne ki last date paas hai.”

Triggered:
- Relevant to user’s region, profile, or past queries

---

### 4️⃣ Credit / Payment Notifications
(Frequency: Transactional only)

Purpose: Transparency & trust

Examples:
- “5 credits use hue — Aadhaar guide ke liye.”
- “Aapke paas 12 credits baaki hain.”

Triggered:
- After task completion
- After credit purchase or deduction

---

### 5️⃣ Human Support Follow-ups
(Frequency: Only after interaction)

Purpose: Reassurance

Examples:
- “Aaj expert se baat hui thi — aur madad chahiye?”
- “Issue solve ho gaya kya?”

Triggered:
- After HITL (Human-in-the-loop) session

---

### 6️⃣ Critical System Notifications (Rare)
(Frequency: Very rare)

Purpose: Clarity without panic

Examples:
- “Aaj network thoda slow ho sakta hai.”
- “Service thodi der baad wapas try kar sakte hain.”

❌ Never say “System down”  
✅ Always offer reassurance

---

### Language & Personalization Rules
- Notification language = last used language
- Allow manual language override
- No emojis in serious alerts
- Emojis allowed in friendly nudges (max 1)

---

### User Controls
Users must be able to:
- Turn notifications on/off
- Choose notification types:
  - Daily nudges
  - Scheme alerts
  - Task reminders
- Choose preferred language

---

### Success Metrics (Notifications)
- Notification open rate
- Task resume rate
- DAU lift from notifications
- Opt-out percentage

---

### Suggested by Product Analysis
- Use **voice notifications** (optional) for elderly users
- Time notifications for non-working hours (early morning / evening)
- Geo-based alerts for district-level schemes

---

### Final One-Line Definition
**“Sathio is a calm, voice-first vernacular assistant that helps non-English Indians complete essential digital tasks without confusion or fear.”**
