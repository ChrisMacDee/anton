# Next.js Application

## Stack
- **Framework**: Next.js 14+ (App Router)
- **Deployment**: Vercel (recommended) or self-hosted

## Constraints
- Use Server Components by default, add `'use client'` only when needed (interactivity, hooks, browser APIs)
- API routes in `app/api/`
- Metadata via `generateMetadata` or `metadata` export
- Images via `next/image` for optimization
- Links via `next/link` for client-side navigation

## Scaffold Command
```bash
npx create-next-app@latest . --app --src-dir --tailwind --eslint
```

## Folder Structure
```
src/
├── app/
│   ├── layout.tsx        # Root layout
│   ├── page.tsx          # Home page
│   ├── about/
│   │   └── page.tsx
│   └── api/
│       └── hello/
│           └── route.ts
├── components/
├── lib/
└── styles/
```

## Deployment
- Vercel: Connect repo, auto-deploys
- Self-hosted: `npm run build && npm start`
- Static export: Add `output: 'export'` to `next.config.js`

## Common Gotchas
- Using hooks in Server Components → error (need 'use client')
- Fetching data in client components when server components would work
- Not using loading.tsx / error.tsx for route-level states
