# Disaster Response Platform - Deployment Guide

This guide will help you deploy the **Disaster Response Platform** to the web.

## ⚠️ Important Concept
You requested to deploy the project. A common mistake is deploying the **Frontend** but leaving the **Backend** running on your laptop (`localhost`).
- **A deployed website (e.g., on Vercel) CANNOT access your local computer.**
- You must deploy **BOTH** the Frontend and the Backend.

---

## Part 1: Deploy the Backend (Render.com)
We will use **Render** because it is free and supports Node.js nicely.

1.  **Push your code to GitHub**
    - Make sure your project is committed and pushed to a GitHub repository.

2.  **Create an Account on Render**
    - Go to [render.com](https://render.com) and sign up with GitHub.

3.  **Create a New Web Service**
    - Click **"New +"** -> **"Web Service"**.
    - Connect your GitHub repository.
    - **Name:** `disaster-response-backend` (or similar)
    - **Root Directory:** `backend` (Important! Your backend code is in this folder).
    - **Environment:** `Node`
    - **Build Command:** `npm install`
    - **Start Command:** `node src/app.js`

4.  **Add Environment Variables**
    - Scroll down to "Environment Variables".
    - Add the variables from your `backend/.env` file. You need at least:
        - `SUPABASE_URL`: (Your Supabase URL)
        - `SUPABASE_KEY`: (Your Supabase Anon Key)
        - `NODE_ENV`: `production`
        - `CORS_ORIGINS`: `https://your-frontend-app.vercel.app` (You can update this later once you deploy the frontend).

5.  **Deploy**
    - Click **"Create Web Service"**.
    - Wait for the deployment to finish.
    - **Copy the URL** provided by Render (e.g., `https://disaster-backend.onrender.com`).

---

## Part 2: Deploy the Frontend (Vercel)
Now we deploy the React frontend and tell it where the backend lives.

1.  **Create an Account on Vercel**
    - Go to [vercel.com](https://vercel.com) and sign up with GitHub.

2.  **Add New Project**
    - Click **"Add New..."** -> **"Project"**.
    - Import your GitHub repository.

3.  **Configure Project**
    - **Framework Preset:** Create React App
    - **Root Directory:** Click "Edit" and select `frontend`.

4.  **Add Environment Variables**
    - Expand the "Environment Variables" section.
    - Add the following keys. **Use the Backend URL you just got from Render**:
        - `REACT_APP_API_URL`: `https://your-backend-url.onrender.com/api`
        - `REACT_APP_WEBSOCKET_URL`: `https://your-backend-url.onrender.com`
    - **Note:** Ensure you do **NOT** have a trailing slash `/` for the WebSocket URL.

5.  **Deploy**
    - Click **"Deploy"**.

---

## Part 3: Final Connection
1.  Once the Frontend is deployed, you will get a Frontend URL (e.g., `https://disaster-frontend.vercel.app`).
2.  Go back to your **Render Dashboard** (Backend).
3.  Update the `CORS_ORIGINS` environment variable to include your new Frontend URL.
    - Example: `https://disaster-frontend.vercel.app`
4.  **Redeploy** the backend (usually happens automatically when you save variables, or you can trigger a manual deploy).

## 🎉 Done!
Now when you open your Vercel link, it will talk to the Render backend, and everything will work!
