# Google Search Console & Bing Webmaster — Setup Guide

**Domain:** https://asoltu.com  
**Sitemap:** https://asoltu.com/sitemap.xml  
**Robots:** https://asoltu.com/robots.txt  

---

## Google Search Console

### 1. Verify domain (recommended)

1. Open [Google Search Console](https://search.google.com/search-console).
2. Add property → **Domain** → `asoltu.com`.
3. Add the DNS TXT record Google provides at your domain registrar.
4. Click **Verify**.

### 2. Or verify via HTML meta tag (URL-prefix property)

1. Add property → **URL prefix** → `https://asoltu.com`.
2. Choose **HTML tag** method.
3. Copy the `content` token from Google.
4. In `web/index.html`, replace:

```html
<meta name="google-site-verification" content="REPLACE_WITH_GOOGLE_SEARCH_CONSOLE_TOKEN">
```

with your real token, then redeploy the website.

### 3. After verification

1. **Sitemaps** → submit `https://asoltu.com/sitemap.xml`.
2. Use **URL Inspection** on `/`, `/products`, `/pricing`, `/blog`, `/contact`.
3. Request indexing for key pages.
4. Monitor **Coverage**, **Core Web Vitals**, **Enhancements** (FAQ / Product if detected).

### 4. Placeholder currently shipped

```
REPLACE_WITH_GOOGLE_SEARCH_CONSOLE_TOKEN
```

Replace before relying on meta verification.

---

## Bing Webmaster Tools

1. Open [Bing Webmaster Tools](https://www.bing.com/webmasters).
2. Add site `https://asoltu.com`.
3. Import from Google Search Console **or** use meta tag.
4. Replace in `web/index.html`:

```html
<meta name="msvalidate.01" content="REPLACE_WITH_BING_WEBMASTER_TOKEN">
```

5. Submit sitemap: `https://asoltu.com/sitemap.xml`.

---

## Indexing checklist

| Item | URL |
|------|-----|
| Home | https://asoltu.com/ |
| School ERP products | https://asoltu.com/products |
| Solutions | https://asoltu.com/solutions |
| Pricing | https://asoltu.com/pricing |
| About | https://asoltu.com/about |
| Blog | https://asoltu.com/blog |
| Contact | https://asoltu.com/contact |
| Sitemap | https://asoltu.com/sitemap.xml |
| Robots | https://asoltu.com/robots.txt |

**Note:** `/login` is `noindex` (redirects to ERP portal).
)
