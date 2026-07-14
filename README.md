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

Deploy this app’s `build/web` to the **asoltu.com** hosting target only.  
Keep ERP hosting on **erp.asoltu.com** as a separate Firebase/Hosting site.

SPA rewrites should map `**` → `index.html` for clean path routes.

## Next phase

- Design and implement the full homepage
- Content for products, pricing, blog, legal
- Optional CMS / blog backend
- Wire production analytics (non-ERP)
