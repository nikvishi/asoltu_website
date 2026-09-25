# SEO Optimization Report — asoltu.com

**Date:** 2026-07-20  
**Scope:** Technical SEO, metadata, schema, FAQ, blog foundation, a11y, performance-oriented web shell  
**Constraint:** No redesign, no branding change, School ERP remains primary product focus  

---

## Files modified

| File | Change |
|------|--------|
| `web/index.html` | Home title/description, OG/Twitter, full JSON-LD graph, GSC/Bing placeholders, hreflang, skip link, crawlable static landmarks, preload |
| `web/robots.txt` | Explicit Allow for Googlebot/Bingbot, Host, sitemap |
| `web/sitemap.xml` | All public routes + `lastmod` + priorities |
| `web/manifest.json` | SEO-friendly name/description/lang |
| `lib/core/constants/app_strings.dart` | Primary title/description/keywords |
| `lib/core/seo/seo_config.dart` | Unique title/description per route |
| `lib/core/seo/seo_controller_web.dart` | Expanded meta, OG, Twitter, schema graph |
| `lib/core/seo/seo_faq_data.dart` | **New** — shared FAQ + schema answers |
| `lib/features/home/.../faq_section.dart` | Required SEO FAQs (CBSE/RBSE/Android/offline/etc.) |
| `lib/features/home/.../hero_section.dart` | Semantic H1 + natural keyword copy |
| `lib/features/home/.../technology_solutions_section.dart` | Keyword-aware subtitle |
| `lib/features/home/.../flagship_product_intro.dart` | Flagship ERP copy with India/Rajasthan |
| `lib/features/home/.../features_section.dart` | Module section SEO wording |
| `lib/features/blog/presentation/blog_page.dart` | Categories: School ERP, Education, Technology, AI, Software Development, Cloud |
| `lib/features/about/presentation/about_page.dart` | E-E-A-T mission/vision/experience/contact |
| `lib/core/widgets/components/section_heading.dart` | Semantic header |
| `lib/core/widgets/components/brand_logo.dart` | Descriptive logo alt |
| `docs/GOOGLE_SEARCH_CONSOLE.md` | **New** — GSC + Bing verification steps |
| `SEO_OPTIMIZATION_REPORT.md` | **New** — this report |

---

## SEO improvements

### Metadata
- **Home title:** `Asoltu Tech | School ERP, Software Development, AI & Cloud Solutions`
- **Home description:** As specified (ERP + software + AI + cloud + India)
- Unique titles & descriptions for all marketing routes
- `noindex` retained for `/login`
- Canonical + `hreflang` (`en-IN`, `x-default`)
- Keywords meta aligned to primary keyword list
- Open Graph + Twitter Card complete (title, description, image, alt)

### Structured data (JSON-LD)
| Type | Purpose |
|------|---------|
| Organization / Corporation | Brand entity |
| ProfessionalService (LocalBusiness) | Local SEO, Rajasthan/India |
| ContactPoint | Sales + support |
| WebSite + SearchAction | Site entity |
| SoftwareApplication | School ERP product |
| Product | Offer/category signals |
| FAQPage | Primary 7 SEO FAQs |
| BreadcrumbList | Navigation path |
| Blog / BlogPosting stubs | Blog foundation |
| AboutPage / ContactPage | Route-type pages |

### Robots & sitemap
- `robots.txt` allows all public pages, points to sitemap
- `sitemap.xml` includes every indexable path with priorities

### FAQ (visible + schema-aligned)
1. What is School ERP?  
2. Why choose Asoltu School ERP?  
3. Is Asoltu suitable for CBSE schools?  
4. Is Asoltu suitable for RBSE schools?  
5. Can parents use Asoltu?  
6. Does Asoltu support Android?  
7. Does Asoltu work offline?  

### Blog foundation
Categories: **School ERP · Education · Technology · AI · Software Development · Cloud**

### Internal linking
- Footer: Services, School ERP → products, Contact, About, Home  
- About CTAs: Contact, School ERP products  
- Static HTML nav landmarks for crawlers  

### Local SEO / E-E-A-T
- LocalBusiness schema with India + Rajasthan areaServed  
- About page: mission, vision, experience, contact, service area  
- Transparent sales/support emails  

---

## Performance improvements

| Item | Action |
|------|--------|
| Fonts | preconnect to Google Fonts |
| LCP image | preload `Icon-192.png` |
| Boot UX | Lightweight navy boot screen until first frame |
| Caching | Existing Firebase headers for assets / JS (unchanged) |
| Logo | `cacheWidth`/`cacheHeight` + gaplessPlayback |
| Below-fold | Existing `FadeIn` section animations retained (motion-aware) |

**Note:** Flutter Web CanvasKit remains the largest JS payload; full Lighthouse 100 requires SSR/prerender (future recommendation).

---

## Accessibility improvements

- Skip link → `#main`
- Semantic headers on section headings
- Hero primary heading as `Semantics(header: true)`
- FAQ tiles labeled for screen readers
- Brand logo descriptive `semanticLabel`
- Boot region `role="status"` / `aria-live`
- Site scaffold already exposes header / main landmarks  

---

## Google Search Console / Bing

Instructions: `docs/GOOGLE_SEARCH_CONSOLE.md`  

Placeholders in `web/index.html`:
- `google-site-verification`
- `msvalidate.01`  

Replace tokens after verification, then redeploy.

---

## Remaining recommendations

1. **Complete GSC + Bing verification** and submit sitemap.  
2. **Update phone numbers** in schema/copy when real numbers replace placeholders.  
3. **Postal address** for LocalBusiness when a public registered office address is approved.  
4. **HTML renderer or prerender** for stronger pure-HTML crawl of body copy (optional architecture project).  
5. **Blog posts as real routes** (`/blog/slug`) with unique meta for long-tail rankings.  
6. **Image CDN / WebP set** for any future marketing screenshots with explicit filenames (`school-erp-dashboard-india.webp`).  
7. **Google Business Profile** linked to LocalBusiness NAP data.  
8. **Backlinks / content calendar** — technical SEO is foundation; rankings need continuous content + authority.  

---

## Success criteria checklist

| Criterion | Status |
|-----------|--------|
| Home title / description as specified | ✅ |
| Unique page meta | ✅ |
| Canonical + robots | ✅ |
| OG + Twitter | ✅ |
| Organization, Website, SoftwareApplication, Product, LocalBusiness, ContactPoint, Breadcrumb, FAQ schema | ✅ |
| robots.txt + sitemap | ✅ |
| FAQ questions required | ✅ |
| Blog categories | ✅ |
| No redesign / branding change | ✅ |
| School ERP remains flagship | ✅ |

---

## Deploy note

Redeploy marketing hosting (`firebase deploy --only hosting:website`) for changes to go live on **https://asoltu.com**.
)
