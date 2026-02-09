# Product Requirements Document (PRD): Sathio

**Version:** 1.1 (MVP Phase + Notification Strategy)
**Status:** Approved for Development
**Date:** January 31, 2026
**Author:** Senior Product Manager (AI & Consumer Apps)

---

## 1. Product Overview
* **Product Name:** Sathio (Bharat AI Assistant)
* **One-Line Summary:** A voice-first, vernacular AI assistant that helps non-English literate Indians navigate essential digital services, government schemes, and daily tasks in their mother tongue.
* **Vision:** To bridge India’s digital divide by making the internet "speak Bharat’s languages," evolving from a helpful assistant into the default operating layer for the next billion users.
* **Core Philosophy:** "Main hoon na" (I am here for you) — A helpful, trusted friend, not a robot.

## 2. Problem Statement
* **Core Problem:** Millions of rural and semi-urban Indians are digitally excluded because essential interfaces (banking, govt portals, health apps) are primarily in English or complex Hindi.
* **The Gap:** Existing voice assistants (Google, Siri) lack deep regional context and "hand-holding" capabilities. A farmer needing a subsidy doesn't need search results; they need step-by-step guidance.
* **Impact:** Users depend on expensive middlemen (cyber cafes, agents) or abandon tasks entirely due to "fear of technology."

## 3. Target Users
### Primary Persona: "Ramesh, the Aspiring Farmer"
* **Demographics:** 35 years old, lives in a Tier-3 town, owns a budget Android smartphone.
* **Language:** Fluent in Hindi/Bhojpuri, can read broken English.
* **Pain Point:** Wants to apply for PM-Kisan Samman Nidhi but is scared of the English website forms.
* **Behavior:** Uses WhatsApp heavily; treats data/battery carefully.

### Secondary Persona: "Anjali, the Home Entrepreneur"
* **Demographics:** 24 years old, runs a tailoring business from home.
* **Pain Point:** Needs to pay electricity bills and check micro-loan eligibility but finds banking apps confusing.

## 4. User Journeys & Use Cases

### Journey 1: The "Guide Me" Flow (Govt Scheme)
1.  **Trigger:** User taps the mic button.
2.  **Query:** "PM Kisan ke paise kaise check karun?" (How do I check PM Kisan money?)
3.  **Bot Response:** "Namaste! Main dekh raha hoon... PM Kisan status check karne ke liye, aapka Aadhaar number chahiye hoga." (Checking... to check status, I need your Aadhaar number.)
4.  **Action:** App opens a simplified overlay of the official portal.
5.  **Guidance:** TTS reads out: "Yahan apna number daalo aur 'Submit' dabao." (Enter number here and press Submit.)
6.  **Success:** Status is shown. User feels empowered.

### Journey 2: The "Information Retrieval" Flow (Utility)
1.  **Trigger:** User asks, "Bijli ka bill phone se kaise bharun?" (How to pay electricity bill via phone?)
2.  **Bot Response:** Explains 3 simple steps. Offers to open their UPI app directly.

## 5. Core Features (MVP)
*Priority: P0 (Critical), P1 (High), P2 (Nice to have)*

| Feature ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **MVP-01** | **Vernacular Voice Interface** | "Tap-to-Talk" UI. Supports Hindi, Bengali, Tamil, Marathi. Auto-detects mixed language (Hinglish). | **P0** |
| **MVP-02** | **The "Sathio" Personality** | AI responses tuned to be calm, respectful ("Ji"), and colloquial. No robotic jargon ("Processing", "Error"). | **P0** |
| **MVP-03** | **Govt Services Module** | Knowledge base for top 5 schemes (Aadhaar, PAN, PM Kisan, Ration, Ayushman). **Read-only guidance** (no auto-submit). | **P0** |
| **MVP-04** | **Step-by-Step Mode** | Visual + Audio overlay that breaks complex tasks into single actions ("Click Here" -> "Enter OTP"). | **P0** |
| **MVP-05** | **Audio-First Error Handling** | "Network slow hai" instead of "404 Error". "Mic on kijiye" instead of "Permission Denied". | **P1** |
| **MVP-06** | **Smart Notification System** | Context-aware, vernacular push notifications to drive retention (See Section 7.1). | **P1** |

## 6. Advanced / Future Features (Phase 2 & 3)
* **Phase 2 (Trust & Offline):**
    * **Offline Lite Mode:** Cached FAQs and emergency numbers that work without data.
    * **Human Handoff:** "Talk to Expert" button for paid consultation.
* **Phase 3 (Transaction & Scale):**
    * **Auto-Form Filling:** AI fills the form based on user voice input (requires high security).
    * **Voice Commerce:** Buy seeds/fertilizers directly via voice.
    * **IoT Integration:** Sathio on feature phones and smart speakers.

## 7. Functional Requirements

### 7.1. Notification & Engagement System
*Since users may not read text notifications, this system must be "Audio-First" and "High-Value".*

* **Audio-Ready Push:**
    * Notifications must support "Play" capability. When the user taps, the message is **read aloud** immediately, not just opened as text.
* **Categories:**
    1.  **The "Morning Ram-Ram" (retention):** A daily greeting sent at 8:00 AM (local time).
        * *Content:* "Namaste Ramesh ji! Aaj mandi ka bhaav dekhna hai?" (Do you want to check market prices today?)
    2.  **Transactional Updates:**
        * *Content:* "Aapka download complete ho gaya. Dekhne ke liye yahan dabayein." (Your download is complete. Press here to view.)
    3.  **Educational Nudges:**
        * *Content:* "Suniye! PM Kisan ki nayi list aayi hai. Check karein?" (Listen! New PM Kisan list is out. Check?)
* **Rules:**
    * **No Spam:** Maximum 1 marketing notification per day.
    * **Quiet Hours:** No notifications between 9:00 PM and 7:00 AM.
    * **Language Match:** Notification MUST match the user's last used language.

### 7.2. Core App Behaviors
* **Input Modality:** Primary: Voice. Secondary: Text (with transliteration support, e.g., typing "kya haal" in English script -> recognized as Hindi).
* **Response Time:** Latency must be under 3 seconds for voice acknowledgment ("Ek second...").
* **Content Guardrails:**
    * **Medical/Legal:** MUST preface with "Main doctor nahi hoon, par jaankari ye hai..." (I am not a doctor, but here is the info...).
    * **Safety:** Strict filtering of hate speech or political bias.

## 8. Non-Functional Requirements
* **Performance (Low-End Device Optimization):**
    * APK size: < 15MB.
    * RAM usage: Must run smoothly on 2GB RAM devices.
* **Network Resilience:** Must handle 2G/EDGE networks gracefully (retry mechanisms for audio uploads).
* **Localization:** TTS engine must support Indian accents and prosody (medium-slow speed).
* **Security:**
    * Data Encryption at Rest and Transit.
    * **PII Masking:** Never log Aadhaar/PAN numbers in the chat history database.

## 9. UX / UI Guidelines
* **Brand Identity:**
    * **Logo:** Teal rounded speech bubble with a wave.
    * **Vibe:** "The helpful older cousin."
* **Visual Design:**
    * **High Contrast:** For usage in bright sunlight (fields/outdoors).
    * **Iconography:** Universal symbols (e.g., a simplified rupee symbol, a clear mic icon). Minimal text.
* **Voice UX Scripting (Golden Rules):**
    * **Greeting:** "Namaste! Batao, kya madad chahiye?"
    * **Processing:** "Samajh raha hoon..." (Not "Loading").
    * **Error:** "Maaf karna, awaz cut gayi." (Sorry, voice cut out).

## 10. Technical Architecture (High-Level)
* **Frontend (Mobile):**
    * **Framework:** Native Android (Kotlin) or Flutter (optimized for performance).
    * **Audio Processing:** Local VAD (Voice Activity Detection) to save data; only send audio when speech is detected.
* **Backend (Cloud & AI):**
    * **Orchestration:** Python/FastAPI middleware.
    * **ASR/TTS:** **Bhashini API** (Primary) with OpenAI Whisper (Fallback) for transcription.
    * **LLM/Reasoning:** Small Language Models (SLM) fine-tuned on Indian vernacular data (hosted on IndiaAI GPU clusters) to reduce inference cost.
    * **Notification Engine:** Firebase Cloud Messaging (FCM) with custom payload for TTS triggers.
    * **Knowledge Base:** Vector Database (Pinecone/Milvus) indexing Govt scheme PDFs and FAQs.
* **Database:** PostgreSQL for user data; Redis for session caching.

## 11. Monetization Strategy
* **Economy:** "Sathio Credits" (Sachet Model).
* **B2C Revenue:**
    * **Micro-transactions:** ₹5 - ₹10 per "Success" (e.g., downloading a document).
    * **Expert Connect:** ₹50 for a human consultation call.
* **B2B Revenue (The "Sahayak" Plan):**
    * **Lead Gen:** ₹50–₹100 per qualified loan/insurance lead passed to partners (NBFCs).
    * **Enterprise:** White-label licensing for State Govts (₹25L+ Annual Contract Value).

## 12. Analytics & KPIs
* **North Star Metric:** **Task Completion Rate (TCR)** — % of intents that result in a successful outcome (not just an answer).
* **Operational Metrics:**
    * **CPT (Cost Per Task):** Target < ₹0.50 per interaction.
    * **SVR (Successful Voice Recognition):** Accuracy rate across accents.
    * **Notification Click-Through (CTR):** % of users who listen to daily nudges.
    * **DAU/MAU Ratio:** Stickiness of the app.

## 13. Risks & Constraints
* **Market Risk:** Trust is fragile. One wrong answer about money/health can kill the brand.
    * *Mitigation:* Strict "Information Only" policy for MVP; Human handoff for complex queries.
* **Technical Risk:** Dialect variations (e.g., standard Hindi vs. Maithili) causing NLU failure.
    * *Mitigation:* Continuous RLHF (Reinforcement Learning from Human Feedback) using local ambassadors.
* **Platform Risk:** Dependency on Govt APIs (which often change or go down).
    * *Mitigation:* Build robust "scraper" fallbacks and cache static data.

## 14. Assumptions & Open Questions
* **Assumption:** Users are willing to grant microphone/notification permissions immediately.
* **Assumption:** Govt portals allow "webview" access without blocking the app.
* **Open Question:** Will users prefer a "Wallet" top-up or direct UPI payment for micro-transactions? (To be A/B tested).