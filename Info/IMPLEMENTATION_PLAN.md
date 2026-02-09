# SATHIO — IMPLEMENTATION PLAN

**Version:** 1.0  
**Date:** February 8, 2026  
**Status:** Engineering-Ready  
**Prepared For:** Engineering, DevOps, and Execution Teams

---

## OVERVIEW

This document provides the technical roadmap for building Sathio from concept to launch. It defines development phases, architecture decisions, technology choices, and deployment strategy.

**Timeline:** MVP Launch in 12-16 weeks (Phase 0 + Phase 1)

---

## 1. DEVELOPMENT PHASES

### Phase 0: Foundation (Weeks 0-4)

**Goal:** Establish core infrastructure and voice pipeline

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 1-2 | Project Setup | Repo structure, CI/CD, dev environments |
| Week 3-4 | Core Voice Pipeline | ASR/TTS integration, basic intent classification |

**Key Milestones:**
- [ ] Development environment configured for all team members
- [ ] Bhashini API integration working (STT + TTS)
- [ ] Basic intent classifier trained on 500 sample queries
- [ ] Android app skeleton with mic button and voice capture

---

### Phase 1: Core MVP (Weeks 4-10)

**Goal:** Deliver functional MVP with core government services

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 5-6 | Government Services | Aadhaar, PAN, PM-Kisan guidance flows |
| Week 7-8 | Guided Mode + UI | Step-by-step mode, icon-based UI |
| Week 9-10 | Integration & Testing | End-to-end testing, performance optimization |

**Key Milestones:**
- [ ] 4 languages working (Hindi, Tamil, Bengali, Marathi) with >80% SVR
- [ ] 5 government service flows complete
- [ ] Step-by-step guided mode functional
- [ ] APK size <40MB, runs on 2GB RAM devices
- [ ] 500 beta testers onboarded

---

### Phase 2: MVP+ Features (Weeks 10-16)

**Goal:** Add retention features and human escalation

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 11-12 | Offline Mode | Pre-cached FAQs, emergency numbers |
| Week 13-14 | HITL Escalation | Expert routing, WhatsApp integration |
| Week 15-16 | Notifications | Smart push notifications, engagement system |

**Key Milestones:**
- [ ] Offline mode with <50MB package
- [ ] Human escalation working with 3-5 trained agents
- [ ] Notification system with 1/day limit
- [ ] Credit system functional
- [ ] 10,000+ DAU target

---

### Phase 3: Scale & Monetization (Weeks 16-24)

**Goal:** Launch monetization and government partnerships

| Sprint | Focus | Deliverables |
|--------|-------|--------------|
| Week 17-18 | Payments | UPI integration, Sathio Plus subscriptions |
| Week 19-20 | Admin Dashboard | Content management, analytics |
| Week 21-22 | B2B Integrations | Lead generation APIs, partner onboarding |
| Week 23-24 | Government Pilot | White-label for state partners |

**Key Milestones:**
- [ ] Payment gateway live (Razorpay)
- [ ] Admin dashboard for content updates
- [ ] First government partnership signed
- [ ] First B2B lead generation revenue
- [ ] 50,000+ DAU

---

### Phase 4: Expansion (Months 6-12)

**Goal:** Language expansion, advanced features

| Focus Area | Deliverables |
|------------|--------------|
| Languages | Add Telugu, Kannada, Gujarati, Punjabi |
| Form Auto-Fill | AI-powered form detection and filling |
| Voice Commerce | DeHaat, AgroStar integration |
| WhatsApp Bot | Full feature parity |
| IVR Channel | Feature phone support |

---

## 2. MVP SCOPE DEFINITION

### In Scope (MVP)

| Category | Features |
|----------|----------|
| **Languages** | Hindi, Tamil, Bengali, Marathi |
| **Voice** | Tap-to-talk, TTS responses, code-mixing |
| **Government** | Aadhaar, PAN, PM-Kisan, Pension, Ration Card |
| **Utilities** | Electricity, Mobile, Gas (guidance only) |
| **Health/Edu** | Ayushman Bharat, Scholarships (info only) |
| **UI** | Icon-based, large buttons, step-by-step mode |
| **Platform** | Android only (5.0+) |

### Out of Scope (MVP)

| Feature | Phase |
|---------|-------|
| iOS app | Phase 3 |
| Form auto-fill | Phase 3 |
| In-app payments | Phase 2 (redirect only in MVP) |
| WhatsApp bot | Phase 3 |
| IVR/feature phones | Phase 4 |
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

| Component | Primary | Fallback |
|-----------|---------|----------|
| **ASR (Speech-to-Text)** | Bhashini API | Whisper (fine-tuned) |
| **TTS (Text-to-Speech)** | Bhashini TTS | Coqui TTS |
| **Intent Classification** | DistilBERT (fine-tuned) | IndicBERT |
| **Semantic Search** | Sentence-Transformers | - |
| **LLM (Phase 2+)** | LLaMA 3 (fine-tuned) | Gemma |
| **Embeddings** | Multilingual SBERT | - |

### Databases

| Database | Purpose | Tech |
|----------|---------|------|
| **Primary** | Users, transactions, sessions | PostgreSQL |
| **Document** | FAQs, schemes, guides | MongoDB |
| **Cache** | Sessions, frequent queries | Redis |
| **Vector** | Semantic search embeddings | Pinecone / Milvus |
| **Analytics** | Events, metrics | ClickHouse |

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
| **Bhashini** | https://bhashini.gov.in | ASR, TTS, Translation |
| **UIDAI** | Aadhaar APIs | Identity verification |
| **NSDL** | PAN APIs | Tax services |
| **PM-Kisan** | Agriculture portal | Subsidy status |
| **Razorpay** | Payment Gateway | UPI, cards |
| **WhatsApp** | Business API | Escalation |
| **Firebase** | FCM | Push notifications |

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

### Sprint 5-6: Government Services

```
Week 5:
├── Aadhaar download flow
├── Aadhaar status check
├── PAN application guidance
├── Document checklist generation
└── In-app browser integration

Week 6:
├── PM-Kisan eligibility checker
├── PM-Kisan application steps
├── Pension schemes info
├── Ration card guidance
└── External site deep-linking
```

### Sprint 7-8: Guided Mode + UI

```
Week 7:
├── Step-by-step guided mode
├── Progress indicator ("Step 2 of 5")
├── Navigation controls (Next/Repeat/Pause)
├── Visual highlighting
└── Resume from last step

Week 8:
├── Icon-based home screen
├── Quick access cards
├── Bottom navigation
├── Settings screen
├── Language switcher
└── Accessibility compliance (WCAG AA)
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
- Output: intent, response steps, action

POST /api/v1/tts/synthesize
- Input: text, language, voice_id
- Output: audio file URL

GET /api/v1/faq/{category}/{language}
- Output: FAQ list for category

POST /api/v1/user/register
- Input: phone, OTP
- Output: user_id, token

GET /api/v1/user/profile
- Output: preferences, history

POST /api/v1/payment/initiate
- Input: amount, type
- Output: payment_link (UPI)

POST /api/v1/escalation/request
- Input: query, user_id, type
- Output: session_id, expected_wait

GET /api/v1/notification/settings
POST /api/v1/notification/settings
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

**Document Version:** 1.0  
**Last Updated:** February 8, 2026  
**Status:** Ready for Engineering Kickoff

---

**END OF IMPLEMENTATION PLAN**
