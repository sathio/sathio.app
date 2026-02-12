# SATHIO — IMPLEMENTATION PLAN

**Version:** 2.0 (LAM Architecture)  
**Date:** February 12, 2026  
**Status:** Engineering-Ready  
**Prepared For:** Engineering, DevOps, and Execution Teams

---

## OVERVIEW

This document provides the technical roadmap for building Sathio — a Large Action Model (LAM) that autonomously controls the user's phone to complete any digital task via voice commands in their native language.

**Timeline:** MVP Launch in 16-20 weeks (Phase 0 + Phase 1 + Phase 2)

---

## 1. DEVELOPMENT PHASES

### Phase 0: Foundation (Weeks 0-4)

**Goal:** Establish core infrastructure, voice pipeline, and Accessibility Service

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 1-2 | Project Setup | Repo, CI/CD, dev env, Flutter scaffold |
| Week 3-4 | Voice + Device Control | ASR/TTS integration, Accessibility Service setup |

**Key Milestones:**
- [ ] Development environment configured
- [ ] Bhashini API integration working (STT + TTS)
- [ ] Android Accessibility Service registered and functional
- [ ] Can programmatically tap, type, scroll on any screen
- [ ] Basic intent classifier trained on 500 sample queries

---

### Phase 1: Core LAM Engine (Weeks 4-10)

**Goal:** Build the autonomous task execution engine

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 5-6 | Screen Reader + VLM | Vision model reads any screen, identifies UI elements |
| Week 7-8 | Action Executor | Tap, type, scroll, navigate based on VLM output |
| Week 9-10 | Slot Filling + Safety | Conversational data collection, safety controls |

**Key Milestones:**
- [ ] VLM can read and describe any Android screen
- [ ] Action executor can fill a form on a website end-to-end
- [ ] Slot filling dialogue asks user for missing fields
- [ ] Safety: confirmation before payments/submissions
- [ ] Floating overlay shows current action to user

---

### Phase 2: Task Flows + UI (Weeks 10-16)

**Goal:** Build pre-mapped task flows and polished UI

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 11-12 | Government Tasks | Aadhaar download, PM-Kisan, PAN — fully autonomous |
| Week 13-14 | Utility + Commerce | Bill payment, mobile recharge, basic shopping |
| Week 15-16 | App UI + Onboarding | Home screen, onboarding flow, history, profile |

**Key Milestones:**
- [ ] 5 government service tasks working autonomously
- [ ] Bill payment cross-app automation working
- [ ] 4 languages working with >80% accuracy
- [ ] Duolingo-style onboarding complete
- [ ] APK size <50MB, runs on 2GB RAM devices

---

### Phase 3: Scale & Monetization (Weeks 16-24)

**Goal:** Launch monetization, advanced LAM features, beta testing

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 17-18 | Payments + Credits | UPI integration, Sathio Plus subscriptions |
| Week 19-20 | Advanced LAM | Train booking, shopping, WhatsApp automation |
| Week 21-22 | Admin + Analytics | Content management, usage analytics dashboard |
| Week 23-24 | Beta + Polish | 1000 beta testers, bug fixes, performance tuning |

**Key Milestones:**
- [ ] Payment gateway live
- [ ] 15+ autonomous task types working
- [ ] Admin dashboard for content updates
- [ ] 10K+ DAU

---

### Phase 4: Expansion (Months 6-12)

**Goal:** Language expansion, B2B, advanced capabilities

| Focus Area | Deliverables |
|------------|--------------|
| Languages | Add Telugu, Kannada, Gujarati, Punjabi |
| Advanced LAM | Any website form, any app, complex multi-step flows |
| WhatsApp Bot | Voice + text LAM over WhatsApp |
| B2B | Lead generation, government partnerships |
| Human Escalation | Expert consultation marketplace |

---

## 2. MVP SCOPE DEFINITION

### In Scope (MVP)

| Category | Features |
|----------|----------|
| **Languages** | Hindi, Tamil, Bengali, Marathi |
| **Voice** | Tap-to-talk, TTS responses, code-mixing |
| **LAM Core** | Accessibility Service, VLM screen reader, Action executor |
| **Government** | Aadhaar download, PAN apply, PM-Kisan registration (AUTONOMOUS) |
| **Utilities** | Bill payment, mobile recharge (CROSS-APP AUTOMATION) |
| **Health/Edu** | Ayushman Bharat, Scholarships (info + form filling) |
| **Safety** | Floating overlay, kill switch, confirmation prompts |
| **UI** | Icon-based, large buttons, execution overlay |
| **Platform** | Android only (5.0+) |

### Out of Scope (MVP)

| Feature | Phase |
|---------|-------|
| iOS app | Phase 4 |
| Train/flight booking | Phase 3 |
| WhatsApp bot | Phase 4 |
| Voice commerce (shopping) | Phase 3 |
| More than 4 languages | Phase 4 |

---

## 3. SYSTEM ARCHITECTURE

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        USER DEVICE                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │ Voice Input │  │ Local Cache │  │ UI Layer (Kotlin/Flutter)│ │
│  │ (VAD + Mic) │  │ (SQLite)    │  │                         │  │
│  └──────┬──────┘  └──────┬──────┘  └────────────┬────────────┘  │
└─────────┼────────────────┼──────────────────────┼───────────────┘
          │                │                      │
          └────────────────┼──────────────────────┘
                           │ HTTPS/TLS 1.3
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                      API GATEWAY                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │ Rate Limit  │  │ JWT Auth    │  │ Load Balancer           │  │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘  │
└─────────────────────────────┬───────────────────────────────────┘
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
┌──────────────────┐ ┌──────────────────┐ ┌──────────────────┐
│   ASR SERVICE    │ │   NLP SERVICE    │ │   TTS SERVICE    │
│  (Bhashini/      │ │  (DistilBERT/    │ │  (Bhashini/      │
│   Whisper)       │ │   FastAPI)       │ │   Coqui)         │
└────────┬─────────┘ └────────┬─────────┘ └────────┬─────────┘
         └────────────────────┼────────────────────┘
         └────────────────────┼────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    AGENTIC CORE (LAM)                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ Workflow    │  │ Vision Model│  │ Slot Filling│              │
│  │ Engine      │  │ (UI Reader) │  │ Manager     │              │
│  │ (Reasoning) │  │             │  │             │              │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘              │
└─────────┼────────────────┼────────────────┼─────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    CORE SERVICES                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ FAQ/KB      │  │ Govt API    │  │ HITL        │              │
│  │ Service     │  │ Gateway     │  │ Escalation  │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ User        │  │ Transaction │  │ Analytics   │              │
│  │ Service     │  │ Service     │  │ Service     │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
└─────────────────────────────┬───────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      DATA LAYER                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ PostgreSQL  │  │ MongoDB     │  │ Redis       │              │
│  │ (Users,     │  │ (FAQs,      │  │ (Cache,     │              │
│  │ Transactions)│ │ Schemes)    │  │ Sessions)   │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ Vector DB (Pinecone/Milvus) - Semantic Search               │ │
│  └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

---

## 4. TECHNOLOGY STACK

### Frontend (Mobile)

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Framework** | Kotlin (Native Android) | Superior performance on low-end devices |
| **Alternative** | Flutter | Cross-platform, faster dev, excellent offline support |
| **UI Toolkit** | Jetpack Compose | Modern, declarative UI |
| **Minimum SDK** | 21 (Android 5.0) | Wide device coverage |
| **Target SDK** | 33+ (Android 13) | Latest features |
| **Audio** | AudioRecord / speech_to_text | Voice capture |
| **Automation** | AccessibilityService API | Active Agent actions (clicks/scrolls) |
| **Offline DB** | Room (SQLite) | FAQ caching |
| **Networking** | Retrofit + OkHttp | API calls |
| **Image Loading** | Coil/Glide | Efficient caching |
| **State Management** | ViewModel + StateFlow | Reactive UI |
| **Analytics** | Firebase Analytics | User tracking |
| **Push** | Firebase Cloud Messaging | Notifications |

### Backend

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **API Framework** | FastAPI (Python) | Async, ML-friendly, fast |
| **Alt API** | Node.js (Express) | Lightweight, fast |
| **Containerization** | Docker + Kubernetes | Scalable deployment |
| **API Gateway** | Kong / AWS API Gateway | Rate limiting, auth |
| **Orchestration** | K8s on GKE / EKS | Managed Kubernetes |
| **Language** | Python 3.11+ | ML ecosystem |

### AI / ML Components

#### Voice & Language (All Indian Languages)

| Component | Primary (Free) | Premium Alternative | Fallback (Offline) |
|-----------|---------------|---------------------|-------------------|
| **ASR (Speech-to-Text)** | Bhashini ASR API | Sarvam AI ASR | speech_to_text (Flutter) |
| **TTS (Text-to-Speech)** | Bhashini TTS | Sarvam AI TTS (human-like) | flutter_tts (on-device) |
| **Language Detection** | Bhashini Language ID | Sarvam AI | User preference fallback |
| **Translation** | Bhashini NMT | Sarvam Translate | - |

> **Decision Pending:** Bhashini (free, all 22 languages, govt API) vs Sarvam AI (human-like voice, natural conversation, paid).
> Both should be implemented with a service abstraction layer so the choice can be swapped easily.

#### AI Brain (Understanding + Planning)

| Component | Primary | Fallback | Notes |
|-----------|---------|----------|-------|
| **Intent Classification** | Gemini 1.5 Flash | DistilBERT (fine-tuned) | Fast, handles Hindi/mixed |
| **Action Planning (LAM)** | Gemini 1.5 Pro | GPT-4o | Multi-step task decomposition |
| **Conversational AI** | Gemini 1.5 Flash | Sarvam-2B | Slot filling, follow-ups |
| **Indian Context LLM** | Sarvam-2B | Gemini Flash | Natively understands PM-Kisan, Aadhaar etc. |
| **Semantic Search** | Sentence-Transformers | Supabase pgvector | FAQ matching |
| **Embeddings** | Multilingual SBERT | - | - |

#### Vision AI (LAM Screen Reading)

| Component | Primary | Fallback | Notes |
|-----------|---------|----------|-------|
| **Screen Understanding** | Gemini 1.5 Pro Vision | GPT-4o Vision | Reads screenshots, identifies UI elements |
| **OCR (Camera/Images)** | Google ML Kit (on-device) | Gemini Vision | Bill reading, document scanning — works offline |
| **CAPTCHA Solving** | Gemini Vision | - | Basic text CAPTCHAs only |

#### Device Control (No external API needed)

| Component | Technology | Notes |
|-----------|-----------|-------|
| **Tap, Type, Scroll** | Android Accessibility Service | Built-in Android API, free |
| **Open Apps** | Android Intent System | Native Android |
| **Read SMS (OTPs)** | Android SMS API | With user permission |
| **System Overlay** | Android Window Manager | "Sathio is working..." floating pill |
| **Agent Framework** | Custom State Machine | LangChain as optional abstraction |

### Databases

| Database | Purpose | Tech |
|----------|---------|------|
| **Primary** | Users, transactions, sessions | PostgreSQL (Supabase) |
| **Local Cache** | Offline data, preferences | Hive (Flutter) |
| **Document** | FAQs, schemes, guides | Supabase JSONB |
| **Vector** | Semantic search embeddings | Supabase pgvector |
| **Analytics** | Events, metrics | Mixpanel / PostHog |

### Infrastructure

| Component | Provider | Notes |
|-----------|----------|-------|
| **Cloud** | Google Cloud Platform | India region (Mumbai) |
| **Alternative** | AWS | Multi-region option |
| **Compute** | GKE (Kubernetes) | Auto-scaling |
| **GPU** | IndiaAI Mission | Subsidized (~₹65/hr) |
| **CDN** | CloudFlare | TTS + FAQ distribution |
| **DNS** | CloudFlare | Fast resolution |
| **Monitoring** | DataDog / Grafana | Real-time metrics |
| **Logging** | ELK Stack | Centralized logs |
| **Error Tracking** | Sentry | Crash reporting |

### External Integrations

| Integration | API | Purpose |
|-------------|-----|---------|
| **Bhashini** | bhashini.gov.in | ASR, TTS, Language ID, Translation (FREE — all 22 languages) |
| **Sarvam AI** | sarvam.ai | Premium ASR, TTS (human-like voice), Sarvam-2B LLM |
| **Gemini** | Google AI Studio | Intent classification, action planning, Vision (screen reading) |
| **GPT-4o** | OpenAI API | Fallback for Gemini (brain + vision) |
| **Google ML Kit** | On-device | OCR, text recognition (offline, free) |
| **UIDAI** | Aadhaar APIs | Identity verification |
| **NSDL** | PAN APIs | Tax services |
| **PM-Kisan** | Agriculture portal | Subsidy status |
| **Razorpay** | Payment Gateway | UPI, cards |
| **WhatsApp** | Business API | Escalation |
| **Firebase** | FCM | Push notifications |

### API Cost Estimate

| Service | Free Tier | At Scale (10K users) |
|---------|-----------|---------------------|
| **Bhashini** | ✅ Always free | ₹0 |
| **Sarvam AI** | ✅ Limited free | ~₹2,000-5,000/mo |
| **Gemini** | ✅ Generous free | ~₹2,000-4,000/mo |
| **GPT-4o** | ❌ Pay-per-use | Backup only |
| **Supabase** | ✅ Free tier | ~₹1,500/mo |
| **Firebase FCM** | ✅ Always free | ₹0 |
| **Total MVP** | **₹0** | **~₹5,000-10,000/mo** |

---

## 5A. LAM ENGINE ARCHITECTURE

### How the LAM Works (Technical)

```
User Voice → STT → Intent + Task Detection → Action Planner
                                                    │
                    ┌───────────────────────────────┘
                    ▼
            ┌──────────────────┐
            │  ACTION PLANNER  │  ← Breaks task into micro-actions
            │  (LLM Reasoning) │
            └────────┬─────────┘
                     │ Action Sequence
                     ▼
            ┌──────────────────┐
            │  SCREEN READER   │  ← Takes screenshot, identifies UI elements
            │  (Vision Model)  │
            └────────┬─────────┘
                     │ UI Element Map
                     ▼
            ┌──────────────────┐
            │ ACTION EXECUTOR  │  ← Performs tap, type, scroll, navigate
            │ (Accessibility   │
            │  Service)        │
            └────────┬─────────┘
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
   ┌──────────────┐    ┌──────────────────┐
   │ SLOT FILLER  │    │ SAFETY MONITOR   │
   │ (Ask user    │    │ (Block dangerous │
   │  for info)   │    │  actions)        │
   └──────────────┘    └──────────────────┘
```

### Key Components

#### 1. Android Accessibility Service
- **Purpose:** Controls any app on the phone programmatically
- **Capabilities:** Click, type, scroll, swipe, read screen text, navigate between apps
- **Implementation:** Extends `AccessibilityService` class
- **Permissions:** User grants once during onboarding
- **Scope:** Can interact with ANY app, browser, or system UI

#### 2. Vision-Language Model (Screen Reader)
- **Purpose:** Understands what's on the screen — buttons, forms, text, images
- **Model:** Gemini Flash / GPT-4o-mini (API-based) or on-device SLM
- **Input:** Screenshot (compressed JPEG, ~100KB)
- **Output:** Structured JSON of all UI elements with coordinates
- **Latency:** <1.5 seconds per screen read
- **Fallback:** Accessibility node tree parsing (faster, less accurate)

#### 3. Action Planner (Agent Brain)
- **Purpose:** Decomposes user request into ordered action sequence
- **Model:** LLM with task-specific prompting
- **Pre-mapped flows:** 20+ common tasks (Aadhaar, PM-Kisan, etc.) have hardcoded action sequences for reliability
- **Dynamic planning:** For unknown tasks, LLM generates plan on-the-fly using VLM observations
- **Error recovery:** If an action fails, replans with new screen state

#### 4. Slot Filling Manager
- **Purpose:** Collects user info conversationally when needed
- **How:** Pauses execution → asks user → resumes with answer
- **Storage:** User profile (name, state, district) stored for reuse. Sensitive data (Aadhaar, PAN) encrypted or asked fresh.
- **OTP Handling:** Reads OTP from SMS (with permission) or asks user to speak it

#### 5. Safety & Trust System

| Control | Description |
|---------|-------------|
| **Floating Overlay** | Always visible — shows what Sathio is doing |
| **Voice Narration** | Sathio speaks each action before doing it |
| **Confirm Critical** | Explicit "Haan" required before payment/submit |
| **Kill Switch** | Say "Ruko" or tap stop — instant halt |
| **Action Blacklist** | Cannot: delete apps, change settings, access banking PINs |
| **Transaction Cap** | >₹5,000 requires double confirmation |
| **Audit Log** | Every action recorded with timestamp + screenshot |
| **Timeout** | Auto-pause after 60s of no progress |

---

## 5. FEATURE-WISE IMPLEMENTATION ORDER

### Sprint 1-2: Foundation

```
Week 1:
├── Repository setup (monorepo structure)
├── CI/CD pipeline (GitHub Actions)
├── Development environments (Docker Compose)
├── Code standards and linting
└── Basic Android project scaffold

Week 2:
├── Bhashini API integration (STT)
├── Bhashini API integration (TTS)
├── Basic voice capture module
├── Audio streaming to backend
└── Response playback module
```

### Sprint 3-4: Voice Pipeline

```
Week 3:
├── Intent classification model training
├── FAQ database setup (MongoDB)
├── Knowledge base import (5 govt services)
├── Response generation templates
└── Basic conversational flow

Week 4:
├── Language selection UI
├── Voice confirmation ("Samajh gaya")
├── Error handling ("Network slow hai")
├── Code-mixing support
└── Performance optimization (<3s latency)
```

### Sprint 5-6: LAM Core Engine

```
Week 5:
├── Accessibility Service setup
├── Basic actions: tap, type, scroll, navigate
├── Screen capture and compression
├── VLM integration for screen reading
└── UI element detection and mapping

Week 6:
├── Action Planner (LLM-based)
├── Pre-mapped flow for Aadhaar download
├── Slot filling dialogue manager
├── OTP reading from notifications
└── Floating overlay UI (shows current action)
```

### Sprint 7-8: Task Flows + Safety

```
Week 7:
├── Aadhaar download — fully autonomous
├── PM-Kisan registration — fully autonomous
├── PAN application — fully autonomous
├── Cross-app navigation (browser ↔ UPI app)
└── Error recovery and replanning

Week 8:
├── Safety controls (confirm, kill switch, blacklist)
├── Action audit logging
├── Bill payment automation (electricity)
├── Mobile recharge automation
└── File download and save
```
```

### Sprint 9-10: Integration & Testing

```
Week 9:
├── End-to-end flow testing
├── Load testing (10K concurrent)
├── Performance optimization
├── Battery optimization
└── APK size optimization (<40MB)

Week 10:
├── Beta tester onboarding (500 users)
├── Feedback collection system
├── Crash analytics setup
├── Bug fixes from beta
└── MVP feature freeze
```

---

## 6. API & SERVICE DESIGN

### Core API Endpoints

```
POST /api/v1/voice/transcribe
- Input: audio file (WAV/MP3), language
- Output: text transcript, confidence

POST /api/v1/query/process
- Input: text query, user_id, language
- Output: intent, task_plan, slot_requirements

POST /api/v1/tts/synthesize
- Input: text, language, voice_id
- Output: audio file URL

POST /api/v1/lam/plan
- Input: user_intent, screen_state, user_profile
- Output: action_sequence[{type, target, value}]

POST /api/v1/lam/read-screen
- Input: screenshot (JPEG), context
- Output: ui_elements[{type, text, bounds, clickable}]

POST /api/v1/lam/slot-fill
- Input: task_context, collected_data, missing_fields
- Output: next_question, field_name

POST /api/v1/user/register
- Input: phone, OTP
- Output: user_id, token

GET  /api/v1/user/profile
- Output: preferences, history, saved_data

POST /api/v1/task/log
- Input: task_type, actions_taken, result, duration
- Output: task_id
```

### Service Communication

```
┌─────────────┐     gRPC      ┌─────────────┐
│ API Gateway │ ────────────► │ ASR Service │
└─────────────┘               └─────────────┘
       │
       │ REST/gRPC
       ▼
┌─────────────┐     gRPC      ┌─────────────┐
│ NLP Service │ ────────────► │ KB Service  │
└─────────────┘               └─────────────┘
       │
       │ Async (Redis Queue)
       ▼
┌─────────────┐
│ Analytics   │
└─────────────┘
```

---

## 7. DATA MODELS

### User Model (PostgreSQL)

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    language_preference VARCHAR(10) NOT NULL DEFAULT 'hi',
    state VARCHAR(50),
    district VARCHAR(50),
    credits_balance DECIMAL(10,2) DEFAULT 0,
    subscription_type VARCHAR(20) DEFAULT 'free',
    subscription_expiry TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sessions (
    session_id UUID PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    device_info JSONB,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_active TIMESTAMP
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    amount DECIMAL(10,2) NOT NULL,
    type VARCHAR(50) NOT NULL, -- 'credit_purchase', 'task_fee', 'subscription'
    status VARCHAR(20) NOT NULL,
    payment_reference VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE query_history (
    query_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    query_text TEXT NOT NULL,
    intent VARCHAR(100),
    response_summary TEXT,
    task_completed BOOLEAN DEFAULT FALSE,
    language VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### FAQ Model (MongoDB)

```javascript
{
  _id: ObjectId,
  question: String,
  answer: String,
  language: String, // 'hi', 'ta', 'bn', 'mr'
  category: String, // 'government', 'utility', 'health', 'education'
  subcategory: String, // 'aadhaar', 'pan', 'pm-kisan'
  state: String, // Optional, for state-specific content
  steps: [
    {
      step_number: Number,
      instruction_text: String,
      instruction_audio_url: String,
      visual_hint: String,
      action_url: String
    }
  ],
  document_checklist: [String],
  keywords: [String],
  embedding: [Float], // For semantic search
  created_at: Date,
  updated_at: Date
}
```

---

## 8. DEVOPS & DEPLOYMENT

### CI/CD Pipeline

```yaml
# .github/workflows/main.yml
name: Sathio CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Tests
        run: |
          pip install -r requirements.txt
          pytest tests/ --cov=src

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Build Docker Images
        run: docker-compose build
      - name: Push to Registry
        run: docker push gcr.io/sathio/api:${{ github.sha }}

  deploy-staging:
    needs: build
    if: github.ref == 'refs/heads/develop'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Staging
        run: kubectl apply -f k8s/staging/

  deploy-production:
    needs: build
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Production
        run: kubectl apply -f k8s/production/
```

### Kubernetes Deployment

```yaml
# k8s/production/api-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sathio-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: sathio-api
  template:
    metadata:
      labels:
        app: sathio-api
    spec:
      containers:
      - name: api
        image: gcr.io/sathio/api:latest
        ports:
        - containerPort: 8000
        resources:
          requests:
            memory: "512Mi"
            cpu: "500m"
          limits:
            memory: "1Gi"
            cpu: "1000m"
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: sathio-secrets
              key: database-url
```

### Monitoring Setup

| Tool | Purpose | Alerts |
|------|---------|--------|
| **DataDog/Grafana** | Metrics dashboard | CPU >80%, Memory >80% |
| **Prometheus** | Metrics collection | Error rate >1% |
| **Sentry** | Error tracking | New exceptions |
| **ELK Stack** | Log aggregation | Failed queries |
| **PagerDuty** | Incident management | Uptime <99.5% |

---

## 9. MONETIZATION ROLLOUT TIMING

| Phase | Week | Feature | Revenue Target |
|-------|------|---------|----------------|
| MVP | 10 | Free tier only | ₹0 (user acquisition) |
| MVP+ | 14 | Pay-per-task (₹5-10) | ₹1L/month |
| MVP+ | 16 | Credit system | ₹5L/month |
| Scale | 20 | Sathio Plus (₹49-99) | ₹15L/month |
| Scale | 22 | HITL consultations | ₹5L/month |
| Scale | 24 | B2B lead gen | ₹30L/month |

---

## 10. COST DRIVERS & INFRASTRUCTURE

### Monthly Cost Estimates (MVP)

| Component | Cost (₹) | Notes |
|-----------|----------|-------|
| GCP Compute (3 nodes) | ₹1.5L | Auto-scaling |
| Bhashini API | Free | Government subsidy |
| IndiaAI GPUs | ₹50K | Subsidized rates |
| MongoDB Atlas | ₹30K | M10 cluster |
| PostgreSQL | ₹20K | Cloud SQL |
| Redis | ₹15K | Memory store |
| CloudFlare CDN | ₹10K | Pro plan |
| Firebase | ₹5K | Push + Analytics |
| **Total MVP** | **₹2.8L/month** | |

### Scaling Cost Projection

| Phase | DAU | Monthly Cost |
|-------|-----|--------------|
| MVP | 10K | ₹2.8L |
| Growth | 100K | ₹8L |
| Scale | 500K | ₹25L |
| Mature | 1M+ | ₹50L+ |

---

## 11. SCALING & PERFORMANCE PLAN

### Performance Targets

| Metric | MVP | 6 Months | 12 Months |
|--------|-----|----------|-----------|
| Concurrent Users | 10K | 100K | 1M |
| API Latency (p95) | <5s | <3s | <2s |
| ASR Accuracy | 80% | 85% | 90% |
| Uptime | 99.5% | 99.9% | 99.95% |

### Scaling Strategy

```
Phase 1 (MVP): Single Region
├── GKE Cluster (Mumbai)
├── 3 API nodes (auto-scale 3-10)
├── 1 ML inference node
└── Managed databases

Phase 2 (100K+ DAU): Multi-AZ
├── GKE Cluster (Mumbai + Bangalore)
├── 10 API nodes (auto-scale 10-50)
├── 3 ML inference nodes
├── Read replicas for DB
└── CDN for TTS cache

Phase 3 (1M+ DAU): Multi-Region
├── GKE Clusters (Mumbai, Bangalore, Delhi)
├── 50+ API nodes
├── GPU cluster for ML
├── Sharded databases
└── Global CDN
```

---

## 12. RISK AREAS & TECHNICAL DEBT

### Known Technical Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| ASR accuracy variance | High | Continuous fine-tuning, fallback to text |
| Government API reliability | High | Caching, graceful degradation |
| Model size vs device RAM | Medium | Model quantization, lazy loading |
| Battery drain from voice | Medium | VAD optimization, efficient audio processing |

### Planned Technical Debt

| Item | Reason | Payoff Phase |
|------|--------|--------------|
| Hardcoded FAQ responses | Speed to MVP | Phase 2 (dynamic) |
| Single language model | Simplicity | Phase 3 (multi-model) |
| No offline ML inference | Complexity | Phase 4 |
| Manual content updates | Speed | Phase 2 (CMS) |

### Quality Gates

| Gate | Criteria | Owner |
|------|----------|-------|
| Code Review | 2 approvals required | Tech Lead |
| Test Coverage | >80% for new code | QA Lead |
| Performance | <5s API response, <40MB APK | DevOps |
| Security | OWASP scan, no critical issues | Security |
| Accessibility | WCAG AA compliance | Design |

---

## 13. TEAM STRUCTURE (RECOMMENDED)

### MVP Team (12-15 people)

```
Engineering Lead
├── Android Team (3)
│   ├── Senior Android Dev
│   ├── Android Dev
│   └── UI/UX Dev
├── Backend Team (3)
│   ├── Senior Backend Dev
│   ├── API Dev
│   └── Database/DevOps
├── ML/AI Team (2)
│   ├── ML Engineer (NLP)
│   └── ML Engineer (Speech)
├── QA Team (2)
│   ├── QA Lead
│   └── QA Engineer
└── Support (2)
    ├── Product Manager
    └── Designer
```

### Skill Requirements

| Role | Key Skills |
|------|------------|
| Android Dev | Kotlin, Jetpack, Audio APIs, offline-first |
| Backend Dev | Python/FastAPI, PostgreSQL, Redis, K8s |
| ML Engineer | PyTorch, Transformers, ASR/TTS, fine-tuning |
| DevOps | Docker, Kubernetes, GCP/AWS, CI/CD |
| QA | Mobile testing, automation, performance |

---

## 14. SUCCESS MILESTONES

### Week 4: Foundation Complete
- [ ] Voice pipeline working (ASR + TTS)
- [ ] Basic intent classification (>70% accuracy)
- [ ] Android app captures and plays audio

### Week 10: MVP Launch
- [ ] 4 languages functional
- [ ] 5 government services complete
- [ ] Guided mode working
- [ ] 500 beta users, NPS >40

### Week 16: MVP+ Complete
- [ ] Offline mode functional
- [ ] HITL escalation working
- [ ] Credit system live
- [ ] 10K DAU

### Week 24: Scale Phase
- [ ] Payments integrated
- [ ] Admin dashboard live
- [ ] First B2B revenue
- [ ] First government partner signed
- [ ] 50K DAU

---

## APPENDIX: REPOSITORY STRUCTURE

```
sathio/
├── android/                    # Android app (Kotlin)
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── java/com/sathio/
│   │   │   ├── res/
│   │   │   └── AndroidManifest.xml
│   │   └── build.gradle
│   └── build.gradle
├── backend/                    # Python services
│   ├── api/                    # FastAPI application
│   │   ├── main.py
│   │   ├── routers/
│   │   ├── services/
│   │   └── models/
│   ├── ml/                     # ML models and inference
│   │   ├── asr/
│   │   ├── intent/
│   │   └── tts/
│   ├── tests/
│   └── requirements.txt
├── infra/                      # Infrastructure as code
│   ├── k8s/
│   │   ├── staging/
│   │   └── production/
│   ├── terraform/
│   └── docker-compose.yml
├── data/                       # Training data, FAQs
│   ├── faqs/
│   ├── training/
│   └── schemas/
├── docs/                       # Documentation
│   ├── api/
│   ├── architecture/
│   └── runbooks/
├── scripts/                    # Utility scripts
├── .github/workflows/          # CI/CD
└── README.md
```

---

**Document Version:** 2.0 (LAM Architecture)  
**Last Updated:** February 12, 2026  
**Status:** Ready for Engineering Kickoff

---

**END OF IMPLEMENTATION PLAN**
