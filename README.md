# VOXORA — Multi-User AI Voice Companion Platform

> **Project**: Voxora  
> **Tagline**: *Your Voice. Your AI. Your Connection.*  
> **Original Project Author**: Rajveer Sukul  
> **Copyright**: Copyright © 2026 Rajveer Sukul. All rights reserved.  
> **Environment**: Next.js 16 (App Router) + TypeScript 5 + Node.js 24 + Tailwind CSS v4  

Voxora is a multi-user, real-time voice AI companion web application that enables natural, ultra-low-latency spoken conversations. Built with **WebRTC audio streaming**, **modular multi-provider AI adapters** (OpenAI, Gemini, Claude, Groq, ElevenLabs), a **native SQLite database**, and a **privacy-first zero-storage architecture**, Voxora delivers an authentic conversational experience.

---

## Table of Contents

1. [Key Features](#1-key-features)
2. [Technology Stack](#2-technology-stack)
3. [Architecture & Studios](#3-architecture--studios)
4. [Quick Start](#4-quick-start)
5. [Documentation Sitemap](#5-documentation-sitemap)
6. [Automated Testing](#6-automated-testing)
7. [Production Deployment](#7-production-deployment)
8. [Copyright & Authorship](#8-copyright--authorship)

---

## 1. Key Features

- **Sub-500ms WebRTC Voice Dialogue**: Direct peer-to-peer audio streaming with voice activity detection (VAD) and seamless barge-in.
- **Multi-User Authentication**: Email/password authentication with `scrypt` hashing, session management, and OAuth 2.0 (Google, Discord, Apple, Facebook, ChatGPT).
- **Multi-Provider AI Adapters**: Support for OpenAI Realtime, Google Gemini, Anthropic Claude, Groq LPU, ElevenLabs, and an intelligent local diagnostic fallback.
- **Server-Side Encrypted Credentials**: User-supplied API keys are stored at rest using AES-256-GCM authenticated encryption.
- **Companion Agents Studio (`/agents`)**: Create, edit, and switch between customized AI companions with unique personas, voices, and intelligence models.
- **Voice Synthesis Lab (`/voices`)**: Audition male, female, and neutral voices across providers with instant audio preview.
- **Avatar & 3D Character Studio (`/avatars`)**: Procedural 2D anime characters, Three.js WebGL 3D meshes, and abstract audio-reactive spheres with real-time lip sync.
- **Safe Asset Uploader**: Strict MIME and magic-number validation for custom 2D images and 3D GLB/GLTF assets up to 10MB.
- **Multilingual Experience**: Localization across 7 interface and conversation languages (English, Spanish, French, German, Hindi, Japanese, Chinese).
- **Zero-Storage Privacy Architecture**: Spoken audio is never recorded on servers; conversation history is strictly user-controlled with full export and purge capabilities.

---

## 2. Technology Stack

- **Frontend & Routing**: [Next.js](https://nextjs.org/) 16 (Turbopack, App Router, React 19)
- **Styling**: Tailwind CSS v4 + Cosmic Glassmorphic Design System
- **Database**: Native SQLite via Node.js 24 `node:sqlite` (`DatabaseSync`)
- **3D Graphics & WebGL**: [Three.js](https://threejs.org/)
- **Security & Cryptography**: Node.js `node:crypto` (`scrypt`, `AES-256-GCM`, `timingSafeEqual`)
- **Audio Transport**: WebRTC (`RTCPeerConnection`, `RTCDataChannel`) + Web Audio API (`AudioContext`)
- **Testing**: Node.js Native Test Runner (`node:test`, `node:assert/strict`)

---

## 3. Architecture & Studios

| Route | Interface Name | Purpose |
|---|---|---|
| `/` | **Landing Page** | Platform overview, interactive avatar preview, and quick launch |
| `/dashboard` | **User Dashboard** | Active companion summary, provider connectivity, and studio access |
| `/onboarding` | **Guided Onboarding** | 7-step guided setup (Provider → Model → Key → Voice → Language → Avatar → Call) |
| `/call` | **Voice Studio** | Real-time voice interaction with live audio meters, push-to-talk, and captions |
| `/agents` | **Agents Studio** | Multi-companion creation, editing, and persona configuration |
| `/voices` | **Voice Lab** | Male/Female/Neutral voice auditioning and sample playback |
| `/avatars` | **Avatar Studio** | 2D Canvas & 3D WebGL avatar configuration and secure asset uploader |
| `/history` | **History Inspector** | Transcripts viewer with search, JSON export, and deletion controls |
| `/connect` | **Provider Hub** | Provider inspection, OAuth accounts, and connection status |
| `/settings` | **Personalization** | Voice timbres, language preferences, encrypted API keys, and account deletion |
| `/auth/login` | **Sign In** | Email/password login and OAuth buttons |
| `/auth/register`| **Register** | Account creation with redirection to onboarding |
| `/help` | **Diagnostics** | Real-time WebRTC, MediaDevices, and live microphone bench |
| `/privacy` | **Privacy Center** | Data governance and zero-storage documentation |
| `/copyright` | **Legal Attribution** | Formal copyright and third-party notices |

---

## 4. Quick Start

```bash
# 1. Clone repository
git clone https://github.com/your-username/voxora.git
cd voxora

# 2. Install dependencies
npm install

# 3. Configure environment variables
copy .env.example .env.local

# 4. Run automated test suite (22/22 passing)
npm test

# 5. Start development server
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000) to begin using Voxora.

---

## 5. Documentation Sitemap

- [SETUP.md](SETUP.md): Step-by-step setup guide for beginners and developers.
- [DEPLOYMENT.md](DEPLOYMENT.md): Production deployment guide (Vercel, Render, Docker, VPS).
- [ARCHITECTURE.md](ARCHITECTURE.md): Comprehensive system design and technical specifications.
- [SECURITY.md](SECURITY.md): Cryptography, secret encryption, and vulnerability policy.
- [PRIVACY.md](PRIVACY.md): Zero-storage architecture and user data rights.
- [TESTING.md](TESTING.md): Test suite organization and execution commands.
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md): Solutions for microphone, WebRTC, and API key issues.
- [IMPLEMENTATION_STATUS.md](IMPLEMENTATION_STATUS.md): Current build, test, and verification report.
- [COPYRIGHT.md](COPYRIGHT.md): Authorship, copyright, and third-party licenses.

---

## 6. Automated Testing

Run the full automated test suite:
```bash
npm test
```
*Current result: 22 passed, 0 failed, 0 skipped.*

Run production compile and type-checking:
```bash
npm run build
```
*Current result: 37/37 routes compiled successfully.*

---

## 7. Production Deployment

Voxora is configured for automatic, always-available web deployment on **Vercel**, **Render**, **Railway**, **Docker**, or an **Ubuntu VPS**:

- End-users access the live HTTPS service directly without running terminal commands.
- Automatic routing fallbacks and HTTP security headers are pre-configured.
- Microphones require HTTPS in production.

See [DEPLOYMENT.md](DEPLOYMENT.md) for complete instructions.

---

## 8. Copyright & Authorship

Copyright © 2026 Rajveer Sukul. All rights reserved.

Created by Rajveer Sukul as an original full-stack AI voice companion application. Third-party libraries (Next.js, React, Three.js, Tailwind CSS, Lucide) remain the property of their respective copyright holders.
