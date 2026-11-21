# VOXORA — System Architecture & Technical Specifications

> **Project**: Voxora  
> **Tagline**: *Your Voice. Your AI. Your Connection.*  
> **Author & Creator**: Rajveer Sukul  
> **Copyright Notice**: Copyright © 2026 Rajveer Sukul. All rights reserved.  

---

## 1. Architectural Overview

Voxora is a multi-user, real-time voice AI companion platform engineered for natural spoken dialogue. Unlike conventional text chatbot wrappers that require a user to tap to record and wait for audio files, Voxora streams audio bi-directionally over **WebRTC** with server-side voice activity detection (VAD), enabling sub-500ms conversational turn-taking and natural mid-sentence interruption (barge-in).

```
                      ┌────────────────────────────────────────┐
                      │          Browser Client (UI)           │
                      │  Next.js 16 + React 19 + Tailwind v4   │
                      └───────┬────────────────────────▲───────┘
                              │                        │
               1. Ephemeral   │                        │ 3. Direct Encrypted
               Token Request  │                        │    WebRTC Stream
                              ▼                        │    (Microphone + Audio)
                      ┌───────────────┐                │
                      │ Voxora Server │                │
                      │ Route Handler │                │
                      └───────┬───────┘                │
                              │ 2. Mint Token          │
                              ▼                        │
                      ┌────────────────────────────────┴───────┐
                      │        OpenAI Realtime Gateway         │
                      │       (gpt-4o-realtime-preview)        │
                      └────────────────────────────────────────┘
```

---

## 2. Multi-User Platform & Native Database Layer

Voxora utilizes Node.js 22+ built-in `node:sqlite` (`DatabaseSync`) for zero-dependency ACID SQL persistence:

- **Users**: Unique emails, scrypt-hashed passwords, profile metadata, roles.
- **Sessions**: Cryptographically secure 256-bit hexadecimal tokens with 30-day sliding TTL.
- **OAuth Accounts**: Explicit linking table for Google, Discord, Apple, Facebook, and ChatGPT. Prevents unsafe auto-merging based solely on email strings.
- **User Credentials**: AES-256-GCM encrypted user API keys with server-side master key derivation.
- **Agent Configurations**: Multi-agent companion profiles (name, personality prompt, provider, model, voice, language, avatar type).
- **Conversations & Messages**: Optional encrypted transcript retention per user consent.
- **User Memories**: Granular categorized memory notes.
- **Zero-Storage Fallback**: Automatically mounts in-memory SQLite (`:memory:`) in read-only serverless environments.

---

## 3. Modular AI Provider Adapter System

Voxora routes requests through an extensible adapter pattern (`src/lib/providers/`):

| Provider | Modalities | Capabilities | Primary Adapter |
|---|---|---|---|
| **OpenAI** | Audio, Text, Vision | Realtime WebRTC audio-to-audio, Chat completion, TTS (`tts-1`) | `OpenAIAdapter` |
| **Google Gemini** | Multimodal, Audio | Gemini 2.0 Flash, Gemini 1.5 Pro | `GeminiAdapter` |
| **Anthropic Claude**| Text, Vision | Claude 3.5 Sonnet, Claude 3.5 Haiku | `AnthropicAdapter` |
| **Groq LPU** | Text | Llama 3.3 70B, Mixtral 8x7B (Ultra-low latency) | `GroqAdapter` |
| **ElevenLabs** | Synthetic Audio | Hyper-realistic voice synthesis | `ElevenLabsAdapter` |
| **Local Diagnostic**| Text | Zero-config offline conversational turns | `LocalFallbackAdapter` |

---

## 4. Visualizers & Avatar Engine

- **Avatar Host (`src/components/AvatarHost.tsx`)**: Dynamic switcher hosting visualizers based on user preference:
  1. `orb`: Radial frequency Canvas visualizer with multi-ring pulsation (`VisualizerOrb.tsx`).
  2. `anime2d`: Procedural 2D Canvas anime avatar with real-time lip-sync mouth shape modulation, eye tracking, and natural blinking cycles (`Avatar2D.tsx`).
  3. `anime3d`: Procedural Three.js WebGL 3D geometric mesh avatar with orbital halo rings, head breathing, and audio reactivity (`Avatar3D.tsx`).
  4. `spark` / `wave`: Abstract visualizer variations.
  5. `custom_asset`: Validated user-uploaded 2D image or 3D GLB/GLTF model.

---

## 5. Multilingual Localization Engine

Voxora includes an i18n localization system (`src/lib/i18n/`) supporting:
- **English** (`en`)
- **Spanish** (`es`)
- **French** (`fr`)
- **German** (`de`)
- **Hindi** (`hi`)
- **Japanese** (`ja`)
- **Chinese** (`zh`)

Decouples **Interface Language** (navigation, forms, buttons) from **Conversation Language** (the spoken companion's dialogue output).

---

## 6. Security & Cryptographic Invariants

1. **scrypt Password Hashing**: Unique 16-byte random salt per user, verified with `crypto.timingSafeEqual()`.
2. **AES-256-GCM Vault**: API keys stored with 96-bit random IVs and 128-bit authentication tags to prevent tampering.
3. **HTTP Security Headers**: Strict CSP, HSTS preload, X-Content-Type-Options `nosniff`, and Hardware Permissions Policy (`microphone=(self)`).
4. **Binary Upload Validation**: Inspects magic numbers to reject executable binaries (`MZ`, `ELF`).
