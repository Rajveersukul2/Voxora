# VOXORA — Setup Guide

> **Product**: Voxora AI Voice Companion Platform  
> **Tagline**: Your Voice. Your AI. Your Connection.  
> **Original Author**: Rajveer Sukul  
> **Copyright**: Copyright © 2026 Rajveer Sukul. All rights reserved.  

---

## 1. Prerequisites

Before installing Voxora, ensure you have the following installed on your host system:

- **Node.js**: Version **v22.0.0** or higher (v24.19+ recommended; provides native `node:sqlite`).
- **Package Manager**: `npm` (included with Node.js) or `pnpm` / `yarn`.
- **Modern Browser**: Chrome, Edge, Safari, or Firefox with WebRTC and Web Audio API support.
- **Microphone**: Any functional built-in or external audio input hardware.

---

## 2. Quick Installation (Under 2 Minutes)

1. **Clone or Extract the Repository**:
   ```bash
   cd VOXORA
   ```

2. **Install Dependencies**:
   ```bash
   npm install
   ```

3. **Configure Environment Variables**:
   ```bash
   # On Windows PowerShell / Command Prompt:
   copy .env.example .env.local

   # On macOS / Linux:
   cp .env.example .env.local
   ```

4. **Run Automated Test Suite to Verify System**:
   ```bash
   npm test
   ```
   All 22 automated unit and contract tests should pass cleanly.

5. **Start the Local Development Server**:
   ```bash
   npm run dev
   ```
   Open your browser to [http://localhost:3000](http://localhost:3000).

---

## 3. Configuring AI Providers

Voxora operates with modular provider adapters. You can configure global server keys in `.env.local`, or end-users can provide their own encrypted keys in their account settings.

### A. OpenAI (Realtime WebRTC Voice & Text)
1. Generate an API Key at [platform.openai.com](https://platform.openai.com/api-keys).
2. Ensure your OpenAI account has billing credits and access to `gpt-4o-realtime-preview`.
3. Set in `.env.local`:
   ```env
   OPENAI_API_KEY=sk-proj-...
   OPENAI_REALTIME_MODEL=gpt-4o-realtime-preview
   ```

### B. Google Gemini (Multimodal Intelligence)
1. Create an API Key at [Google AI Studio](https://aistudio.google.com).
2. Set in `.env.local`:
   ```env
   GEMINI_API_KEY=AIzaSy...
   ```

### C. Anthropic Claude (Warm, Nuanced Dialogue)
1. Generate an API Key at [console.anthropic.com](https://console.anthropic.com).
2. Set in `.env.local`:
   ```env
   ANTHROPIC_API_KEY=sk-ant-...
   ```

### D. Groq (Ultra-Low Latency Conversational Engine)
1. Generate an API Key at [console.groq.com](https://console.groq.com).
2. Set in `.env.local`:
   ```env
   GROQ_API_KEY=gsk_...
   ```

### E. ElevenLabs (Hyper-Realistic Synthetic Speech)
1. Generate an API Key at [elevenlabs.io](https://elevenlabs.io).
2. Set in `.env.local`:
   ```env
   ELEVENLABS_API_KEY=xi-...
   ```

---

## 4. Configuring OAuth Identity Providers

Voxora supports Google, Discord, Apple, Facebook, and ChatGPT authentication:

| Provider | Registration Console | Redirect URI to Register |
|---|---|---|
| **Google** | [console.cloud.google.com](https://console.cloud.google.com) | `https://your-domain.com/api/auth/oauth/callback?provider=google` |
| **Discord** | [discord.com/developers](https://discord.com/developers) | `https://your-domain.com/api/auth/oauth/callback?provider=discord` |
| **Apple** | [developer.apple.com](https://developer.apple.com) | `https://your-domain.com/api/auth/oauth/callback?provider=apple` |
| **Facebook** | [developers.facebook.com](https://developers.facebook.com) | `https://your-domain.com/api/auth/oauth/callback?provider=facebook` |

---

## 5. Native Database Storage

Voxora features a zero-dependency SQLite architecture using Node.js's built-in `DatabaseSync` engine:

- Database file is auto-created at `.voxora_data/voxora.sqlite`.
- Schema migrations run automatically upon server startup.
- In serverless or read-only hosting environments, Voxora automatically falls back to in-memory SQLite (`:memory:`) without throwing fatal crashes.

---

## 6. Verifying Production Build

Before deploying to live hosting, verify the production bundle:

```bash
npm run build
npm start
```
Access [http://localhost:3000](http://localhost:3000) to confirm compiled production performance.
