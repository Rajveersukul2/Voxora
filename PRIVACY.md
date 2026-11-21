# VOXORA — Privacy Policy & Data Architecture

> **Product**: Voxora AI Voice Companion  
> **Tagline**: Your Voice. Your AI. Your Connection.  
> **Original Author**: Rajveer Sukul  
> **Copyright**: Copyright © 2026 Rajveer Sukul. All rights reserved.  

---

## 1. Privacy-First Architectural Commitment

Voxora was architected with a strict privacy-first foundation:

1. **Zero Spoken Audio Logging**: Realtime audio packets stream directly between your browser and the configured AI engine via encrypted WebRTC (SRTP/DTLS). Voxora's application server does not record or save your raw spoken audio.
2. **Zero-Retention Default for Transcripts**: Conversation transcripts are **OFF by default**. They are only stored when the user explicitly toggles conversation history in settings.
3. **Explicit Memory Control**: Personal companion memories are created exclusively upon user command or consent. You can inspect, modify, or permanently delete individual memory notes at any time.
4. **Permanent Account & Data Deletion**: Selecting "Delete Account" permanently cascades and erases your profile, agents, credentials, and conversation transcripts from the server database immediately.

---

## 2. Third-Party Data Processing

When you engage with Voxora, dialogue text or audio packets are processed by your chosen AI model provider:

| Provider | Purpose | Provider Privacy Policy |
|---|---|---|
| **OpenAI** | Realtime WebRTC voice & text completion | [openai.com/privacy](https://openai.com/privacy) |
| **Google Gemini** | Multimodal reasoning & audio synthesis | [policies.google.com/privacy](https://policies.google.com/privacy) |
| **Anthropic Claude** | Conversational language generation | [anthropic.com/privacy](https://www.anthropic.com/privacy) |
| **Groq** | Low-latency text completions | [groq.com/privacy](https://groq.com/privacy) |
| **ElevenLabs** | Voice timbre synthesis | [elevenlabs.io/privacy](https://elevenlabs.io/privacy) |

Voxora does not sell, license, or broker personal user data to third-party data brokers or advertising networks.
