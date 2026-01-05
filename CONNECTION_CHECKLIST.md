# Final Connection Checklist

Use this checklist to ensure your deployed application works correctly.

## 1. Backend Verification (Render)

1.  **Check Logs:** Go to your Render Dashboard -> Select your Service -> **Logs**.
2.  **Verify Start:** You should see: `🚀 Server running on port...`
3.  **Check Health:** Open `https://YOUR-BACKEND.onrender.com/health` in a browser.
    *   Expected: `{"status":"OK", ...}`
4.  **Wake Up:** If it was "spinning" for a long time, it was sleeping. Wait for the JSON response.

## 2. Frontend Configuration (Vercel)

1.  **Go to Settings:** Vercel Dashboard -> Project -> Settings -> **Environment Variables**.
2.  **Verify Variables:**
    *   `REACT_APP_API_URL` = `https://YOUR-BACKEND.onrender.com/api` (Must have `/api`)
    *   `REACT_APP_WEBSOCKET_URL` = `https://YOUR-BACKEND.onrender.com` (Must **NOT** have trailing slash)
3.  **Redeploy:** If you changed any variables, go to **Deployments** -> Redeploy.

## 3. CORS & Security Check

1.  **Backend Environment:** In Render, ensure `NODE_ENV` is set to `production`.
2.  **Backend CORS:** In Render, ensure `CORS_ORIGINS` includes your frontend URL (e.g., `https://my-app.vercel.app`).
    *   *Note:* The backend code is already configured to accept ANY `.vercel.app` domain automatically, so this step is just a backup.

## 4. Browser Testing

1.  Open your Vercel URL.
2.  Open **Developer Tools** (F12) -> **Console**.
3.  Look for: `🔌 Connecting to WebSocket URL: https://...`
4.  If you see `✅ WebSocket connected`, you are done!
5.  If you see red errors, send a screenshot of the console.
