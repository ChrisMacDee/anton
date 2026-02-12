# React + Vercel

## Stack
- **Build tool**: Vite
- **Framework**: React 18+
- **Deployment**: Vercel (auto-deploy from GitHub)

## Constraints
- Client-side SPA (unless using Vercel serverless functions)
- BrowserRouter works fine — Vercel handles SPA rewrites
- Environment variables via Vercel dashboard or `.env.local`

## Scaffold Command
```bash
npm create vite@latest . -- --template react
```

## Deployment
- Connect GitHub repo to Vercel dashboard
- Auto-deploys on push to `main`
- Preview deployments on every PR
- Add `vercel.json` for SPA rewrite:

```json
{
  "rewrites": [{ "source": "/(.*)", "destination": "/" }]
}
```

## Environment Variables
- Local: `.env.local` (gitignored)
- Production: Set in Vercel dashboard
- Prefix with `VITE_` for client-side access

## Common Gotchas
- Forgetting VITE_ prefix on env vars → undefined in client
- Not adding vercel.json rewrite → 404s on direct URL access
