# ASOLTU Corporate Website

**Marketing site:** https://asoltu.com  
**ERP portal (separate project):** https://erp.asoltu.com  

This repository folder is the **corporate SaaS website foundation** only.  
It must **never** be merged with `AsoltuSchoolERP`.

## Stack

- Flutter Web
- GoRouter (path URL strategy)
- Material 3 + ASOLTU navy/gold brand tokens
- Google Fonts (Inter)
- PWA-ready `web/manifest.json`
- SEO meta controller + static `index.html` tags

## Run

```bash
cd asoltu_website
flutter pub get
flutter run -d chrome
```

## Architecture

```
lib/
  main.dart                 # entry + path URL strategy
  app.dart                  # MaterialApp.router
  core/
    constants/              # URLs, assets, strings, breakpoints
    theme/                  # colors, type, spacing, radius, shadows
    routing/                # GoRouter + route names
    seo/                    # meta registry + document updates
    animations/             # page transitions, fade-in
    widgets/
      layout/               # scaffold, header, footer, responsive
      components/           # buttons, cards, forms, logo, social
  features/*/presentation/  # empty route pages (foundation)
```

## Routes

| Path | Page |
|------|------|
| `/` | Home (placeholder) |
| `/products` | Products |
| `/solutions` | Solutions |
| `/pricing` | Pricing |
| `/about` | About |
| `/resources` | Resources |
| `/blog` | Blog |
| `/contact` | Contact |
| `/careers` | Careers |
| `/privacy` | Privacy Policy |
| `/terms` | Terms |
| `/documentation` | Documentation |
| `/support` | Support |
| `/login` | Redirects to `https://erp.asoltu.com` |

## Hosting note

Both sites live in the Firebase project `asoltu-school-erp`, as two separate
Hosting sites. Hosting targets are named after their site so the target name can
never disagree with what it deploys to:

| Site ID | Domains | Repo | Deploy command |
|---|---|---|---|
| `asoltu-com` | asoltu.com, www.asoltu.com | this repo | `firebase deploy --only hosting:asoltu-com` |
| `asoltu-school-erp` | erp.asoltu.com | AsoltuSchoolERP | `firebase deploy --only hosting:asoltu-school-erp` |

This repo's `firebase.json` declares exactly one hosting config (`asoltu-com`),
so even a bare `firebase deploy --only hosting` cannot reach the ERP site — and
the ERP repo likewise cannot reach `asoltu-com`. Never add a second hosting
entry here.

SPA rewrites map `**` → `index.html` for clean path routes.

## Next phase

- Design and implement the full homepage
- Content for products, pricing, blog, legal
- Optional CMS / blog backend
- Wire production analytics (non-ERP)
