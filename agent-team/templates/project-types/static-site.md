# Static Site (HTML/CSS/JS)

## Stack
- **Build tool**: None (or optional Vite for bundling)
- **Framework**: Vanilla HTML, CSS, JavaScript
- **Deployment**: GitHub Pages (direct static files)

## Constraints
- No build step required (unless using Vite)
- No server-side logic
- All JavaScript runs in the browser
- CSS can use modern features (custom properties, grid, container queries)

## Folder Structure
```
├── index.html
├── css/
│   └── styles.css
├── js/
│   └── main.js
├── assets/
│   └── images/
└── pages/
    └── about.html
```

## Deployment
- GitHub Pages serves static files directly from `main` branch or `/docs` folder
- No GitHub Actions needed for basic static sites
- Configure in repo Settings → Pages → Source: Deploy from branch

## Common Gotchas
- Relative paths breaking when deployed to a subdirectory
- Not including viewport meta tag for mobile
- Large unoptimized images slowing page load
