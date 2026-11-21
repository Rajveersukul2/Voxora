# VOXORA — Troubleshooting & Diagnostics Guide

> **Product**: Voxora AI Voice Companion  
> **Tagline**: Your Voice. Your AI. Your Connection.  
> **Original Author**: Rajveer Sukul  
> **Copyright**: Copyright © 2026 Rajveer Sukul. All rights reserved.  

---

## 1. Common Issues & Solutions

### A. Microphone Permission Denied
- **Symptom**: "Microphone access blocked or denied by browser."
- **Root Cause**: The browser permission prompt was rejected or the site is served over insecure HTTP.
- **Resolution**:
  1. Click the padlock icon in the browser URL bar.
  2. Toggle **Microphone** to **Allow**.
  3. Ensure your site is served over **HTTPS** (or `http://localhost` for development).
  4. Visit `/help` to run the automated Microphone and MediaDevices hardware diagnostic bench.

### B. "API Key Not Configured" or Operating in Diagnostic Mode
- **Symptom**: Spoken turns respond via local conversational engine or simulation.
- **Root Cause**: `OPENAI_API_KEY` is not defined in `.env.local`, or the user has not added their personal key in Settings.
- **Resolution**:
  1. Create `.env.local` from `.env.example`.
  2. Add a valid API key with active credits from [platform.openai.com](https://platform.openai.com/api-keys).
  3. Restart the server (`npm run dev`).

### C. WebRTC Session Fails behind Corporate Firewall
- **Symptom**: Call starts connecting, then transitions to error or reconnecting state.
- **Root Cause**: Corporate firewalls or strict NATs blocking UDP WebRTC ports.
- **Resolution**:
  1. Voxora automatically falls back to continuous Speech-to-Text (`SpeechRecognition`) → `/api/chat` → Audio Synthesis.
  2. Check `/help` to view real-time WebRTC connectivity status.

### D. PowerShell Execution Policy Blocks `npm` on Windows
- **Symptom**: `npm.ps1 cannot be loaded because running scripts is disabled on this system.`
- **Resolution**:
  Run via `cmd.exe`:
  ```bash
  cmd /c "npm test"
  cmd /c "npm run dev"
  ```
  Or adjust PowerShell execution policy:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

### E. Database Persistence & Permissions
- **Symptom**: "Database locked" or SQLite read-only warning in serverless hosting.
- **Resolution**:
  Voxora auto-detects read-only filesystems and transitions gracefully to an in-memory database (`:memory:`). For persistent storage on cloud containers (Render, Railway, VPS), mount a persistent volume to `.voxora_data`.
