

```markdown
# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Project Name:** Sathio  
**Version:** 1.0 (MVP Definition)  
**Status:** Draft  
**Date:** October 26, 2023  
**Document Type:** Technical & Product Specification  

---

## 1. Product Overview

*   **Product Name:** Sathio  
*   **One-line Product Summary:** A vernacular, voice-first AI assistant that helps non-English speakers in India navigate government services, daily utilities, and financial tasks in their mother tongue.  
*   **Vision and Long-term Goals:**  
    *   **Vision:** To bridge the digital divide in India by ensuring no citizen is left behind due to language barriers.  
    *   **Long-term Goal:** To evolve into the default operating system for "Bharat," handling complex transactions (banking, education, commerce) across all 22 official languages and eventually expanding to other multilingual developing markets.  

---

## 2. Problem Statement

*   **Core Problem:** A significant portion of India’s population (rural and semi-urban) is excluded from digital services due to interfaces that default to English or standard Hindi. With hundreds of dialects and low technical literacy, users struggle to access essential government schemes, banking services, and health information.  
*   **Why Existing Solutions Are Inadequate:** Current assistants (Google Assistant, Siri) lack deep vernacular context and task-specific guidance for Indian bureaucracy. Government portals are often text-heavy and complex. There is no solution that combines "localized trust" (human-like interaction) with "AI efficiency" specifically for the rural use case.  

---

## 3. Target Users

| Persona | Description | Pain Points |
| :--- | :--- | :--- |
| **The Farmer (Primary)** | Male/Female, 30-55, rural. Uses smartphone primarily for calls/WhatsApp. Low digital literacy. | Cannot navigate subsidy forms; unaware of new schemes; struggles with English terms on banking apps. |
| **The Small Shopkeeper** | Urban/Rural migrant, 25-45. Basic tech skills but prefers native language. | Needs to pay bills, check credit, or apply for licenses but finds processes too time-consuming. |
| **The Non-English Student** | Young adult, 18-25. Comfortable with tech but finds conceptual learning easier in native tongue. | Looks for scholarships, exam dates, or job alerts but lacks a centralized, vernacular source. |
| **The Urban Migrant** | Worker living in metro city, supports family in village. | Needs to handle family paperwork (ration, health) remotely but struggles to explain processes to parents back home. |

---

## 4. User Journeys & Use Cases

### Use Case A: Government Service (The "Farmer" Journey)
1.  **User Action:** Opens Sathio and taps the microphone.  
2.  **Input:** "PM Kisan ka status kaise check karna hai?" (How to check PM Kisan status?)  
3.  **System Processing:** Sathio detects intent (Query: Status Check) + Language (Hindi).  
4.  **Output:** "Samajh gaya. Main aapko step-by-step bataata hoon." (Understood. I will tell you step-by-step.)  
5.  **Action:** Sathio displays a simplified card with the official link and a "Listen" button that narrates the steps.  
6.  **Escalation:** If the user fails, Sathio offers: "Koi dikkat hai? Main expert se baat karwa doon?" (Any issue? Should I talk to an expert?) [Paid Feature]  

### Use Case B: Financial Lead Gen (The "Shopkeeper" Journey)
1.  **User Action:** "Mujhe tractor loan chahiye." (I need a tractor loan.)  
2.  **System Processing:** NLP identifies high-intent financial query.  
3.  **Output:** Sathio asks qualifying questions (land ownership, location).  
4.  **Monetization:** Sathio presents a "Apply Here" button for a partner bank (e.g., SBI).  
5.  **Conversion:** User clicks; data is sent as a qualified lead to the bank.  

---

## 5. Core Features (MVP)

| Feature | Description | User Value | Priority |
| :--- | :--- | :--- | :--- |
| **Voice-First Interface** | Tap-to-talk input, text-to-speech output. Minimal text UI. | Accessibility for low-literacy users. | P0 (Critical) |
| **MVP Vernacular Support** | Hindi, Bengali, Tamil, Marathi. | Covers massive demographic base. | P0 (Critical) |
| **Guided Task Mode** | Step-by-step breakdown for specific tasks (e.g., Aadhaar download). Not just links, but "Click here, then here." | Reduces cognitive load and errors. | P0 (Critical) |
| **3 Core Domains** | 1. Govt Services (Aadhaar, PAN), 2. Utilities (Bill pay info), 3. Health/Edu (Hospital info, Scholarships). | Immediate high-value utility. | P0 (Critical) |
| **Sathio Credit System** | *Suggested by Product Analysis:* In-app wallet to load small amounts (₹10-₹50) for micro-transactions (task fees). | Solves the "no credit card" barrier for rural users. | P1 (High) |
| **"Talk to Human"** | Escalation button to connect to a call center or WhatsApp agent. | Safety net for AI failures; builds trust. | P1 (High) |
| **Offline Lite Mode** | Cached FAQs and Emergency numbers accessible without data. | Reliability in low-network zones. | P2 (Medium) |

---

## 6. Advanced / Future Features

*   **Phase 2 (MVP+):**  
    *   **Auto-Form Filling:** API integrations to allow users to dictate info directly into PDF forms.  
    *   **Dialect Tuning:** Moving from standard languages to local dialects (e.g., Bhojpuri, Malwi).  
    *   **WhatsApp/IVR Integration:** Accessing Sathio via feature phones (missed call numbers).  
*   **Phase 3 (Scale):**  
    *   **IoT Voice:** Smart speakers/radios running Sathio for households without smartphones.  
    *   **Agri-Advisor:** Real-time crop pricing and pest alerts based on location.  
    *   **White-Label "Sathio for Govt":** Dedicated bots for specific states (e.g., "UP-Buddy").  

---

## 7. Functional Requirements

### 7.1 App Behaviors
*   **Startup:** App must load in < 3 seconds on low-end 3G networks.  
*   **Voice Input:**  
    *   Must support "Tap-to-talk" and "Wake word" (Phase 2).  
    *   Must handle interruptions (user speaking while TTS is playing).  
*   **Language Handling:**  
    *   Auto-detect language on first launch or ask "Kaunsi bhasha mein samjhaun?"  
    *   Support code-switching (Hinglish) within a single query.  
*   **Task Completion:**  
    *   If a task involves an external website, Sathio must use **Deep Linking** to open the specific page, not just the homepage.  
*   **Credit System:**  
    *   Users can add credits via UPI QR code.  
    *   Credits are deducted *only* upon successful completion of a "paid" task (e.g., form download).  

### 7.2 Notification & Engagement System
*Suggested by Product Analysis: A robust notification strategy is vital for retention in rural markets where internet habits are sporadic.*

*   **Push Notification Types:**  
    *   **Transactional:** "Bill Payment Reminder: Your electricity bill is due tomorrow."  
    *   **Personalized Alerts:** "New Scheme Alert: The government has announced a subsidy for wheat farmers in your district."  
    *   **Engagement:** "Aaj kuch poochhna tha?" (Did you want to ask something today?) - Sent once a day if inactive.  
*   **Behavioral Rules:**  
    *   **Quiet Hours:** No push notifications between 10:00 PM and 7:00 AM to avoid disturbance.  
    *   **Language Consistency:** All notification text must be in the user's selected native language.  
    *   **Actionable Buttons:** Notifications must include actionable buttons (e.g., "Pay Now", "View Details").  

### 7.3 Edge Cases
*   **Network Timeout:** Display specific message "Lagta hai network thoda slow hai" (Network seems slow) instead of generic error.  
*   **AI Hallucination:** If confidence score < 80%, trigger the "Human Escalation" protocol automatically.  
*   **Mic Permission:** If mic is denied, show a visual guide (screenshot) on how to enable settings.  

### 7.4 Permissions
*   **Required:** Microphone, Storage (for offline cache), Phone State (to read UPI SMS for verification - *Suggested by Product Analysis*).  
*   **Optional:** Location (for hyper-local scheme suggestions).  

---

## 8. Non-Functional Requirements

| Category | Requirement |
| :--- | :--- |
| **Performance** | Voice-to-Text latency < 1.5 seconds. Text-to-Speech start < 500ms. |
| **Security & Privacy** | All voice data encrypted at rest/transit. Strict anonymization for B2B data sales. Compliance with DPDP Act (India). |
| **Scalability** | Architecture must support 10k concurrent users using subsidized IndiaAI GPU clusters. |
| **Localization** | Unicode support for all Indic scripts. TTS must sound native, not robotic. |
| **Device Support** | Must run smoothly on Android devices with 2GB RAM (Android 8+). |

---

## 9. UX / UI Guidelines

### 9.1 Design Principles
*   **"Deep Simplicity":** Large buttons, high contrast, minimal text density.  
*   **Teal Identity:** Primary color Teal (#008080) representing calm and trust.  
*   **Visual Feedback:** The "Wave" animation when listening; a subtle "Pulse" when processing.  

### 9.2 Voice & Tone (The "Sathio" Personality)
*   **Archetype:** Helpful Indian friend / Calm cousin.  
*   **Gender:** Neutral voice synthesis.  
*   **Vocabulary Rules:**  
    *   **NEVER USE:** "Error", "Invalid", "Processing", "System", "AI model".  
    *   **USE:** "Ek second... dekh raha hoon" (One second... checking), "Network main dikkat hai" (Network issue).  
*   **Emotional Traits:** Patient, Respectful, Encouraging ("Ho jaayega" vibe).  
*   **Greeting:** "Namaste! Batao, kya madad chahiye?"  

### 9.3 Accessibility
*   Text-to-Speech for every on-screen element.  
*   TalkBack support for visually impaired users.  

---

## 10. Technical Architecture (High-Level)

### 10.1 Frontend Stack
*   **Framework:** Android Native (Kotlin). *Rationale: Superior performance on low-end hardware compared to Flutter/React Native.*  
*   **Optimization:** ProGuard for code shrinking; Glide for efficient image loading.  

### 10.2 Backend Stack
*   **API Gateway:** Node.js or Go (Lightweight, fast).  
*   **Application Server:** Python (Django/FastAPI) for AI orchestration.  

### 10.3 AI / ML Components
*   **ASR (Speech-to-Text):** Bhashini API / Whisper (Fine-tuned for Indic accents).  
*   **NLP Engine:** Lightweight LLM (e.g., distilled LLaMA or Gemma) + RAG (Retrieval Augmented Generation) using indexed Govt databases.  
*   **TTS (Text-to-Speech):** Bhashini / Coqui TTS (Open source female/male neutral voices).  

### 10.4 Database Design
*   **Primary DB:** PostgreSQL (User profiles, credit balance, logs).  
*   **Caching:** Redis (Store frequent queries to reduce API costs).  
*   **Vector DB:** Pinecone or Milvus (To store vernacular embeddings for semantic search).  

### 10.5 Integrations
*   **Bhashini:** Govt of India language APIs.  
*   **IndiaAI:** Subsidized GPU compute clusters.  
*   **Payment Gateways:** UPI (PhonePe/GPay integration links) for wallet top-ups.  

### 10.6 Admin & Ops Dashboard
*Suggested by Product Analysis: Essential for managing a dynamic AI product.*
*   **Content Management:** Interface to update government scheme info/FAQs without code deployment.  
*   **Analytics View:** Real-time dashboard for SVR (Voice Recognition rates), CPT (Cost Per Task), and Failed Queries.  
*   **User Management:** Tools to look up user credit balances and resolve transaction disputes.  

---

## 11. Monetization Strategy

### 11.1 Revenue Streams
1.  **Task Fees (B2C):** Micro-payments (₹5–₹10) for high-effort tasks (e.g., "Form Filling Assistance"). Utilizing the **Sathio Credit System**.  
2.  **Lead Generation (B2B):**  
    *   **Finance:** Passing verified leads for loans/insurance to banks/NBFCs. (Fee: ₹100–₹500 per lead).  
    *   **E-commerce:** Affiliate commission on Agri-inputs (seeds, fertilizers).  
3.  **The "Agency" Model (B2G):**  
    *   White-label licensing to State Governments (e.g., "Tamil-Sahayak"). Annual contract ₹25 Lakhs+.  
4.  **Premium Human Help:**  
    *   Access to live experts for complex legal/medical queries. Fee: ₹50–₹100/session.  

### 11.2 Pricing Logic
*   **Freemium:** Basic info is free.  
*   **Sachet Pricing:** Daily/Weekly passes during peak seasons (e.g., "Harvest Pass" for farmers).  

---

## 12. Analytics & KPIs

*   **Success Metrics:**  
    *   **Task Completion Rate (TCR):** % of users who finish the flow they started.  
    *   **SVR (Successful Voice Recognition):** Accuracy rate across different accents/dialects.  
    *   **CPT (Cost Per Task):** Compute cost per query (Target: < ₹0.50).  
*   **Engagement Metrics:**  
    *   DAU/MAU (Stickiness).  
    *   **LTV (Lifetime Value):** Revenue per user over 3 years (via Credits + Commerce).  
    *   **Notification Opt-in Rate:** Tracking engagement with push alerts.  
*   **Trust Metrics:**  
    *   Human Escalation Rate (Should decrease over time).  
    *   "Thumbs Up/Down" rating after every answer.  

---

## 13. Risks & Constraints

| Risk | Mitigation Strategy |
| :--- | :--- |
| **Technical: NLP Accuracy** | Dialects vary wildly. | *Mitigation:* Use "Human in the Loop" feedback to retrain models weekly. Start with 3 major languages only. |
| **Market: Big Tech** | Google/Apple enter the space. | *Mitigation:* Focus on deep hyper-local integration (Govt schemes) that generic players ignore. Build moat via proprietary data. |
| **Compliance: Misinformation** | AI gives wrong medical/legal advice. | *Mitigation:* Hard-coded disclaimers. RAG restricts answers only to verified Govt documents for high-risk topics. |
| **Financial: Low Willingness to Pay** | Users resist digital payments. | *Mitigation:* Use "Outcome-based" pricing (pay only if work is done) and UPI, which has high penetration. |
| **Notification Fatigue** | Users uninstall due to spam. | *Mitigation:* Strict "Quiet Hours" policy and daily frequency caps (max 1-2 non-critical alerts/day). |

---

## 14. Assumptions & Open Questions

### Assumptions
1.  **IndiaAI Stability:** Subsidized GPU rates will remain stable for the first 18 months.  
2.  **Network Growth:** Rural 4G coverage will continue to expand, supporting the voice-first model.  
3.  **Bhashini Reliability:** Government APIs will maintain uptime necessary for a commercial product.  