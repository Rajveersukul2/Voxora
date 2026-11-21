# Copyright & Ownership Notice — Voxora

**Copyright © 2026 Rajveer Sukul. All rights reserved.**

---

## 1. Project Identification

- **Project Name**: Voxora
- **Tagline**: *Your Voice. Your AI. Your Connection.*
- **Original Project Author & Creator**: Rajveer Sukul
- **Copyright Year**: 2026

---

## 2. Scope of Original Authorship & Ownership

To the extent created by the author, the following materials and intellectual property are original works of **Rajveer Sukul**:

1. **Original Application Codebase**:
   - The end-to-end Next.js application architecture, App Router layout, routing structure, and route handlers.
   - Client-side WebRTC voice session management and state machine (`src/lib/webrtc.ts`).
   - Browser storage management, zero-storage privacy policies, and local memory controls (`src/lib/storage.ts`).
   - Cryptographic PKCE code challenge utilities for OAuth integration (`src/lib/oauth-crypto.ts`).
   - Platform constants, configuration schemas, and TypeScript data definitions (`src/lib/constants.ts`, `src/types/voxora.ts`).
   - Diagnostic suite routines and microphone test bench (`src/app/help/page.tsx`).

2. **Original UI & Visual Design**:
   - The custom "Dark Cosmos" visual design system, curated color palettes, glassmorphism panel styles, and layout typography.
   - User interfaces for the Voice Studio (`/call`), Connect & Accounts (`/connect`), Personalization & Settings (`/settings`), Privacy Center (`/privacy`), Diagnostic Suite (`/help`), and Landing Page (`/`).
   - Responsive layouts, navigation bars (`Navbar.tsx`), call control consoles (`CallControls.tsx`), transcript streaming interfaces (`TranscriptViewer.tsx`), and platform footers (`Footer.tsx`).

3. **Original Procedural Visualizers & Avatar Engines**:
   - **2D Procedural Anime Avatar (`Avatar2D.tsx`)**: Original procedural HTML5 2D Canvas rendering routines including procedural eyelid blinking cycles, dynamic lip-sync mouth shape modulation mapped to audio amplitude, and expressive facial states.
   - **3D Procedural WebGL Avatar (`Avatar3D.tsx`)**: Original procedural Three.js scene composition, geometric mesh configuration (central sphere, orbital halo rings, ambient particle starfield), and audio-reactive vertex animation.
   - **Visualizer Orb (`VisualizerOrb.tsx`)**: Original procedural HTML5 Canvas radial frequency wave visualizer with multi-ring pulsation responding to voice volume and connection states.

4. **Branding & Original Project Documentation**:
   - The "Voxora" project identity, concept, design documentation, and the tagline: *"Your Voice. Your AI. Your Connection."*
   - Vector brand icons (`public/icons/icon-192.svg`, `public/icons/icon-512.svg`).
   - Project documentation including `README.md`, `ARCHITECTURE.md`, `PROJECT_STATUS.md`, and `IMPLEMENTATION_STATUS.md`.

---

## 3. Third-Party Libraries, Assets & Attribution Disclosures

Rajveer Sukul makes **no claim of ownership** over third-party software libraries, external runtimes, open-source frameworks, fonts, or AI models integrated into or used by Voxora. All external technologies remain the property of their respective copyright holders and are utilized in accordance with their applicable licenses:

### A. Core Frameworks & Open-Source Libraries
| Component / Dependency | Copyright Holder / Author | License | Description / Purpose |
|---|---|---|---|
| **Next.js** (`next`) | Vercel, Inc. & Next.js Contributors | [MIT License](https://github.com/vercel/next.js/blob/canary/license.md) | React full-stack framework & App Router runtime |
| **React & React DOM** (`react`, `react-dom`) | Meta Platforms, Inc. & React Contributors | [MIT License](https://github.com/facebook/react/blob/main/LICENSE) | User interface library |
| **Three.js** (`three`, `@types/three`) | Ricardo Cabello (Mr.doob) & Three.js Authors | [MIT License](https://github.com/mrdoob/three.js/blob/dev/LICENSE) | JavaScript 3D WebGL library used for 3D procedural rendering |
| **Lucide Icons** (`lucide-react`) | Lucide Contributors | [ISC License](https://github.com/lucide-icons/lucide/blob/main/LICENSE) | UI iconography |
| **Tailwind CSS** (`tailwindcss`, `@tailwindcss/turbopack`) | Tailwind Labs, Inc. | [MIT License](https://github.com/tailwindlabs/tailwindcss/blob/next/LICENSE.md) | Utility-first CSS styling engine |
| **TypeScript** (`typescript`, `@types/*`) | Microsoft Corporation | [Apache-2.0 License](https://github.com/microsoft/TypeScript/blob/main/LICENSE.txt) | Type-safe JavaScript language tooling |
| **ESLint** (`eslint`, `eslint-config-next`) | OpenJS Foundation & Contributors | [MIT License](https://github.com/eslint/eslint/blob/main/LICENSE) | Code linting and style validation |

### B. Typography & Fonts
- **Geist Sans & Geist Mono**: Designed by Vercel, Inc. Distributed under the [SIL Open Font License 1.1 (OFL-1.1)](https://openfontlicense.org/).

### C. Artificial Intelligence Models & Cloud APIs
Voxora integrates with external cloud AI services. **Voxora does not own or distribute these proprietary models or services**:
- **OpenAI Realtime WebRTC API**: Proprietary real-time multimodal audio streaming service operated by OpenAI, LLC (`gpt-4o-realtime-preview`). Accessed under the [OpenAI Business Terms](https://openai.com/policies/business-terms/) and [API Policies](https://developers.openai.com/).
- **OpenAI Voice Catalog**: The synthetic voice personas (`alloy`, `ash`, `ballad`, `coral`, `echo`, `sage`, `shimmer`, `verse`) are proprietary voice models created and provided by OpenAI, LLC.
- **Sign in with ChatGPT / OpenID Connect**: OpenAI's proprietary authentication protocol and identity service. Subject to OpenAI's [Sign in with ChatGPT Terms](https://openai.com/policies/sign-in-with-chatgpt-terms/).

### D. Web Standards & Browser APIs
Voxora makes use of open web standards implemented directly by end-user browsers:
- **WebRTC (`RTCPeerConnection`, `RTCDataChannel`)**: Standardized by the W3C and IETF for peer-to-peer real-time media exchange.
- **Web Audio API (`AudioContext`, `AnalyserNode`)**: Standardized by the W3C for client-side audio analysis and synthesis.
- **Web Speech API (`SpeechRecognition`, `SpeechSynthesis`)**: Standardized by the W3C for speech recognition and synthesis fallback.

---

## 4. Project Licensing Status & Reuse Clarification

- **No Open-Source License Assigned**: No separate open-source software license (e.g., MIT, Apache 2.0, GPL) has been granted or specified for the proprietary portions of the Voxora codebase or original project assets.
- **Reservation of Rights**: Except where third-party open-source licenses govern external dependencies, all rights in and to the original Voxora code, UI designs, visualizers, branding, and documentation are strictly reserved by **Rajveer Sukul**.
- **Reuse & Distribution Permissions**: Any copying, distribution, modification, commercial use, or public deployment of Voxora's original code or brand materials requires prior explicit clarification and written permission from the author.
- **Trademarks & Registrations**: "Voxora" is used as the project identifier. No claim of government-registered trademark (®) or official patent is made or implied.

---

## 5. Contact & Inquiries

For copyright inquiries, permissions, or licensing clarifications regarding the Voxora project, contact:

**Rajveer Sukul**  
Original Author & Project Creator  
Voxora — *Your Voice. Your AI. Your Connection.*
