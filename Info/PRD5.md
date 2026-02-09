# SATHIO – PRODUCT REQUIREMENTS DOCUMENT (PRD)
**Version:** 1.0  
**Last Updated:** February 2, 2026  
**Status:** Ready for Development

---

## 1. PRODUCT OVERVIEW

### Product Name
**Sathio** – India's Multilingual Voice-First Digital Assistant

### One-Line Summary
A voice-activated, vernacular AI assistant that empowers non-English speakers across India to complete essential government, financial, and utility tasks confidently in their mother tongue.

### Vision & Long-Term Goals
**Core Vision:** Eliminate the digital divide in India by making every essential service accessible to every citizen, regardless of language or literacy level.

**Long-Term Goals:**
- Cover all 22 official Indian languages + major dialects within 3–5 years
- Become the default interface for national digital services (government, finance, utilities)
- Extend to IoT (voice-enabled TVs, radios) for accessibility in resource-constrained environments
- Expand internationally to other multilingual markets (Indonesia, Africa, Southeast Asia)
- Enable financial inclusion for 500M+ vernacular users in India's digital economy

---

## 2. PROBLEM STATEMENT

### Core Problem
**The Language Barrier Excludes Millions:** India has 22 official languages and 700+ dialects. Despite 85.5% smartphone penetration nationwide (84% in rural areas as of 2024), a significant portion of India's population—estimated at 200–300 million people—lacks functional English or Hindi literacy. This creates a critical digital divide:

- **Government Services:** Citizens struggle to apply for subsidies (PM-Kisan), download identity documents (Aadhaar), or understand eligibility criteria for welfare schemes.
- **Financial Access:** Rural farmers, small business owners, and elderly users cannot navigate banking apps, insurance portals, or loan applications.
- **Daily Tasks:** Bill payments, mobile recharge, and utility services become frustrating friction points requiring expensive intermediaries (cyber cafes, mobile shops).
- **Health & Education:** Lack of localized information about free government health schemes (Ayushman Bharat) or scholarship programs perpetuates exclusion.

### Why Existing Solutions Are Inadequate

1. **Generic Assistants (Google Assistant, Siri, Alexa):** Offer limited support for Indian languages; provide generic responses without local context or offline capability.
2. **Government Portals:** Default to English/Hindi; lack voice support; require typing skills; UI is complex and unfriendly for rural users.
3. **Localization Efforts:** Most focus on UI translation, not deep task assistance or voice-first experiences.
4. **CSC (Common Service Centers):** Physical intermediaries remain the primary option, requiring travel, time, and cost.

### Supporting Evidence
- Users are **2.5× more likely to trust and use services in their mother tongue** (Source: Research from AI vernacular adoption studies)
- Smartphone adoption in rural India grew from 36% (2018) to 84% (2024), yet digital service adoption remains low due to language barriers
- Government initiatives like **Digital ShramSetu** and **Bhashini** explicitly target vernacular digital inclusion
- Thousands of helpline calls and forum posts daily report language-related frustration with essential services

---

## 3. TARGET USERS

### Primary User Personas

#### Persona 1: **Ravi – The Rural Farmer**
- **Age:** 35–60
- **Language:** Regional (Tamil, Telugu, Marathi, Bengali, or Hindi)
- **Education:** Literate but non-English fluent
- **Device:** Basic Android smartphone
- **Challenge:** Needs to apply for PM-Kisan subsidies, check minimum support price for crops, access agricultural schemes
- **Motivation:** Avoid traveling 15–20 km to a government office; save time during harvest season
- **Tech Comfort:** Comfortable with voice calls and simple apps; prefers voice over typing

#### Persona 2: **Priya – The Semi-Urban Homemaker**
- **Age:** 25–45
- **Language:** Regional (mix of regional + Hindi)
- **Education:** Some school education; not confident in English
- **Device:** Smartphone (basic to mid-range)
- **Challenge:** Pay utility bills, apply for school scholarships, understand health scheme eligibility
- **Motivation:** Handle daily tasks independently without asking family members; avoid fees at cyber cafes
- **Tech Comfort:** Uses WhatsApp and basic apps; prefers simple, guided experiences

#### Persona 3: **Rajesh – The Small Business Owner**
- **Age:** 30–50
- **Language:** Regional language + broken Hindi
- **Education:** Self-educated, business-savvy but not tech-savvy
- **Device:** Smartphone (frequently used for business)
- **Challenge:** Understand GST filing, access business loans, digital payments, regulatory compliance
- **Motivation:** Grow business without hiring consultants; stay compliant with regulations
- **Tech Comfort:** Uses WhatsApp, UPI; intimidated by complex portals

#### Persona 4: **Ananya – The Regional Language Preference**
- **Age:** 15–30
- **Language:** Native regional language (Tamil, Bengali, Marathi, etc.)
- **Education:** School/college educated; English-literate but prefers regional
- **Device:** Modern smartphone
- **Challenge:** Navigating government forms, learning local job opportunities, higher education info
- **Motivation:** Prefer interface in mother tongue; want to help parents/grandparents use digital services
- **Tech Comfort:** Tech-savvy; wants a modern experience in their language

### Secondary User Personas
- **Elderly users (60+):** Voice-only experience preferred; government scheme queries
- **Urban migrants:** Maintain connection to hometown services; help family members
- **PWD (Persons with Disabilities):** Voice-first interface is highly accessible

### Key Pain Points (Across All Personas)
1. Language anxiety when using apps or government portals
2. Fear of making mistakes while filling forms
3. No guidance on eligibility or required documents
4. Time wasted in travel to CSCs or cyber cafes
5. Misinformation from unreliable local sources
6. Inability to help family members (elderly, children) with digital services

### Market Size & Addressability
- **Total TAM:** ~300M non-English literate, smartphone users in India
- **Initial SAM (3 years):** ~50M users in target languages (Hindi, Tamil, Bengali, Marathi)
- **Initial SOM (Year 1):** ~2–5M early adopters through pilot regions + partnerships

---

## 4. USER JOURNEYS & USE CASES

### Journey 1: **Government Subsidy Application (Highest Intent)**
**Scenario:** Ravi (farmer) needs to apply for PM-Kisan subsidy but has never filled a government form online.

**Steps:**
1. Opens Sathio app; selects Tamil language (or speaks it)
2. Says: "PM-Kisan scheme ke bare mein batao" ("Tell me about PM-Kisan")
3. Sathio responds: "PM-Kisan ₹6000 saal mein deta hai. Pehle eligibility check karte hain."
4. Sathio guides step-by-step:
   - "Tera Aadhaar number ready hai?"
   - "Tera bank account linked hai Aadhaar se?"
   - "Land ownership certificate ready hai?"
5. Sathio fills a checklist: "Ye 3 cheezen chahiye. Tera paas hain?" (These 3 things needed. Do you have them?)
6. Once confirmed, Sathio opens the official PM-Kisan portal and highlights where to click
7. Ravi completes application in 10 minutes instead of spending a day at the office
8. Sathio sends confirmation to his WhatsApp: "Application submitted. Approval in 5–7 days."

**Success Metric:** Application completed without errors; no visits to CSC.

---

### Journey 2: **Daily Bill Payment & Financial Task**
**Scenario:** Priya needs to pay her electricity bill but finds the DISCOMS app confusing.

**Steps:**
1. Opens Sathio; says: "Bijli bill pay karna hai" ("I want to pay electricity bill")
2. Sathio confirms: "Kaunsi state mein ho?" ("Which state?")
3. After confirming Maharashtra, Sathio guides:
   - "MAHAVITRAN website kholte hain"
   - "Tera consumer number ready hai?" (Do you have consumer number?)
4. Sathio highlights the payment button; offers: "UPI se pay kar de ya credit card?"
5. Priya completes payment via UPI in 3 minutes
6. Confirmation saved to her WhatsApp

**Success Metric:** Payment completed without errors; willingness to pay for convenience.

---

### Journey 3: **Health Scheme Awareness (Trust-Building)**
**Scenario:** Rajesh (small business owner) asks about health insurance for his family.

**Steps:**
1. Says: "Mera parivaar health insurance ke liye kya options hain?" ("What health insurance options for my family?")
2. Sathio responds: "Do options: Ayushman Bharat (free) aur private insurance. Tere liye kaunsa better?"
3. Sathio asks qualifying questions:
   - "Tera annual income kitna hai?"
   - "Kitne family members?"
4. Based on answers: "Tere liye Ayushman Bharat eligible hai. Bilkul free." (You are eligible for Ayushman Bharat. Completely free.)
5. Sathio explains benefits and provides steps to enroll
6. Offers escalation: "Agar detailed info chahiye to ek doctor se baat kara de?" (Want to talk to a doctor?)

**Success Metric:** User feels informed and trusted; premium HITL conversion if selected.

---

### Journey 4: **Multi-Language Code-Switching**
**Scenario:** Ananya (college student) speaks primarily Tamil but sometimes mixes in English.

**Steps:**
1. Ananya says: "Competitive exam ka fee payment kaise karte hain?" (mix of Tamil + Hindi/English)
2. Sathio auto-detects and responds: "Tamil ya English mein explain karoon?" 
3. Ananya chooses Tamil
4. Sathio provides step-by-step guidance in pure Tamil

**Success Metric:** Seamless language detection; user feels understood.

---

### Journey 5: **Escalation to Human (Trust Feature)**
**Scenario:** A user has a complex legal question that AI cannot definitively answer.

**Steps:**
1. User asks: "Mere son ko property transfer kaise karuun?"
2. Sathio recognizes complexity: "Ye thoda complicated hai. Kya tum ek lawyer se baat karna chahte ho?"
3. Options presented:
   - Call our expert (₹75 consultation)
   - WhatsApp connect with legal advisor
   - Local CSC referral
4. User selects expert consultation; routed to trained vernacular legal advisor
5. Advisor handles query in user's language; transaction tracked for revenue

**Success Metric:** User trusts escalation; successful HITL conversion; LTV increase.

---

## 5. CORE FEATURES (MVP)

### MVP Goal
Help non-English users complete 2–3 critical daily digital tasks confidently in their mother tongue using voice.

### Phase 0: MVP Foundation (Weeks 0–4)

#### Feature 1.1: **Language Selection & Auto-Detection**
- **Scope:** Support 3–4 languages initially (Hindi, Tamil, Bengali, Marathi)
- **Capability:** User selects language on first launch OR speaks naturally for auto-detection
- **Priority:** P0 (Critical)
- **User Value:** "I speak in my language; the app understands"

#### Feature 1.2: **Voice-First Interface**
- **Scope:** 
  - Large, easy-to-tap microphone button
  - Visual feedback while listening ("listening... ● ")
  - Transcript displayed on screen (optional reading)
  - Voice response in same language (TTS)
- **Priority:** P0 (Critical)
- **User Value:** "I can speak; I don't need to type"

#### Feature 1.3: **Intent-Based Query Understanding (Lite NLP)**
- **Scope:** Recognize high-frequency user intents:
  - "How to download Aadhaar?"
  - "Check PM-Kisan status"
  - "Pay electricity bill"
  - "What documents for PAN?"
  - "Loan eligibility check"
- **Backend:** Lightweight intent classifier + FAQ database
- **Priority:** P0 (Critical)
- **User Value:** "The app understands what I need"

#### Feature 1.4: **Offline Lite Mode**
- **Scope:** Pre-download common FAQs, scheme info, emergency numbers
- **Capability:** Work without internet for text + cached TTS
- **Priority:** P1 (High)
- **User Value:** "Works even when network is weak"

---

### Phase 1: Core MVP Features (Weeks 4–10)

#### Feature 2.1: **Step-by-Step Guided Mode (Differentiator)**
- **Scope:** For each task, break into clear steps:
  - "Step 1: Go to website"
  - "Step 2: Click 'Apply Now'"
  - "Step 3: Enter Aadhaar number"
- **Capabilities:**
  - Buttons: "Next", "Repeat", "Need Help?"
  - On-screen highlights showing where to click
  - Voice + text instructions simultaneously
- **Priority:** P0 (Critical)
- **User Value:** "Clear, hand-held guidance—I won't make mistakes"

#### Feature 2.2: **Government Services Domain (Trust Builder)**

**Sub-features:**
- **Aadhaar Assistance:** Download steps, card status, linking to bank accounts
- **PAN Registration:** Eligibility check, document requirements, online filing guidance
- **PM-Kisan Subsidy:** Scheme details, eligibility, application steps, status check
- **Ration Card / Pensions:** Scheme navigation, eligibility verification
- **Document Checklist:** AI generates personalized checklist based on user's task

**Scope:** FAQ + step-by-step guidance; NO auto-form submission in MVP
**Priority:** P0 (Critical)
**User Value:** "I can access government services without confusion"

#### Feature 2.3: **Utility & Payment Guidance**
- **Electricity Bills:** How to pay, where to find consumer ID, tariff info
- **Mobile Recharge:** Steps, plans available
- **Gas Booking:** LPG connection, booking, complaint channels
- **Guidance:** Step-by-step + redirect to official app/portal
- **Priority:** P0 (Critical)
- **User Value:** "I can pay my bills independently"

#### Feature 2.4: **Health & Education Info (Lightweight)**
- **Government Hospitals:** Location finder, services, appointment booking guidance
- **Free Health Schemes:** Ayushman Bharat, state health programs
- **School Scholarships:** Eligibility, application process
- **Scope:** Info + guidance ONLY; NO medical diagnosis in MVP
- **Priority:** P1 (High)
- **User Value:** "I know about free schemes; I can apply"

---

### Phase 2: MVP+ Features (Weeks 10–16)

#### Feature 3.1: **Language Switching & Preference Memory**
- **Auto-Detect:** Speech recognition identifies language
- **Manual Switch:** User can change language mid-conversation
- **Preference Storage:** App remembers user's preferred language
- **Priority:** P1 (High)

#### Feature 3.2: **Talk to Human Escalation (Trust Feature)**
- **When Triggered:** AI is unsure OR user requests help
- **Options:**
  - Call center consultation (₹50–₹100)
  - WhatsApp chatbot with human backup
  - Local CSC helpline redirect
- **Capability:** Route to trained multilingual support agents
- **Priority:** P1 (High)
- **User Value:** "If AI can't help, a real person can"

#### Feature 3.3: **Daily Engagement & Retention**
- **Soft Reminders:** "Aaj kuch poochhna tha?" (Once per day)
- **Seasonal Prompts:** During harvest/admission season, remind farmers/parents
- **Capability:** Use location + user history to personalize
- **Priority:** P2 (Medium)

---

## 6. ADVANCED / FUTURE FEATURES

### Phase 3: Post-MVP Expansion (After Traction Validation)

#### Feature Set A: **Form Auto-Filling & Submission**
- Auto-fill forms with user's Aadhaar/PAN data
- Digital signature support
- Form submission directly to government portals
- **When:** Post-MVP, after building trust and legal compliance framework
- **Value:** Reduce form submission time from 30 minutes to 3 minutes

#### Feature Set B: **Financial Service Integrations**
- **Loan Eligibility:** Integrated eligibility checker linking to partner banks
- **Lead Generation:** Pass qualified users to NBFCs/banks for loan disbursal
- **Insurance Onboarding:** Guide users through insurance purchasing
- **Credit Products:** Micro-lending products built into Sathio
- **When:** Months 12–18 (after strong user base & trust)
- **Revenue Impact:** Primary B2B revenue driver

#### Feature Set C: **Agri-Commerce & Market Intelligence**
- **Farmer Support:** Real-time crop prices, market updates, pest alerts
- **E-Commerce Integration:** Voice ordering for seeds, fertilizers, equipment
- **Marketplace:** Partner with DeHaat, BigHaat for commissions
- **When:** Months 15–24 (pilot in agricultural regions)
- **Value:** 2–5% commission per transaction

#### Feature Set D: **Dialect & Accent Tuning**
- Fine-tune for regional accents (Bhojpuri vs. Maithili, coastal vs. interior Tamil, etc.)
- Reduce SVR (Successful Voice Recognition) error rates through user feedback loops
- **When:** Continuous post-MVP
- **Value:** Improve user experience incrementally

#### Feature Set E: **WhatsApp & IVR Versions**
- **WhatsApp Bot:** Reach users who prefer messaging
- **IVR (Phone-Based):** Voice-activated via missed calls (feature phone support)
- **When:** Months 9–15 (scale to feature phone users)
- **Value:** Reach additional 200M+ feature phone users

#### Feature Set F: **IoT & Smart TV Integration**
- **Voice Assistant on TVs/Radios:** Reach elderly users
- **Community Centers:** Deployed in panchayats, anganwadis
- **When:** Year 2–3 (post-Series A)
- **Value:** Increase accessibility; reach non-smartphone users

#### Feature Set G: **Education Tutor Mode**
- **Literacy Support:** Teach reading, basic numeracy in regional language
- **Exam Prep:** Guided coaching for competitive exams (SSC, UPSC, state exams)
- **Scholarship Info:** Navigate education pathways
- **When:** Year 2 (post-validation)
- **Value:** Expand TAM to education segment

#### Feature Set H: **International Expansion**
- Adapt to Indonesian, Tagalog, Swahili, or other multilingual markets
- Partner with local governments or telecom players
- **When:** Year 3–5 (post-strong India traction)
- **Value:** 5–10× TAM expansion

---

## 7. FUNCTIONAL REQUIREMENTS

### Requirement 1: Voice Input Processing
- **Specification:** Capture user's spoken query; convert to text using ASR
- **Supported Languages (MVP):** Hindi, Tamil, Bengali, Marathi
- **Accuracy Target:** ≥ 85% SVR (Successful Voice Recognition) across all languages
- **Latency:** ASR response within 2–3 seconds
- **Edge Case:** Handle background noise in rural environments (animals, traffic, multiple voices)
- **Fallback:** Text input option if voice fails

### Requirement 2: Intent Classification & Routing
- **Specification:** Classify user's intent into predefined categories
- **Intent Categories (MVP):** Government services, payments, health info, education, legal, financial
- **Accuracy Target:** ≥ 90% intent classification
- **Fallback:** If intent unclear, ask clarifying question: "Thoda aur detail mein bataoge?"
- **Confidence Threshold:** If confidence < 70%, trigger human escalation offer

### Requirement 3: Knowledge Base & FAQ System
- **Content:** Curated FAQs for each domain (government, utilities, health, education)
- **Updates:** Monthly refresh with new schemes, policy changes
- **Localization:** Answers tailored to user's state/region (different schemes in different states)
- **Accuracy:** All answers verified by domain experts before deployment
- **Sourcing:** Government websites (indiaportals.gov.in), official APIs (Aadhaar, AEPS, etc.), NGO partnerships

### Requirement 4: Text-to-Speech (TTS) Response
- **Language Support:** Hindi, Tamil, Bengali, Marathi (MVP); expand to 22 languages post-MVP
- **Voice Quality:** Natural, clear, at medium speed (~140 words/minute)
- **Gender:** Neutral voice (or allow user to choose male/female)
- **Accent:** Natural Indian accent (avoid robotic or overly formal tone)
- **Offline Capability:** Cache common responses for offline mode

### Requirement 5: Step-by-Step Guided Mode
- **Specification:** Break complex tasks into clear, sequential steps
- **Step Format:** "Step N: [Action]" with visual highlight on screen
- **Repeat Capability:** User can say "Repeat" to hear step again
- **Navigation:** "Next" to move to next step; "Previous" to go back
- **Visual Cues:** On-screen highlight (arrow, circle) showing where to click on external portal
- **Context Preservation:** Remember user's progress; allow resuming interrupted tasks

### Requirement 6: Human Escalation Workflow
- **Trigger Conditions:**
  - AI confidence < 70%
  - User explicitly requests human help
  - Query involves sensitive topics (medical, legal, financial)
  - User unsatisfied with AI response
- **Escalation Options:**
  - Premium consultation fee (₹50–₹100)
  - WhatsApp connect with support agent
  - Local CSC referral
- **Agent Matching:** Route to agent fluent in user's language
- **Resolution Tracking:** Log resolution status; train AI on unsolved queries

### Requirement 7: Credential & Privacy Handling
- **Data Collection:** Collect only necessary data (language, state, intent)
- **PII (Personally Identifiable Information):** Never store user's Aadhaar, bank account, or sensitive personal data locally
- **Consent Workflow:** Explicit user consent before any data sharing
- **Encryption:** End-to-end encryption for sensitive queries
- **Compliance:** GDPR + India's data protection standards (pre-DPDPA)

### Requirement 8: Offline Capability
- **Scope:** Pre-download FAQ for all 3 languages (≤ 50 MB)
- **Offline Features:**
  - FAQ browsing
  - Cached voice responses
  - Step-by-step guide text (without real-time portal integration)
  - Emergency contact numbers
- **Sync:** Automatically sync when network returns
- **Indicator:** Clear "Offline Mode" indication on UI

### Requirement 9: Multi-Language Code-Switching
- **Spec:** User may mix languages within a single query
  - Example: "Kaise Aadhar card ko digital signature de sakta hu?" (mix of Hindi + Hinglish)
- **Processing:** Detect language mix; prioritize primary language for response
- **Response Option:** Offer alternative language response if user prefers

### Requirement 10: Transaction Logging & Audit Trail
- **Log Data:** User query, intent, response, time, outcome
- **Audit Trail:** Track all escalations, premium services used, payments
- **Analytics:** Aggregate anonymized data for product insights
- **Retention:** Keep logs for 6 months; delete PII after 30 days (unless user opts in for history)

### Requirement 11: Role-Based Access (Future, Post-MVP)
- **User Role:** Regular user (free tier)
- **Premium User Role:** Access to HITL, advanced features
- **Government/Enterprise User:** White-labeled versions with restricted data
- **Permissions:** Ensure users cannot access other users' data

---

## 8. NON-FUNCTIONAL REQUIREMENTS

### Requirement 1: Performance Benchmarks
- **App Launch Time:** < 2 seconds (on Android 5.0+)
- **Voice Capture to Response Latency:** < 5 seconds (end-to-end)
- **FAQ Search:** < 1 second (local)
- **Server Response (API calls):** < 2 seconds (government APIs, 95th percentile)
- **Concurrent Users:** Support 10,000 concurrent connections (MVP; scale to 1M+ post-Series A)

### Requirement 2: Reliability & Uptime
- **Target Uptime:** 99.5% (MVP); 99.9% (post-Series A)
- **Error Rate:** < 0.5% of queries result in system error
- **Failover:** Automatic failover to secondary API/TTS provider
- **Graceful Degradation:** If primary service fails, offer fallback (e.g., redirect to CSC)

### Requirement 3: Scalability
- **Horizontal Scaling:** Use containerized microservices (Docker, Kubernetes) for easy scaling
- **Load Balancing:** Distribute traffic across multiple API servers
- **Database Scaling:** Partition data by language, region for faster queries
- **CDN:** Use CDN for TTS and FAQ distribution
- **Projected Scale (Year 1):** Support 5M daily active users

### Requirement 4: Security & Data Protection
- **Authentication:** OTP-based (phone number + OTP for privacy, not email)
- **Authorization:** Role-based access control (user, premium, enterprise)
- **Data Encryption:**
  - At Rest: AES-256 encryption for sensitive data
  - In Transit: TLS 1.3 for all API calls
- **Secure Storage:** Never store PII (Aadhaar, bank account numbers)
- **API Security:** Rate limiting, DDoS protection, API key rotation
- **Compliance:** ISO 27001, SOC 2 Type II
- **Privacy:** No third-party ad networks; aggregated analytics only

### Requirement 5: Localization & Regional Support
- **State-Level Customization:** Tailor government schemes info by state (e.g., different PM-Kisan details in Maharashtra vs. Tamil Nadu)
- **Timezone Support:** Display times in user's local timezone
- **Currency:** Use INR; no currency conversion needed (MVP)
- **Regional Holidays:** Acknowledge state holidays in responses
- **Local Partnerships:** Integrate with state government APIs (e.g., MAHAVITRAN for electricity)

### Requirement 6: Accessibility (WCAG 2.1 AA Compliance)
- **Voice as Primary Interface:** Entire app usable via voice
- **Color Contrast:** Min 4.5:1 contrast ratio for text
- **Text Size:** Scalable fonts; support user's system text size settings
- **Keyboard Navigation:** All features accessible via keyboard (not just touchscreen)
- **Screen Reader Support:** Compatible with TalkBack (Android) and Voice Over (iOS, future)
- **Haptic Feedback:** Vibration cues for important actions

### Requirement 7: Multilingual Support
- **MVP Languages:** Hindi, Tamil, Bengali, Marathi
- **Post-MVP:** Add languages based on user demand (Telugu, Kannada, Gujarati, Punjabi, etc.)
- **Language Detection:** Auto-detect from device settings; allow manual override
- **Accuracy Per Language:** ≥ 85% ASR accuracy per language

### Requirement 8: Device Compatibility
- **Minimum OS:** Android 5.0+ (MVP); iOS planned for Phase 2
- **Device Types:** Supported on basic to high-end smartphones
- **RAM Requirement:** Optimized for ≤ 2 GB RAM devices (common in rural India)
- **Storage:** App size ≤ 40 MB (including offline FAQ database)
- **Network:** Support both Wi-Fi and mobile data (2G, 3G, 4G)

### Requirement 9: Analytics & Monitoring
- **Real-Time Monitoring:** Track system health, error rates, latency
- **User Analytics:** DAU, MAU, task completion rate, retention rate
- **Performance Tracking:** SVR accuracy, intent classification accuracy, latency percentiles
- **Alerts:** Automatic alerts if uptime < 99.5% or error rate > 1%
- **Privacy:** All analytics are anonymized; no user identification

### Requirement 10: Backup & Disaster Recovery
- **Data Backup:** Daily incremental backup; weekly full backup
- **Backup Location:** Geographically distributed (India + cloud)
- **Recovery Target:** RPO ≤ 1 hour; RTO ≤ 4 hours
- **Testing:** Quarterly disaster recovery drills
- **Compliance:** Data residency within India (compliance with government requirements)

---

## 9. UX / UI GUIDELINES

### Design Philosophy
**"Simple, Voice-First, Respectful"**

- Prioritize voice as the primary interaction mode; text as secondary
- Minimize text; use icons and visuals
- Design for low-literacy users; avoid jargon
- Respect user's language and intelligence
- Build trust through clarity and transparency

### Principle 1: Voice-First, Icon-Heavy UI
- **Large Microphone Button:** Prominently placed (center, easy to tap for all hand sizes)
- **Visual Feedback:** Animated waveform while listening
- **Minimal Text:** Replace text with universally understood icons (home = house, settings = gear)
- **Color Coding:** Use distinct colors for different intents (green = success, orange = pending, red = error)

### Principle 2: Guided Step-by-Step Experience
- **No Information Dump:** Break responses into 3–5 steps max
- **Progress Indicator:** Show "Step 2 of 5" to manage expectations
- **Buttons:** Large, clearly labeled "Next", "Repeat", "Help"
- **Highlight:** On-screen arrow/circle pointing to next action on external portal

### Principle 3: Trust Through Transparency
- **Voice Character:** Warm, respectful tone ("Ek second… samajh raha hoon")
- **Acknowledgment:** Confirm understanding ("Samajh gaya")
- **Uncertainty Handling:** Admit when unsure ("Iska exact jawab mere paas nahi")
- **No Jargon:** Avoid technical terms; use everyday language

### Principle 4: Accessibility
- **Large Tap Targets:** Buttons ≥ 48 × 48 pixels
- **Readable Fonts:** Sans-serif, minimum 16pt for body text
- **High Contrast:** Dark text on light background (or light on dark)
- **Voice Clarity:** Speak at ~140 words/minute; clear pronunciation
- **Screen Reader:** Full support for visually impaired users

### Principle 5: Localization Beyond Language
- **Colors:** Use culturally appropriate colors (avoid color meanings that conflict with local traditions)
- **Images:** Feature diverse, local faces and scenarios
- **Greetings:** Use culturally appropriate greetings ("Namaste" for Hindi, "Vanakkam" for Tamil)
- **Time:** Display using 12-hour format (common in India) rather than 24-hour

### Information Architecture

Home Screen
├── Voice Query Input (Primary)
├── Quick Access (Government, Utilities, Health, Education)
├── Recent Queries
└── Menu
├── Settings (Language, Preferences)
├── My Tasks (In-Progress)
├── Help & FAQs
└── Account (Profile, Premium)

### Screen Layouts

#### Home Screen
- Large microphone button (center)
- "Powered by Sathio" branding
- Quick access cards (4 cards: "Government", "Pay Bills", "Health Info", "Education")
- Greeting: "Namaste! Aaj kya poochhna hai?" (Today, what do you want to ask?)

#### Response Screen
- User's query (transcript)
- Step-by-step response (1 step visible at a time)
- Buttons: "Next" | "Repeat" | "Help"
- Progress indicator: "Step 1 of 3"

#### Escalation Screen
- "Need More Help?" prompt
- Options: "Call an Expert (₹75)" | "WhatsApp Chat" | "Find CSC Near You"
- Clear pricing; no hidden fees

#### Settings Screen
- Language selection
- Clear data option
- About app
- Feedback option

### Color Palette (Inclusive & Accessible)
- **Primary:** Deep Blue (#1E3A8A) – Trust, authority
- **Secondary:** Green (#16A34A) – Success, positive
- **Accent:** Orange (#EA580C) – Attention, action needed
- **Background:** Off-white (#F9FAFB) – Easy on eyes
- **Text:** Dark Gray (#111827) – Readable, not harsh black
- **Error:** Red (#DC2626) – Clear warning

### Typography
- **Primary Font:** Open Sans or Poppins (sans-serif; easy to read)
- **Body Text:** 16pt minimum
- **Headers:** 24pt + (hierarchy)
- **Regional Fonts:** Support Indic scripts natively (ensure proper rendering for Telugu, Tamil, etc.)

### Iconography
- **Consistent Style:** Line-based, simple, bold strokes
- **Culturally Neutral:** Avoid symbols with negative local meanings
- **Clear Intent:** Icons should be immediately understandable (gear = settings, + = add, etc.)

### Onboarding Flow (First-Time User)
1. **Language Selection:** "आपकी भाषा चुनें" (Choose your language)
2. **Permission Request:** Mic access with explanation
3. **Demo Query:** "आइए एक आजमाते हैं। 'Aadhar card download' बोलिए।" (Let's try. Say "Aadhar card download".)
4. **Feedback:** "Bahut badhiya!" (Very good!) + move to home

---

## 10. TECHNICAL ARCHITECTURE (HIGH-LEVEL)

### Architecture Overview (Microservices + Cloud-Based)

User Device (Android)
├── Voice Input (Mic)
├── ASR Module (Speech-to-Text) → Bhashini / Whisper
├── NLP Module (Intent Classification) → Lightweight Transformer
├── UI Layer (Flutter/React Native)
└── Local Cache (Offline FAQ database)
↓↓↓ API Gateway ↓↓↓
Backend Services (Cloud)
├── 1. Intent Classification Service
├── 2. FAQ/Knowledge Service
├── 3. Government API Gateway (Integration Layer)
├── 4. TTS Service (Text-to-Speech)
├── 5. Escalation Service (Human HITL routing)
├── 6. User Service (Profile, Preferences)
├── 7. Analytics Service (Logging, Metrics)
└── 8. Transaction Service (Payments, Commissions)
↓↓↓
Data Layer
├── PostgreSQL (User data, preferences)
├── MongoDB (FAQ, conversational logs)
├── Redis (Cache, session management)
└── Cloud Storage (Offline FAQ database, TTS cache)
↓↓↓
External Integrations
├── Bhashini APIs (ASR, TTS, Machine Translation)
├── Government APIs (Aadhaar, PAN, PM-Kisan, etc.)
├── UPI Gateway (for payments)
└── WhatsApp API (for escalation)

![High-Level Architecture](https://via.placeholder.com/800x600.png?text=High-Level+Architecture)

### Frontend Stack
- **Framework:** Flutter (cross-platform; excellent for offline support and performance)
- **Language:** Dart
- **State Management:** Provider / BLoC
- **Offline Storage:** SQLite (for FAQ cache)
- **Voice Processing:** speech_to_text / flutter_sound libraries
- **Localization:** intl package (for 22+ languages)

**Alternative:** React Native (if faster time-to-market; but Flutter's performance better for voice-heavy apps)

### Backend Stack
- **API Framework:** FastAPI or Node.js (Express)
- **Language:** Python (FastAPI) – better for ML integration
- **Containerization:** Docker + Kubernetes (on-premises or cloud)
- **API Gateway:** Kong or AWS API Gateway
- **Orchestration:** Kubernetes (managed service: Google Cloud GKE or AWS EKS)

### Core Services Architecture

#### Service 1: ASR Service (Speech-to-Text)
- **Provider:** Bhashini (free/subsidized) or Whisper fine-tuned on Indian accents
- **Languages:** Hindi, Tamil, Bengali, Marathi (MVP)
- **Accuracy Target:** ≥ 85% SVR
- **Latency:** < 3 seconds
- **Scaling:** Auto-scale based on concurrent requests
- **Fallback:** If Bhashini down, use offline Whisper model (lightweight, on-device)

#### Service 2: NLP & Intent Classification Service
- **Model:** Fine-tuned BERT or DistilBERT (lightweight)
- **Intents:** ~30 core intents (government, utilities, health, education, payments)
- **Input:** Cleaned text from ASR
- **Output:** Intent + confidence score + required parameters
- **Accuracy Target:** ≥ 90%
- **Retraining:** Monthly, with user feedback loop

#### Service 3: FAQ & Knowledge Service
- **Database:** MongoDB (document-based for flexible FAQ structure)
- **Content:** Curated FAQs per domain, per language, per state
- **Retrieval:** Semantic search using embeddings (if confidence < threshold)
- **Updates:** Daily refresh from government portals + manual curation
- **Caching:** Redis for high-frequency FAQs

#### Service 4: TTS Service (Text-to-Speech)
- **Provider:** Bhashini TTS or open-source (e.g., Festival, gTTS with regional support)
- **Voice Profile:** Neutral, warm, medium-slow (~140 wpm)
- **Languages:** Same as ASR
- **Output:** MP3 / WAV cached for reuse
- **Offline Support:** Pre-cache top 1000 responses per language

#### Service 5: Government API Gateway
- **Purpose:** Normalize access to multiple government portals
- **Integrations:**
  - Aadhaar (UIDAI API)
  - PAN (NSDL API)
  - PM-Kisan (Agriculture portal)
  - State-level schemes (health, education, ration)
  - AEPS (banking)
- **Authentication:** OAuth 2.0 / API keys per service
- **Rate Limiting:** Prevent API abuse
- **Error Handling:** Graceful degradation if government API fails

#### Service 6: Human Escalation Service (HITL)
- **Queue Management:** Route to available agents
- **Agent Matching:** Assign based on language, expertise, availability
- **Communication:** Phone call, WhatsApp, or in-app chat
- **CRM Integration:** Track conversation history
- **Billing:** Track usage for revenue calculation (₹50–₹100 per consultation)

#### Service 7: Analytics Service
- **Logging:** All user queries, intents, responses
- **Metrics:** DAU, MAU, task completion rate, SVR accuracy, latency
- **Privacy:** All logs are anonymized (no PII)
- **Visualization:** Dashboard for team insights
- **Tools:** ELK Stack (Elasticsearch, Logstash, Kibana) or DataDog

#### Service 8: Transaction & Payment Service
- **Payment Gateway:** Razorpay or PayU (India-focused)
- **Transactions:** Track premium HITL payments, affiliate commissions
- **Billing:** Generate invoices for enterprise clients
- **Accounting:** Integration with Xero for financial reporting

### Database Design

#### Users Table (PostgreSQL)
| Column Name       | Data Type         | Constraints                |
|-------------------|-------------------|-----------------------------|
| user_id           | SERIAL PRIMARY KEY|                             |
| phone_number      | VARCHAR(15)       | UNIQUE NOT NULL             |
| language_preference| VARCHAR(10)      | NOT NULL                    |
| state              | VARCHAR(50)      | NOT NULL                    |
| created_at        | TIMESTAMP         | DEFAULT CURRENT_TIMESTAMP   |
| updated_at        | TIMESTAMP         | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP |

#### FAQ Database (MongoDB)
| Column Name       | Data Type         | Constraints                |
|-------------------|-------------------|-----------------------------|
| faq_id            | ObjectId          | PRIMARY KEY                 |
| question          | String            | NOT NULL                    |
| answer            | String            | NOT NULL                    |
| language          | String            | NOT NULL                    |
| state              | String            |                             |
| created_at        | Date              | DEFAULT CURRENT_TIMESTAMP   |
| updated_at        | Date              | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP |

#### Transactions Table (PostgreSQL)
| Column Name       | Data Type         | Constraints                |
|-------------------|-------------------|-----------------------------|
| transaction_id    | SERIAL PRIMARY KEY|                             |
| user_id           | INTEGER           | REFERENCES users(user_id)   |
| amount            | DECIMAL(10, 2)    | NOT NULL                    |
| transaction_type  | VARCHAR(50)       | NOT NULL                    |
| status             | VARCHAR(50)       | NOT NULL                    |
| created_at        | TIMESTAMP         | DEFAULT CURRENT_TIMESTAMP   |
| updated_at        | TIMESTAMP         | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP |

### AI / ML Components

#### 1. ASR Fine-Tuning
- **Base Model:** OpenAI Whisper or Bhashini
- **Fine-Tuning Data:** Collect user audio + transcripts in target languages
- **Accent Diversity:** Include speakers from different regions (coastal Tamil vs. interior Tamil)
- **Quarterly Retraining:** Improve SVR accuracy over time

#### 2. Intent Classification
- **Approach:** Multi-class text classification
- **Model:** DistilBERT (lightweight) fine-tuned on ~10K labeled queries
- **Class Balance:** Ensure balanced representation of intents (government, utilities, health, etc.)
- **Continuous Learning:** Retrain monthly with user feedback
- **Output:** Intent + confidence + required parameters

#### 3. Semantic Search (Future Optimization)
- **Purpose:** If intent confidence < threshold, perform semantic search on FAQ database
- **Embedding Model:** Sentence-Transformers (multilingual)
- **Use Case:** User asks "How to get a loan?" → Search FAQ database for loan-related content
- **Ranking:** Return top 3 matches; ask user to clarify

#### 4. Misinformation Filtering
- **Approach:** Fact-check responses against authoritative sources
- **Verification:** All government-related responses verified by policy experts
- **Flagging:** If AI confidence < 60%, automatically escalate to human
- **Feedback Loop:** Users report incorrect information → retraining

### APIs & Integrations

#### External API Integrations
1. **Bhashini APIs** (Free/subsidized)
   - ASR (speech-to-text)
   - TTS (text-to-speech)
   - Machine Translation (future, for cross-language support)

2. **Government APIs**
   - UIDAI Aadhaar API
   - NSDL PAN API
   - Ministry of Agriculture PM-Kisan portal
   - State-level portals (health, education, ration)

3. **Payment Gateway**
   - Razorpay (payments)
   - WhatsApp API (escalation)
   - UPI gateway (for bill payments redirect)

4. **Analytics**
   - Sentry (error tracking)
   - Mixpanel or Amplitude (user analytics)

### Deployment & Infrastructure

#### Hosting (Cloud)
- **Primary:** Google Cloud Platform (GCP) or AWS
- **Regions:** India-primary (Delhi, Mumbai)
- **Backup:** Secondary region for disaster recovery

#### Infrastructure
- **Compute:** Containerized microservices on Kubernetes
- **Database:** Managed PostgreSQL + MongoDB (Google Cloud SQL, MongoDB Atlas)
- **Cache:** Redis (managed service)
- **CDN:** CloudFlare for TTS + FAQ distribution

#### Cost Optimization (Year 1)
- **IndiaAI Mission GPUs:** Subsidized rates (~₹65/hour for GPU compute)
- **Open-Source Models:** Minimize proprietary LLM costs (use fine-tuned DistilBERT instead of GPT-4)
- **Bhashini Free Tier:** Leverage government's free ASR/TTS APIs
- **Estimated Monthly Cost (MVP):** ₹5–₹10 Lakhs (compute + storage + bandwidth)

---

## 11. MONETIZATION STRATEGY

### Primary Revenue Streams

#### Stream 1: Direct Consumer (B2C) – Outcome-Based Task Fees

**Model:** Charge per successful task completion, not per subscription.

**Pricing:**
- **Guided Tasks:** ₹5–₹20 per task (free guidance, ₹5–₹10 for form submission assistance)
  - Examples: Download Aadhaar (₹5), apply for PM-Kisan (₹10), pay utility bill (₹5)
- **Premium HITL Consultation:** ₹50–₹100 per consultation
  - Examples: Legal advice (₹100), financial planning (₹75), medical information (₹50)
- **Sachet-Style Micro-Passes:** ₹10–₹50 per day/week (unlimited access during peak seasons)
  - Example: During harvest season, farmers buy a ₹20/week pass for unlimited PM-Kisan + market price queries

**Why This Works:**
- Mirrors existing "cyber cafe" model but cheaper (cyber cafes charge ₹50–₹100 per task)
- Users perceive value: "I saved ₹200 travel cost by paying ₹10 fee"
- Low friction: No monthly commitment; pay only when needed

**Year 1 Revenue Projection (Conservative):**
- 2M users; 30% transaction adoption rate = 600K transactions/month
- Average transaction value: ₹12
- Monthly Revenue: ₹72 Lakhs (Year 1: ₹8.6+ Crores)

---

#### Stream 2: Lead Generation & Affiliate (B2B) – Financial Services

**Model:** Charge financial institutions (banks, NBFCs, insurance) for qualified user leads.

**Sub-Model A: Loan Lead Generation**
- **How It Works:** User asks "How do I get a tractor loan?" → Sathio guides eligibility → if user qualifies, pass to partner bank
- **Pricing:**
  - Success Fee: 0.5–1% of loan disbursed (e.g., ₹50,000 loan → ₹250–₹500 commission)
  - Lead Fee: ₹100–₹500 per qualified lead (user passes eligibility check)
- **Partners:** SBI, HDFC, ICICI, NBFCs (e.g., Ujjivan, Kriya)
- **Monthly Target:** 500–1000 loan leads
- **Estimated Monthly Revenue:** ₹15–₹30 Lakhs (Year 1: ₹1.8–₹3.6 Crores)

**Sub-Model B: Insurance & Investment**
- **Pricing:** ₹2,000–₹5,000 per customer who purchases insurance through Sathio
- **Partners:** ICICI Prudential, LIC, Bajaj Allianz, insurance aggregators
- **Example:** User asks "What's Ayushman Bharat?" → Sathio explains → offers premium health insurance → if purchased, ₹3,000 commission

**Sub-Model C: E-Commerce & Agri-Inputs**
- **Affiliate Commission:** 2–5% per transaction
- **Partners:** Amazon, Flipkart, DeHaat, BigHaat (seeds, fertilizers, equipment)
- **Example:** Farmer buys seeds via Sathio → Sathio earns 5% commission
- **Monthly Target:** 10K transactions
- **Estimated Monthly Revenue:** ₹5–₹10 Lakhs (Year 1: ₹60–₹120 Lakhs)

---

#### Stream 3: Enterprise / Government (B2B2C) – White-Labeled Versions

**Model:** Government departments, banks, and large enterprises license Sathio for their citizens/customers.

**The "Sahayak" Plan (Government Version):**
- **Setup Fee:** ₹25–₹50 Lakhs (one-time)
- **Annual Subscription:** ₹25+ Lakhs per state (e.g., "UP-Sahayak", "Tamil-Sahayak")
- **What's Included:**
  - White-labeled Sathio app with government branding
  - State-specific schemes + government API integrations
  - 24/7 multilingual support
  - Weekly updates with new schemes/policy changes
- **Revenue Model:** Target 5–10 state partnerships in Year 2
- **Estimated Year 2 Revenue:** ₹1.5–₹2 Crores (from government contracts alone)

**Enterprise (Banks / Insurers) Version:**
- **Setup Fee:** ₹5–₹10 Lakhs
- **Annual Subscription:** ₹10–₹25 Lakhs based on user base
- **Example:** SBI wants "SBI-Mitra" (AI assistant for SBI customers)
- **Estimated Year 2 Revenue:** ₹50–₹100 Lakhs (from 5–10 enterprise clients)

---

#### Stream 4: Data Insights & Market Intelligence (B2B2B)

**Model:** Sell aggregated, anonymized insights to businesses about vernacular user behavior.

**What We Know (From User Queries):**
- Regional disease outbreaks (e.g., spike in "pest problem" queries in Malwa region)
- Seasonal demand shifts (e.g., surge in loan inquiries during harvest)
- Product preferences by region (e.g., Tamil Nadu users ask more about aquaculture)
- Eligibility for specific schemes by district

**Buyers:**
- **Fertilizer Companies:** Understand pest outbreaks, crop diseases by region
- **Insurance Companies:** Understand risk profiles, claims patterns
- **FMCG Companies:** Understand rural consumer preferences
- **Government:** Policymakers track service demand, identify gaps

**Pricing:**
- **District-Level Insights:** ₹1–₹5 Lakhs per report
- **Monthly Data Feed:** ₹10–₹50 Lakhs/month (real-time insights)

**Privacy:** 100% anonymized; compliant with data protection laws
- Example Safe Data: "50% of Tamil Nadu farmers asked about cotton prices in July" (NOT "Farmer X asked about cotton")

**Estimated Year 2 Revenue:** ₹30–₹60 Lakhs/month (₹3.6–₹7.2 Crores/year)

---

#### Stream 5: Credit / Microcredit Products (Future)

**Model:** Build a credit layer into Sathio for users to access small loans directly.

**How It Works:**
1. User asks "Can I get a ₹10,000 loan?"
2. Sathio performs KYC + creditworthiness check (based on transaction history, repayment behavior)
3. If eligible, user gets instant micro-loan at 15–18% interest
4. Repayment via daily installments (₹50–₹100/day)

**Why It's Valuable:**
- Borrowers: No collateral, instant disbursal
- Sathio: 2–3% of loan amount as origination fee + interest spread

**Revenue Potential (Year 3+):**
- Scale: 100K borrowers × ₹5,000 average loan = ₹50 Crores AUM (Assets Under Management)
- Revenue: ₹2.5–₹5 Crores/year (fees + interest spread)

---

### 5-Year Revenue Projection (Conservative Scenario)

| Year | B2C Tasks | B2B Leads | B2B2C Enterprise | B2B2B Data | Total Annual | Notes |
|------|-----------|-----------|------------------|-----------|--------------|-------|
| **1** | ₹1 Cr | ₹2 Cr | ₹0.2 Cr | ₹0.5 Cr | **₹3.7 Cr** | MVP launch; pilot regions |
| **2** | ₹3 Cr | ₹6 Cr | ₹1 Cr | ₹3 Cr | **₹13 Cr** | Scale to 5–10M users |
| **3** | ₹5 Cr | ₹15 Cr | ₹3 Cr | ₹8 Cr | **₹31 Cr** | Multi-language expansion |
| **4** | ₹8 Cr | ₹30 Cr | ₹6 Cr | ₹15 Cr | **₹59 Cr** | Profitability phase |
| **5** | ₹12 Cr | ₹50 Cr | ₹10 Cr | ₹25 Cr | **₹97 Cr** | Market leader position |

**Assumptions:**
- User base: 2M (Y1) → 10M (Y2) → 25M (Y3) → 50M (Y4) → 75M (Y5)
- Transaction adoption: 30% (Y1) → 40% (Y2) → 50% (Y3+)
- B2B lead revenue scales with user base

---

### Pricing Tiers (Consumer)

| Tier | Price | Features |
|------|-------|----------|
| **Free** | Free | Voice queries, basic FAQs, max 5 tasks/day |
| **Pay-Per-Task** | ₹5–₹20 | Guided form submission, one-off assistance |
| **Sathio Plus** | ₹49/month or ₹20/week | Unlimited tasks, priority HITL access, offline mode, ad-free |
| **Sathio Premium HITL** | ₹75/consultation | Expert legal, financial, or medical advice via phone/chat |

---

### Go-to-Market Monetization Strategy (Phase 1)

**Months 1–3 (Pilot):**
- Free app; gather user data and feedback
- No direct monetization (build trust + critical mass)
- Partner negotiations with first government department + bank

**Months 4–6 (MVP Launch):**
- Launch pay-per-task model (₹5–₹10 per task)
- Soft-launch with government partner (Sahayak Plan pilot)
- Negotiate first lead-gen contracts with 2–3 NBFCs

**Months 7–12 (Growth):**
- Introduce Sathio Plus (₹49/month) for power users
- Onboard 3–5 government departments
- Scale lead-gen partnerships
- Begin data insights sales

---

## 12. ANALYTICS & KPIS

### Primary Success Metrics (North Star)

#### KPI 1: Daily Active Users (DAU)
- **Definition:** Number of unique users who open Sathio on a given day
- **Target:** 
  - Month 3 (MVP): 10K DAU
  - Month 6: 100K DAU
  - Year 1: 500K DAU
  - Year 2: 5M DAU
- **How to Track:** Google Analytics / Mixpanel event tracking (app_open)
- **Owner:** Growth Lead

#### KPI 2: Task Completion Rate
- **Definition:** % of user queries that result in successful task completion (vs. escalation or error)
- **Target:** ≥ 85% by Month 6
- **How to Track:** Log outcomes for every query (completed, escalated, error)
- **Threshold for Alert:** If TCR drops below 80%, trigger incident review
- **Owner:** Product Lead

#### KPI 3: 7-Day Retention Rate
- **Definition:** % of users who return within 7 days of first app open
- **Target:**
  - Month 1: 25%
  - Month 3: 40%
  - Month 6: 55%
  - Year 1: 65%
- **Industry Benchmark:** Typical app retention is 10–20%; Sathio's premium positioning targets 50%+
- **Owner:** Analytics Lead

#### KPI 4: Cost Per Task (CPT)
- **Definition:** Total compute cost (server, LLM, ASR, TTS) to process one user query
- **Target:** ₹0.50–₹1 per task (including margin)
- **Calculation:** Total monthly infra cost / monthly queries
- **Optimization:** Use IndiaAI subsidized GPUs, fine-tuned lightweight models
- **Owner:** Tech Lead

#### KPI 5: Successful Voice Recognition (SVR) Accuracy
- **Definition:** % of ASR attempts that correctly transcribe user's spoken query
- **Target:** ≥ 85% across all languages by Month 6; ≥ 90% by Month 12
- **Tracking:** Log ASR output vs. user's manual correction
- **Per-Language Tracking:** Monitor separately for Hindi, Tamil, Bengali, Marathi
- **Owner:** NLP Lead

---

### Engagement & Retention Metrics

#### Metric 1: Monthly Active Users (MAU)
- **Target:** 50% of DAU (typical for app category)

#### Metric 2: Task Count Per User (Average)
- **Definition:** Average number of tasks completed per user per month
- **Target:** ≥ 10 tasks/user/month by Month 6 (indicates habit formation)
- **By Persona:**
  - Farmers: 15–20 tasks/month (seasonal peaks)
  - Business owners: 20–30 tasks/month
  - Homemakers: 8–12 tasks/month

#### Metric 3: Premium Conversion Rate
- **Definition:** % of free users who upgrade to Sathio Plus
- **Target:** 5–10% by Year 1
- **Pricing Sensitivity:** A/B test ₹49/month vs. ₹39/month

#### Metric 4: HITL Escalation Rate
- **Definition:** % of queries that escalate to human support
- **Target:** ≤ 5% (low escalation = good AI confidence)
- **If > 10%:** Trigger AI model retraining

#### Metric 5: User Satisfaction (CSAT / NPS)
- **Definition:** Post-task satisfaction survey + Net Promoter Score
- **Method:** After task completion, ask "Kaise raha?" (How was it?) with 1–5 star rating
- **Target:** ≥ 4.2/5 average; NPS ≥ 50
- **Owner:** Customer Success Lead

---

### Monetization & Revenue Metrics

#### Metric 1: Average Revenue Per User (ARPU)
- **Definition:** Monthly revenue / monthly active users
- **Target:**
  - Month 6: ₹2–₹5 ARPU
  - Year 1: ₹10–₹20 ARPU
  - Year 2: ₹50+ ARPU (as enterprise partnerships scale)

#### Metric 2: Transaction Value (AOV – Average Order Value)
- **Definition:** Average amount per transaction
- **By Transaction Type:**
  - Task fees: ₹12 average
  - HITL consultation: ₹75 average
  - Affiliate commission: ₹100 average

#### Metric 3: LTV (Lifetime Value)
- **Definition:** Total revenue expected from a user over 3 years
- **Calculation:** Average monthly revenue × 36 months
- **Target:** ₹5,000–₹10,000 LTV per user (rural segment)
- **By Segment:**
  - Farmers: ₹8,000–₹12,000 LTV (seasonal, high-intent)
  - Business owners: ₹15,000–₹25,000 LTV (frequent, regular)
  - Homemakers: ₹3,000–₹5,000 LTV (occasional)

#### Metric 4: CAC (Customer Acquisition Cost)
- **Definition:** Total marketing spend / new users acquired
- **Target:** ₹20–₹50 CAC (via WhatsApp, local amplification)
- **Payback Period:** LTV / CAC should be ≥ 10:1
- **Owner:** Growth Lead

#### Metric 5: B2B Lead Quality Metrics
- **Definition:** Quality and conversion of leads passed to bank/insurance partners
- **Metrics to Track:**
  - Lead-to-Application Conversion: ≥ 30%
  - Application-to-Disbursal Conversion: ≥ 60%
  - Partner Satisfaction (NPS): ≥ 60
- **Revenue Alignment:** Higher-quality leads → higher pricing power

---

### Technical & Product Health Metrics

#### Metric 1: System Uptime
- **Definition:** % of time Sathio is available and responsive
- **Target:** 99.5% uptime (MVP); 99.9% (post-Series A)
- **Alert:** If < 99.5%, incident response activated

#### Metric 2: API Response Time
- **Definition:** Time from user query to AI response (end-to-end latency)
- **Target:** ≤ 5 seconds (95th percentile)
- **Component Breakdown:**
  - ASR: ≤ 3 seconds
  - NLP processing: ≤ 1 second
  - Response generation: ≤ 1 second

#### Metric 3: Error Rate
- **Definition:** % of queries that fail (timeout, crash, invalid response)
- **Target:** ≤ 0.5%
- **Alert:** If > 1%, trigger incident review

#### Metric 4: Model Accuracy
- **Definition:** Intent classification accuracy
- **Target:** ≥ 90% (by Month 6)
- **Retraining Frequency:** Monthly (with new user feedback)

#### Metric 5: User Feedback Loop
- **Definition:** % of user corrections/feedback vs. total queries
- **Target:** ≥ 5% (to ensure continuous improvement)
- **Usage:** Feed corrections back into model retraining

---

### Dashboard & Reporting

**Real-Time Dashboard (Internal Team):**
- DAU / MAU trends
- Task completion rate
- Escalation rate
- System uptime + latency
- Top queries by intent + language

**Weekly Reports (Leadership):**
- User cohort retention curves
- Revenue by stream (B2C tasks, B2B leads, enterprise)
- CAC vs. LTV analysis
- Top pain points (from escalations)

**Monthly Reviews (Board + Investors):**
- Growth metrics (DAU, MAU, retention)
- Revenue projections vs. actuals
- ARPU and LTV trends
- Competitive positioning

---

## 13. RISKS & CONSTRAINTS

### Technical Risks

#### Risk 1: ASR Accuracy Across Dialects
- **Description:** Accents and dialects vary significantly across regions (coastal Tamil vs. interior Tamil, Bhojpuri vs. Maithili). ASR models may struggle.
- **Impact:** High – if SVR < 80%, users abandon app
- **Mitigation:**
  - Collect diverse audio data from target regions
  - Fine-tune models quarterly
  - Implement accent-aware ASR routing
- **Contingency:** Fallback to text input if voice fails

#### Risk 2: Misinformation & Liability
- **Description:** If Sathio provides incorrect legal, medical, or financial advice, users may suffer harm (financial loss, health complications).
- **Impact:** Critical – legal liability, reputational damage, regulatory action
- **Mitigation:**
  - Implement fact-checking against authoritative sources (government databases)
  - Never provide diagnosis; only provide info + referral to doctors
  - Add disclaimers: "This is informational only; consult an expert"
  - Implement low-confidence escalation (if AI < 60% confident, escalate to human)
- **Insurance:** Obtain E&O (Errors & Omissions) insurance

#### Risk 3: Government API Downtime
- **Description:** Many government portals have poor uptime (especially state-level); if APIs fail, Sathio cannot fulfill tasks.
- **Impact:** Medium – users frustrated; revenue loss for lead-gen
- **Mitigation:**
  - Implement caching for government data (refresh daily)
  - Graceful degradation (if API fails, offer CSC referral or try again later)
  - Maintain backup integrations for critical tasks
- **Contingency:** Cached FAQ + offline mode

#### Risk 4: Compute Cost Overruns
- **Description:** If LLM/ASR inference costs exceed budget (e.g., if subsidized IndiaAI GPUs become unavailable), margins compress.
- **Impact:** Medium – affects profitability
- **Mitigation:**
  - Use lightweight models (DistilBERT, Whisper) instead of large LLMs
  - Rely on Bhashini free APIs; diversify providers
  - Optimize inference (caching, batching, quantization)
  - Negotiate volume discounts with compute providers

---

### Business & Market Risks

#### Risk 1: Competitive Threat from Big Tech
- **Description:** Google, Microsoft, or Amazon could launch similar vernacular AI products with massive resources.
- **Impact:** High – could commoditize market; reduce Sathio's differentiation
- **Mitigation:**
  - Focus on deep domain expertise (government, finance, agriculture) vs. generic AI
  - Build strong government partnerships (hard for big tech to replicate quickly)
  - Establish local brand loyalty in target regions
  - Prioritize speed to market (launch within 6 months)
- **Differentiation:** Sathio is task-focused (not general-purpose); built specifically for India's vernacular users

#### Risk 2: User Adoption Challenges
- **Description:** Rural users may be skeptical of AI; prefer human intermediaries (CSCs, phone calls).
- **Impact:** Medium – slower user growth; lower DAU
- **Mitigation:**
  - Build trust through flawless execution in MVP phase
  - Use local influencers + community leaders as champions
  - Offer human escalation prominently (reduce AI anxiety)
  - Start in regions with higher digital literacy
  - Partner with government to mandate/promote Sathio (e.g., NRLM programs)

#### Risk 3: Monetization Challenges
- **Description:** Users may be unwilling to pay for tasks (accustomed to free CSC services).
- **Impact:** Medium – lower ARPU; longer path to profitability
- **Mitigation:**
  - Position task fees as cheaper than travel + cyber cafe costs
  - Offer free tier with limited tasks (drive adoption first)
  - Emphasize convenience + time savings (not cost alone)
  - B2B revenue (enterprise, lead-gen) offsets weak B2C
- **Pricing Elasticity:** A/B test pricing to find sweet spot (₹5 vs. ₹10 task fee)

#### Risk 4: Regulatory / Compliance Risk
- **Description:** Government may impose strict regulations on AI usage, data handling, or language promotion. Privacy laws (DPDPA) may impose new compliance burdens.
- **Impact:** Medium – may require architecture changes, reduce data monetization
- **Mitigation:**
  - Engage proactively with government (show alignment with Bhashini, Digital ShramSetu missions)
  - Implement strong data protection (GDPR-compliant, DPDPA-ready)
  - Build compliance into architecture from day 1 (not an afterthought)
  - Legal counsel on Indian tech regulations

---

### Market & Strategic Risks

#### Risk 1: Rural Market Penetration Slower Than Expected
- **Description:** Smartphone adoption is 84%, but digital service adoption may lag; user behavior change takes time.
- **Impact:** Medium – lower user growth; longer burn runway
- **Mitigation:**
  - Start in high-adoption pockets (southern states, agricultural regions)
  - Pilot government partnerships to mandate usage
  - Invest in community brand-building + grassroots marketing
  - Consider feature phone + IVR versions (expand addressable market)

#### Risk 2: Language Fragmentation
- **Description:** Supporting 22 languages is complex; users may expect perfect support in niche dialects.
- **Impact:** Low-Medium – quality management challenge
- **Mitigation:**
  - Start with 3–4 languages; expand strategically
  - Set clear expectations (support major languages only initially)
  - Use community feedback to prioritize next languages
  - Leverage Bhashini + open-source resources

#### Risk 3: Sustainability of Government Partnerships
- **Description:** Government priorities shift; budget cycles may cut funding; political changes may affect support.
- **Impact:** Medium – revenue uncertainty from B2B2C segment
- **Mitigation:**
  - Diversify revenue (don't over-rely on any single government department)
  - Build switching costs (integrate deeply with government workflows)
  - Maintain strong political relationships + advocacy
  - Have commercial B2C/B2B fallback

---

### Operational Risks

#### Risk 1: Talent & Team Constraints
- **Description:** Finding multilingual NLP engineers, vernacular AI experts, and local domain experts is difficult.
- **Impact:** Medium – slow product development, quality issues
- **Mitigation:**
  - Build in partnership with universities (IIT, IIIT) for talent
  - Engage domain experts as advisors / part-time contributors
  - Invest in training programs for internal capability
  - Consider nearshore hiring (e.g., Bharat teams are more cost-effective than Bangalore)

#### Risk 2: Data Quality & Bias
- **Description:** AI models may encode regional bias (e.g., over-represent urban experiences; underrepresent marginal groups).
- **Impact:** Medium – reduced trust, user complaints, regulatory pushback
- **Mitigation:**
  - Audit models for bias (especially in loan eligibility, health info)
  - Diverse training data (rural + urban, all income levels, all genders)
  - Community feedback + oversight
  - Regular bias audits (quarterly)

---

## 14. ASSUMPTIONS & OPEN QUESTIONS

### Key Assumptions

1. **Government API Availability:** We assume Aadhaar, PAN, PM-Kisan APIs will remain accessible and stable. (Mitigation: Plan for degradation)

2. **Bhashini API Sustainability:** We assume Bhashini free APIs remain available for ASR/TTS. (Mitigation: Maintain fallback open-source models)

3. **User Demand Exists:** We assume users will actively use Sathio for government/financial tasks. (Validation: Pilot program will confirm)

4. **Trust Can Be Built:** We assume clear, honest communication can overcome AI skepticism. (Validation: User feedback, NPS tracking)

5. **Regulatory Friendliness:** We assume India's government will support vernacular AI initiatives. (Evidence: Bhashini, Digital ShramSetu, IndiaAI Mission)

6. **Smartphone Access:** We assume 84% rural smartphone penetration is stable/growing. (Risk: If adoption plateaus, addressable market smaller)

---

### Open Questions (To Be Resolved in Pilot Phase)

1. **Which language to pilot first?** Hindi (largest user base) vs. Tamil (high digital literacy in TN)?
   - **Recommendation:** Pilot both; measure adoption + satisfaction; scale based on results

2. **Which state/region for pilot?** North vs. South vs. East?
   - **Recommendation:** Start in Tamil Nadu (high digital adoption) + Uttar Pradesh (massive population). Learn from both.

3. **Government partnership strategy:** Should we approach state or central government first?
   - **Recommendation:** Pursue state-level pilots (faster decisions, lower bureaucracy) + central validation (Bhashini partnership)

4. **Premium pricing elasticity:** What's the optimal price point for Sathio Plus?
   - **Recommendation:** A/B test ₹29/month vs. ₹49/month vs. ₹99/month; measure conversion + retention

5. **HITL scaling:** How to hire & train multilingual support agents at scale?
   - **Recommendation:** Build a "hub + spoke" model (central training; distributed regional agents)

6. **Offline capability scope:** Which features to pre-download? Estimated device storage?
   - **Recommendation:** Pre-cache FAQ for 3 languages (≤ 50 MB); user can expand based on preference

7. **Dial-ability strategy:** Should we build IVR (voice call) version for feature phone users early or post-MVP?
   - **Recommendation:** Post-MVP (focus on Android first; IVR planned for Month 10+)

8. **Data monetization ethics:** How to ensure data insights don't violate user privacy or become exploitative?
   - **Recommendation:** Establish Data Ethics Board; user consent for analytics; fully anonymized data only

9. **Competitive response:** How will we defend against Google, Microsoft, or local startups?
   - **Recommendation:** Focus on defensible moat = deep government integration + community trust + financial service ecosystem

10. **International expansion timing:** When should we target other multilingual markets (Indonesia, Africa)?
    - **Recommendation:** Post-Series A (Year 2+); only after strong India traction. Adapt model for each market.

---

### Success Milestones & Validation Gates

**Milestone 1: MVP Launch (Week 12)**
- 1 language working well (≥ 85% SVR)
- 3 core features (government, utilities, health)
- 500+ beta testers
- NPS ≥ 40

**Milestone 2: Government Partnership (Month 6)**
- 1 state government partnership signed
- Integrated with ≥ 1 government API
- ≥ 50K DAU

**Milestone 3: Revenue Traction (Month 9)**
- 10% monthly retention
- ARPU ≥ ₹5
- ≥ 5 B2B partnerships (banks/NBFCs)

**Milestone 4: Series A Readiness (Month 18)**
- ≥ 1M DAU
- ≥ ₹50+ LTV
- 2–3 languages + 2–3 government partnerships
- Clear path to profitability

---

## 15. APPENDIX: SUGGESTED ENHANCEMENTS (Suggested by Product Analysis)

These are valuable features not explicitly mentioned but inferred as logical additions:

### A. User Feedback & Continuous Improvement Loop
- **Post-task feedback:** "Was this helpful? Yes / No"
- **Detailed feedback form:** "What could be better?"
- **Feedback → Training:** Poor feedback triggers model retraining on that task
- **User incentives:** ₹5 reward for every 10 pieces of feedback (encourage participation)

### B. Contextual Help & In-App Guidance
- **"?" button in every screen:** Context-sensitive help
- **Video tutorials:** Short (30-sec) clips showing how to use Sathio (optional captions)
- **Chatbot tips:** "Did you know? You can ask 'PM-Kisan status' to check subsidy..."

### C. Fraud Detection & Safety
- **Warn against scams:** If user query seems like fraud susceptibility ("How to pay income tax to lottery winner?"), warn them
- **Verified sources:** Clearly label responses with "Verified by [Government/Expert]"
- **Report scams:** Allow users to flag suspicious calls / websites

### D. Social Proof & Community
- **User testimonials:** "Ravi from Bihar got his Aadhaar in 10 minutes!"
- **Success stories:** Highlight how Sathio helped real users
- **Community forum:** (Future) Allow users to ask/answer questions for regional language peers

### E. Accessibility Enhancements
- **Dyslexia-friendly fonts:** Support Comic Sans + high contrast themes
- **Customizable speech speed:** Allow users to adjust TTS playback speed (80–180 wpm)
- **Haptic feedback:** Vibration cues for button taps, errors, confirmations

### F. Seasonal Campaigns & Engagement
- **Harvest season campaigns:** "Check PM-Kisan status now!"
- **School admission campaigns:** Promote scholarship info during June–August
- **Tax season campaigns:** Promote income tax filing in Feb–March
- **Push notifications:** Soft, value-driven (not spam); 1–2 per month max

---

## 16. DOCUMENT METADATA

- **Document Version:** 1.0
- **Date:** February 2, 2026
- **Prepared By:** Product Strategy Team (Sathio)
- **Status:** Ready for Development & Stakeholder Review
- **Next Steps:** 
  - Engineering team to finalize technical architecture
  - Design team to create detailed wireframes + prototypes
  - Launch pilot program (Week 1)

---

**END OF PRD**
