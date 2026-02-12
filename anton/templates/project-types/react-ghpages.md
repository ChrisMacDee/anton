# React + GitHub Pages

## Stack
- **Build tool**: Vite
- **Framework**: React 18+
- **Deployment**: GitHub Pages via GitHub Actions

## Constraints
- Client-side only — no server-side rendering or API routes
- Set `base` in `vite.config.js` to `/<repo-name>/`
- Use **HashRouter** (not BrowserRouter) for client-side routing — GitHub Pages serves index.html only from root
- All asset paths must be relative (no leading `/`)
- No server-side environment variables — everything is baked into the build

## Scaffold Command
```bash
npm create vite@latest . -- --template react
```

## Deployment
- GitHub Actions workflow at `.github/workflows/deploy.yml`
- Uses `actions/deploy-pages@v4` (newer, official approach)
- Triggered on push to `main` branch
- Build output directory: `./dist`

## Common Gotchas
- Forgetting to set `base` in Vite config → broken asset paths on GH Pages
- Using BrowserRouter → 404s on page refresh
- Hardcoded localhost URLs → broken in production
- Large assets not optimized → slow page loads on free hosting
