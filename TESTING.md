# VOXORA — Automated Testing & Verification Guide

> **Product**: Voxora AI Voice Companion  
> **Tagline**: Your Voice. Your AI. Your Connection.  
> **Original Author**: Rajveer Sukul  
> **Copyright**: Copyright © 2026 Rajveer Sukul. All rights reserved.  

---

## 1. Testing Framework & Philosophy

Voxora utilizes Node.js's native test runner (`node:test` and `node:assert/strict`) for rapid, reliable, zero-dependency testing.

Tests run **completely standalone**—the test harness automatically provisions an in-process ephemeral test server (`tests/test-server.mjs`) when a local development server is not active, ensuring tests pass reliably in CI pipelines and automated testing environments.

---

## 2. Test Execution Commands

### Run Full Test Suite
```bash
npm test
```
*Expected: 22 passed, 0 failed, 0 skipped.*

### Run Next.js Production Build Verification
```bash
npm run build
```
*Expected: Type check passes cleanly, 37/37 routes compiled.*

---

## 3. Test Suite Structure

| Test File | Purpose & Verification Scope |
|---|---|
| `tests/avatar_config.test.mjs` | Verifies avatar modes: 2D Canvas anime, 3D WebGL Three.js, and abstract visualizers. |
| `tests/crypto_auth.test.mjs` | Verifies scrypt password hashing, random salts, and AES-256-GCM secret encryption with tamper detection. |
| `tests/crypto.test.mjs` | Verifies SHA-256 PKCE challenge generation for OAuth 2.0 PKCE compliance. |
| `tests/db_repository.test.mjs` | Tests native SQLite database user creation, unique constraint enforcement, session issuance, and encrypted credentials storage. |
| `tests/providers_registry.test.mjs` | Verifies AI provider discovery catalogue and honest capability discrimination (realtime vs text). |
| `tests/endpoints.test.mjs` | Verifies `/api/health`, `/api/realtime/session` error handling, and `/api/auth/chatgpt/status`. |
| `tests/chat_fallback.test.mjs` | Tests multi-turn chat completions, prompt building, and local conversational engine fallback. |
| `tests/voice_preview.test.mjs` | Verifies voice previews across male, female, and neutral voices with pitch and rate attributes. |
| `tests/localization.test.mjs` | Tests dictionary coverage across English, Spanish, French, German, Hindi, Japanese, and Chinese. |
| `tests/copyright.test.mjs` | Verifies copyright notice and author attribution contracts across code and markdown files. |
| `tests/constants.test.mjs` | Verifies voice catalog and privacy zero-retention defaults. |

---

## 4. Live vs Development Testing

- **Mocks for Development**: Development tests verify data contracts, encryption round-trips, and fallback engines safely without incurring API charges or exposing private keys.
- **Live Provider Testing**: When live API keys (`OPENAI_API_KEY`, etc.) are configured in `.env.local`, Voxora automatically switches from simulation mode to live WebRTC audio and provider generation.
