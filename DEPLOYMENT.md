# VOXORA — Production Deployment Guide

> **Product**: Voxora AI Voice Companion  
> **Tagline**: Your Voice. Your AI. Your Connection.  
> **Original Author**: Rajveer Sukul  
> **Copyright**: Copyright © 2026 Rajveer Sukul. All rights reserved.  

---

## 1. Hosting Architecture Overview

Voxora is built on **Next.js 16 (App Router)** with serverless API routes, WebRTC ephemeral session issuance, and server-side encrypted credentials.

> [!IMPORTANT]
> **Static Hosting Limitation**: A purely static file host (such as GitHub Pages or raw S3 without Lambda) cannot securely run WebRTC token generation, user password hashing, database operations, or AES-256-GCM secret decryption.
>
> Voxora must be deployed to a **Next.js-capable cloud platform** (Vercel, Render, Railway, Fly.io, or an Ubuntu VPS).

---

## 2. Deploying to Vercel (Recommended — Simplest for Beginners)

Vercel provides native, automatic, zero-configuration hosting for Next.js applications:

1. **Push your code to GitHub, GitLab, or Bitbucket**:
   ```bash
   git init
   git add .
   git commit -m "feat: complete multi-user Voxora production build"
   git remote add origin https://github.com/your-username/voxora.git
   git push -u origin main
   ```

2. **Import into Vercel**:
   - Navigate to [vercel.com/new](https://vercel.com/new).
   - Select your `voxora` repository.
   - Framework Preset will auto-detect as **Next.js**.

3. **Configure Environment Variables in Vercel Dashboard**:
   Under **Environment Variables**, configure:
   - `VOXORA_ENCRYPTION_SECRET`: (A 32+ character random secret)
   - `OPENAI_API_KEY`: `sk-proj-...`
   - `NEXT_PUBLIC_APP_URL`: `https://your-app.vercel.app`

4. **Deploy**:
   - Click **Deploy**. Vercel will run `next build` automatically.
   - Once deployed, your web application is live 24/7 with automatic HTTPS!

---

## 3. Deploying to Render / Railway (PaaS Containers)

Render and Railway allow persistent Node.js services:

### On Render:
1. Create a **Web Service** on [render.com](https://render.com).
2. Connect your repository.
3. Configure settings:
   - **Environment**: `Node`
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm start`
4. Add environment variables from `.env.example`.
5. Attach a persistent disk to `.voxora_data` if persistent SQLite across restarts is required.

---

## 4. Deploying with Docker

Voxora includes production Docker support.

### Dockerfile
Create or use the multi-stage Docker build:
```dockerfile
# Stage 1: Dependencies & Build
FROM node:24-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Production Runner
FROM node:24-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/src ./src

EXPOSE 3000
CMD ["npm", "start"]
```

Build and run:
```bash
docker build -t voxora:latest .
docker run -d -p 3000:3000 --env-file .env.local -v voxora_data:/app/.voxora_data --name voxora voxora:latest
```

---

## 5. Traditional Linux VPS Deployment (Ubuntu + PM2 + Nginx)

1. **Install Node.js 24 and PM2**:
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
   sudo apt-get install -y nodejs
   sudo npm install -g pm2
   ```

2. **Clone & Build**:
   ```bash
   git clone https://github.com/your-username/voxora.git /var/www/voxora
   cd /var/www/voxora
   npm ci
   npm run build
   ```

3. **Start Process Manager**:
   ```bash
   pm2 start npm --name "voxora" -- start
   pm2 save
   pm2 startup
   ```

4. **Nginx Reverse Proxy & SSL (Certbot)**:
   ```nginx
   server {
       server_name voxora.yourdomain.com;

       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```
   Obtain SSL:
   ```bash
   sudo certbot --nginx -d voxora.yourdomain.com
   ```

> [!CAUTION]
> **HTTPS is Required for Audio**: Browsers strictly forbid microphone access via `getUserMedia` on non-secure origins (except `localhost`). Live deployment **must** use an HTTPS domain.
