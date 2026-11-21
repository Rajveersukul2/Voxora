-- ==============================================================================
-- VOXORA - SQL DATABASE SCHEMA & SEED SCRIPT
-- Copyright © 2026 Rajveer Sukul. All rights reserved.
-- ==============================================================================
-- Engine: SQLite (Compatible with Node.js 24 node:sqlite / SQLite 3)
--
-- How to apply this schema manually:
--   sqlite3 .voxora_data/voxora.sqlite < schema.sql
--
-- Or via Node.js script:
--   npm run seed
-- ==============================================================================

PRAGMA foreign_keys = ON;

-- ------------------------------------------------------------------------------
-- 1. USERS TABLE
-- Stores user identities, authentication credentials, and AI persona instructions.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT,
  salt TEXT,
  display_name TEXT NOT NULL,
  phone_number TEXT,
  otp_code TEXT,
  otp_expires_at INTEGER,
  avatar_url TEXT,
  email_verified INTEGER DEFAULT 0,
  role TEXT DEFAULT 'user',
  chatgpt_custom_instructions TEXT,
  past_chats_summary TEXT,
  openai_api_key TEXT,
  gemini_api_key TEXT,
  claude_api_key TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- ------------------------------------------------------------------------------
-- 2. SESSIONS TABLE
-- Authenticated sessions associated with HTTP-only cookies.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  token TEXT UNIQUE NOT NULL,
  expires_at INTEGER NOT NULL,
  created_at INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_sessions_token ON sessions(token);
CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON sessions(user_id);

-- ------------------------------------------------------------------------------
-- 3. OAUTH ACCOUNTS TABLE
-- Third-party OAuth links (Google, Discord, Apple, ChatGPT OIDC).
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS oauth_accounts (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  provider TEXT NOT NULL,
  provider_user_id TEXT NOT NULL,
  email TEXT,
  display_name TEXT,
  access_token TEXT,
  refresh_token TEXT,
  linked_at INTEGER NOT NULL,
  UNIQUE(provider, provider_user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_oauth_user_id ON oauth_accounts(user_id);
CREATE INDEX IF NOT EXISTS idx_oauth_provider ON oauth_accounts(provider, provider_user_id);

-- ------------------------------------------------------------------------------
-- 4. USER CREDENTIALS TABLE
-- AES-256-GCM encrypted API keys for OpenAI, Gemini, Claude, Groq, ElevenLabs.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_credentials (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  provider TEXT NOT NULL,
  encrypted_key TEXT NOT NULL,
  iv TEXT NOT NULL,
  tag TEXT NOT NULL,
  is_active INTEGER DEFAULT 1,
  updated_at INTEGER NOT NULL,
  UNIQUE(user_id, provider),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_credentials_user_id ON user_credentials(user_id);

-- ------------------------------------------------------------------------------
-- 5. AGENT CONFIGURATIONS TABLE
-- Customizable AI voice companions created by users.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS agent_configs (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  name TEXT NOT NULL,
  personality_prompt TEXT NOT NULL,
  provider TEXT NOT NULL,
  model TEXT NOT NULL,
  voice TEXT NOT NULL,
  language TEXT NOT NULL,
  avatar_type TEXT NOT NULL,
  avatar_url TEXT,
  is_default INTEGER DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_agent_configs_user_id ON agent_configs(user_id);

-- ------------------------------------------------------------------------------
-- 6. CONVERSATIONS TABLE
-- Spoken and typed session transcripts.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS conversations (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  agent_id TEXT,
  title TEXT NOT NULL,
  provider TEXT NOT NULL,
  model TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_conversations_user_id ON conversations(user_id);

-- ------------------------------------------------------------------------------
-- 7. MESSAGES TABLE
-- Individual turns in a conversation.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS messages (
  id TEXT PRIMARY KEY,
  conversation_id TEXT NOT NULL,
  sender TEXT NOT NULL,
  text TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_messages_conversation_id ON messages(conversation_id);

-- ------------------------------------------------------------------------------
-- 8. USER MEMORIES TABLE
-- Knowledge and conversational facts remembered by the companion.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_memories (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  category TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_user_memories_user_id ON user_memories(user_id);

-- ------------------------------------------------------------------------------
-- 9. MEDIA ITEMS TABLE
-- Stores AI generated images, videos, and synthesized/recorded voice notes.
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS media_items (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  type TEXT NOT NULL,
  title TEXT NOT NULL,
  prompt TEXT,
  url TEXT NOT NULL,
  thumbnail_url TEXT,
  duration_seconds REAL,
  metadata_json TEXT,
  created_at INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_media_items_user_id ON media_items(user_id);
CREATE INDEX IF NOT EXISTS idx_media_items_type ON media_items(type);

-- ==============================================================================
-- READY-TO-LOGIN PRE-SEEDED USERS
--
-- Account 1: Demo User
--   Email:    demo@voxora.ai
--   Password: Password123!
--   Hash:     scrypt (64 bytes derived key, 16 bytes salt)
--
-- Account 2: Administrator
--   Email:    admin@voxora.ai
--   Password: Password123!
-- ==============================================================================

INSERT OR IGNORE INTO users (
  id,
  email,
  password_hash,
  salt,
  display_name,
  avatar_url,
  email_verified,
  role,
  chatgpt_custom_instructions,
  past_chats_summary,
  created_at,
  updated_at
) VALUES (
  'usr_demo_2026',
  'demo@voxora.ai',
  '39db16b7a872a4ec181634e45877088ca1af88894e8ec3434b3fa8a056c6a737d7956e3ed13047e3525f909d4c79866f87a29f847b4e9d8ae915cddef1d7c9ee',
  'a1b2c3d4e5f60718293a4b5c6d7e8f90',
  'Rajveer Sukul',
  '/avatars/astral-guide.png',
  1,
  'user',
  'Speak in friendly Hinglish and English. Be energetic, warm, and concise. Never use generic corporate apologies.',
  'User is Rajveer Sukul, founder and architect of Voxora voice companion platform.',
  1776000000000,
  1776000000000
);

INSERT OR IGNORE INTO users (
  id,
  email,
  password_hash,
  salt,
  display_name,
  avatar_url,
  email_verified,
  role,
  chatgpt_custom_instructions,
  past_chats_summary,
  created_at,
  updated_at
) VALUES (
  'usr_admin_2026',
  'admin@voxora.ai',
  '39db16b7a872a4ec181634e45877088ca1af88894e8ec3434b3fa8a056c6a737d7956e3ed13047e3525f909d4c79866f87a29f847b4e9d8ae915cddef1d7c9ee',
  'a1b2c3d4e5f60718293a4b5c6d7e8f90',
  'Voxora Admin',
  '/avatars/lumina.png',
  1,
  'admin',
  'You are Voxora System Administrator Companion.',
  'Administrative root account for platform governance and health checks.',
  1776000000000,
  1776000000000
);

-- Default Agent Companion for Demo User
INSERT OR IGNORE INTO agent_configs (
  id,
  user_id,
  name,
  personality_prompt,
  provider,
  model,
  voice,
  language,
  avatar_type,
  avatar_url,
  is_default,
  created_at,
  updated_at
) VALUES (
  'agt_demo_default',
  'usr_demo_2026',
  'Aura',
  'An empathetic, cheerful voice companion fluent in Hinglish, English, and Benglish.',
  'openai',
  'gpt-4o-realtime-preview',
  'alloy',
  'hinglish',
  'neural_orb',
  NULL,
  1,
  1776000000000,
  1776000000000
);
