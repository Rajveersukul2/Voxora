# VOXORA — Security Architecture & Policy

> **Product**: Voxora AI Voice Companion  
> **Tagline**: Your Voice. Your AI. Your Connection.  
> **Original Author**: Rajveer Sukul  
> **Copyright**: Copyright © 2026 Rajveer Sukul. All rights reserved.  

---

## 1. Security Architecture Core Principles

Voxora employs an in-depth security posture designed to prevent unauthorized credential exposure, cross-tenant data leakage, and malicious file injection:

### A. Zero Client-Side Secret Leakage
- API keys (OpenAI, Gemini, Claude, Groq, ElevenLabs) are **never** bundled in frontend scripts, sourcemaps, or browser cookies.
- Realtime WebRTC audio sessions issue **ephemeral, short-lived tokens (60-second TTL)** generated server-side.
- User-supplied API keys are encrypted at rest using **AES-256-GCM authenticated encryption** with unique 96-bit initialization vectors (IVs) and 128-bit authentication tags.

### B. Password Hashing & Timing-Safe Verification
- Passwords are encrypted using **scrypt (N=16384, r=8, p=1)** with unique cryptographically random 16-byte salts.
- Password equality comparisons utilize `crypto.timingSafeEqual()` to eliminate side-channel timing attack vectors.

### C. Session & Cookie Security
- Sessions are maintained via cryptographically random 256-bit hexadecimal tokens.
- Session cookies are set with:
  - `HttpOnly`: Inaccessible to client JavaScript, mitigating XSS theft.
  - `SameSite=Lax`: Mitigates Cross-Site Request Forgery (CSRF).
  - `Secure`: Transmitted exclusively over encrypted HTTPS connections in production.
  - `Path=/`: Scoped to the application root.

### D. File Upload Safety & Execution Prevention
- Avatar uploads (`/api/avatars/upload`) enforce strict checks:
  - **MIME & Extension Whitelist**: Only `.png`, `.jpg`, `.jpeg`, `.webp`, `.glb`, `.gltf` accepted.
  - **Maximum Size**: Enforced 10MB file limit.
  - **Executable Magic Number Inspection**: Inspects the first 4 bytes of uploaded files. Windows Portable Executables (`MZ` = `0x4D5A`) and Linux ELF binaries (`0x7F454C46`) are immediately rejected.
  - **Randomized Safe Filenames**: Files are saved with randomly generated UUIDs, preventing directory traversal (`../`) attacks.

### E. Hardened Production HTTP Headers
Configured in `next.config.ts`:
- `Strict-Transport-Security`: Enforces HTTPS with preload.
- `X-Content-Type-Options`: `nosniff` prevents MIME-type confusion attacks.
- `X-Frame-Options`: `DENY` prevents clickjacking.
- `Permissions-Policy`: Restricts browser hardware APIs to `microphone=(self)`, with `camera=()` and `geolocation=()` strictly disabled.

---

## 2. Server-Side Ownership & Authorization

Every endpoint dealing with user records (agents, conversations, memories, encrypted keys) enforces authenticated session ownership verification:

- `userId` is extracted from the cryptographically verified session token on the server.
- Request identifiers cannot be altered to access or delete another user's records.

---

## 3. Reporting Vulnerabilities

If you identify a security vulnerability in Voxora, please report it privately:

- **Security Contact**: Rajveer Sukul
- **Notice**: Please do not open public GitHub issues for security vulnerabilities.
