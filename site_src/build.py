#!/usr/bin/env python3
"""Static-site generator for asoltu.com.

Reads products.json + legal_content.py, renders every page through plain
Python string templates (no Jinja — kept dependency-free), and writes the
result to ../site/. Run: python3 site_src/build.py
"""
import hashlib
import html
import json
import os
import re
import shutil
import sys
import time

sys.path.insert(0, os.path.dirname(__file__))
from icons import icon  # noqa: E402
from legal_content import LEGAL_PAGES  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Cache-buster for every /assets, /css and /js reference. A plain timestamp
# (not a content hash) is enough here: its only job is making sure a browser
# that cached an old build never shows stale CSS/JS/images under an
# unchanged URL after a rebuild.
BUILD_ID = str(int(time.time()))
SRC = os.path.join(ROOT, "site_src")
OUT = os.path.join(ROOT, "site")

with open(os.path.join(SRC, "products.json")) as f:
    DATA = json.load(f)
SITE = DATA["site"]
PRODUCTS = DATA["products"]


def by_id(pid):
    for p in PRODUCTS:
        if p["id"] == pid:
            return p
    raise KeyError(pid)


def esc(s):
    return html.escape(s, quote=True)


PLATFORM_LABEL = {
    "windows": "Windows",
    "macos": "macOS",
    "appstore": "App Store",
    "playstore": "Google Play",
}
PLATFORM_CTA = {
    "windows": "Download {name} for Windows",
    "macos": "Download {name} for Mac",
    "appstore": "Get {name} on the App Store",
    "playstore": "Get {name} on Google Play",
}
PLATFORM_ICON = {"windows": "windows", "macos": "apple", "appstore": "apple", "playstore": "playstore"}


# --------------------------------------------------------------- fragments
def product_icon_img(p, size=44, css_class="mini-icon"):
    return f'<img class="{css_class}" src="/assets/icons/{p["icon"]}" width="{size}" height="{size}" alt="">'


def download_attr(build):
    return "download" if build["platform"] in ("windows", "macos") else 'target="_blank" rel="noopener"'


def build_data_json(p, b):
    return json.dumps({
        "platform": b["platform"],
        "url": b["url"],
        "size": b.get("size"),
        "requires": b.get("requires"),
        "name": p["name"],
    })


def dl_button(p, build, compact=False, name_in_label=True):
    plat = build["platform"]
    label = PLATFORM_CTA[plat].format(name=p["name"]) if name_in_label and not compact else PLATFORM_LABEL[plat]
    size_html = f'<span class="size">{esc(build["size"])}</span>' if build.get("size") and not compact else ""
    cls = "dl-btn compact" if compact else "dl-btn"
    return (
        f'<a class="{cls}" data-platform="{plat}" href="{esc(build["url"])}" {download_attr(build)}>'
        f'{icon(PLATFORM_ICON[plat], 18 if compact else 20)}<span>{esc(label)}</span>{size_html}</a>'
    )


def dl_secondary(build):
    plat = build["platform"]
    label = PLATFORM_LABEL[plat]
    text = f'{label} · {build["size"]}' if build.get("size") else label
    return (
        f'<a class="dl-secondary" data-platform="{plat}" href="{esc(build["url"])}" {download_attr(build)}>'
        f'{icon(PLATFORM_ICON[plat], 15)}<span>{esc(text)}</span></a>'
    )


def smart_cta(p, name_in_label=True, compact=False):
    """Server-rendered with builds[0] as the primary button — fully crawlable
    and works with no JS. main.js then swaps the primary/secondary roles to
    match the visitor's OS by reading each element's data-build JSON, rather
    than juggling duplicate hidden nodes (the earlier version of this had two
    elements sharing one data-platform selector and picked the wrong one)."""
    primary, rest = p["builds"][0], p["builds"][1:]

    primary_html = (
        f'<a class="{"dl-btn compact" if compact else "dl-btn"}" data-role="primary" '
        f"data-build='{esc(build_data_json(p, primary))}' "
        f'href="{esc(primary["url"])}" {download_attr(primary)}>'
        f'{icon(PLATFORM_ICON[primary["platform"]], 18 if compact else 20)}'
        f'<span>{esc(PLATFORM_CTA[primary["platform"]].format(name=p["name"]) if name_in_label and not compact else PLATFORM_LABEL[primary["platform"]])}</span>'
        + (f'<span class="size">{esc(primary["size"])}</span>' if primary.get("size") and not compact else "")
        + "</a>"
    )
    req_text = ""
    if primary.get("requires"):
        req_text = primary["requires"] + (f' · {primary["size"]}' if primary.get("size") else "")
    req_html = f'<div class="dl-requirement" data-req>{esc(req_text)}</div>'

    secondary_html = "".join(
        f'<a class="dl-secondary" data-role="secondary" '
        f"data-build='{esc(build_data_json(p, b))}' "
        f'href="{esc(b["url"])}" {download_attr(b)}>'
        f'{icon(PLATFORM_ICON[b["platform"]], 15)}'
        f'<span>{esc(PLATFORM_LABEL[b["platform"]] + (f" · {b["size"]}" if b.get("size") else ""))}</span></a>'
        for b in rest
    )
    name_flag = "true" if name_in_label else "false"
    return (
        f'<div class="smart-cta" data-smart-cta data-name-in-label="{name_flag}">'
        f'<div data-primary-slot>{primary_html}</div>'
        f"{req_html}"
        f'<div data-secondary-slot style="margin-top:6px">{secondary_html}</div>'
        "</div>"
    )


def app_window(src, title, alt=""):
    return (
        '<div class="app-window"><div class="bar">'
        '<span class="dot" style="background:#ff5f57"></span>'
        '<span class="dot" style="background:#febc2e"></span>'
        '<span class="dot" style="background:#28c840"></span>'
        f'<span class="title">{esc(title)}</span></div>'
        f'<img src="{src}" alt="{esc(alt)}" loading="lazy"></div>'
    )


def phone_frame(src, alt=""):
    return f'<div class="phone-frame"><div class="screen"><img src="{src}" alt="{esc(alt)}" loading="lazy"></div></div>'


def product_shot_or_icon(p, wrap_class=""):
    if p.get("shots"):
        shot = f'/assets/shots/{p["shots"][0]}'
        if p.get("portrait"):
            return phone_frame(shot, p["name"])
        return app_window(shot, p["name"], p["name"])
    return f'<img class="icon" src="/assets/icons/{p["icon"]}" alt="{esc(p["name"])}" loading="lazy">'


# ------------------------------------------------------------------ header
NAV_ITEMS = [
    ("Products", "/software", True),
    ("Downloads", "/downloads", False),
    ("Education", "/education", False),
    ("Support", "/support", False),
    ("About", "/about", False),
]


def mega_menu():
    desktop = [p for p in PRODUCTS if any(b["platform"] in ("windows", "macos") for b in p["builds"])]
    mobile = [p for p in PRODUCTS if p not in desktop]

    def rows(items):
        out = []
        for p in items:
            out.append(
                f'<a class="mega-row" href="{p["route"]}">'
                f'{product_icon_img(p, 40)}'
                f'<span><span class="name" style="display:block">{esc(p["name"])}</span>'
                f'<span class="tag">{esc(p["tagline"])}</span></span></a>'
            )
        return '<div class="mega-grid">' + "".join(out) + "</div>"

    return (
        '<div class="mega-menu" data-mega-menu>'
        '<div class="mega-label">Desktop apps</div>' + rows(desktop) +
        '<div class="mega-label">Mobile apps</div>' + rows(mobile) +
        '<div class="mega-foot">' + icon("download", 17) +
        '<span style="font-size:14px;font-weight:600;color:var(--text-secondary)">All downloads in one place</span>'
        '<a href="/downloads">Download Center →</a></div>'
        "</div>"
    )


def mobile_drawer():
    items = "".join(
        f'<a class="nav-item" href="{route}">{label}</a>' for label, route, _ in NAV_ITEMS
    )
    apps = "".join(
        f'<a class="app-item" href="{p["route"]}">{product_icon_img(p, 34)}'
        f'<span><span class="name" style="display:block">{esc(p["name"])}</span>'
        f'<span class="tag">{esc(p["tagline"])}</span></span></a>'
        for p in PRODUCTS
    )
    return (
        '<div class="mobile-drawer" data-drawer><div class="scrim" data-drawer-close></div>'
        '<div class="panel"><div class="panel-top">'
        f'<a class="brand" href="/">{product_icon_img({"icon":"asoltu-logo.png"}, 32, "mini-icon") if False else ""}'
        '<img src="/assets/icons/asoltu-logo.png" width="32" height="32" style="border-radius:7px"><span style="font-weight:900">ASOLTU</span></a>'
        f'<button class="icon-btn" data-drawer-close>{icon("close",20)}</button></div>'
        f"{items}"
        '<div class="mega-label" style="margin-top:18px">Apps</div>'
        f"{apps}"
        "</div></div>"
    )


def header(active_path):
    nav_html = []
    for label, route, has_menu in NAV_ITEMS:
        active = "active" if active_path == route or (route != "/" and active_path.startswith(route)) else ""
        trigger_attr = ' data-mega-trigger' if has_menu else ""
        chevron = f'{icon("chevron-down",16)}' if has_menu else ""
        nav_html.append(
            f'<a class="nav-link {active}" href="{route}"{trigger_attr}>'
            f'<span class="label-row">{esc(label)}<span class="chevron" style="display:flex">{chevron}</span></span>'
            f'<span class="underline"></span></a>'
        )
    return (
        '<header class="site-header" id="site-header">'
        '<a class="brand" href="/">'
        '<img src="/assets/icons/asoltu-logo.png" width="30" height="30" alt="ASOLTU logo" style="border-radius:7px">'
        '<span>ASOLTU</span></a>'
        f'<nav class="nav-primary">{"".join(nav_html)}</nav>'
        + mega_menu() +
        '<div class="header-right">'
        f'<button class="icon-btn" data-theme-toggle aria-label="Toggle theme" data-theme-icon>{icon("moon",19)}</button>'
        '<a class="ghost-btn" href="/login">Login</a>'
        f'<a class="accent-btn" href="/contact" data-book-demo>Book Demo</a>'
        f'<button class="icon-btn hamburger" data-drawer-open aria-label="Open menu">{icon("menu",20)}</button>'
        "</div></header>"
        + mobile_drawer()
    )


# ------------------------------------------------------------------ footer
FOOTER_COLS = [
    ("Apps", [(p["name"], p["route"]) for p in PRODUCTS if p["id"] != "asoltu-app"][:5]),
    ("Company", [("Downloads", "/downloads"), ("School ERP", "/business/school-erp"), ("About", "/about"), ("Careers", "/careers"), ("Contact", "/contact")]),
    ("Legal", [("Privacy Policy", "/privacy"), ("Terms of Service", "/terms"), ("Refunds", "/refund"), ("Cookies", "/cookies"), ("Disclaimer", "/disclaimer")]),
]


def footer():
    cols = "".join(
        f'<div class="footer-col"><h4>{esc(h)}</h4>' + "".join(f'<a href="{r}">{esc(t)}</a>' for t, r in links) + "</div>"
        for h, links in FOOTER_COLS
    )
    return (
        '<footer class="site-footer"><div class="container">'
        '<div class="footer-cols"><div class="footer-brand">'
        '<a class="brand" href="/"><img src="/assets/icons/asoltu-logo.png" width="30" height="30" style="border-radius:7px">'
        '<span>ASOLTU</span></a>'
        "<p>Native desktop and mobile software, built in Rajasthan.</p></div>"
        f"{cols}</div>"
        f'<div class="footer-bottom">© 2026 ASOLTU Technologies</div>'
        "</div></footer>"
    )


def floating_bar():
    return f'<a class="floating-bar" href="{SITE["whatsapp"]}" target="_blank" rel="noopener" aria-label="WhatsApp us">{icon("chat",24)}</a>'


# --------------------------------------------------------------- page shell
def page(title, description, path, body, og_image=None):
    canonical = SITE["origin"] + path
    og = og_image or f'{SITE["origin"]}/assets/icons/asoltu-logo.png'
    return f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{esc(title)}</title>
<meta name="description" content="{esc(description)}">
<link rel="canonical" href="{canonical}">
<link rel="icon" href="/favicon.png">
<meta property="og:title" content="{esc(title)}">
<meta property="og:description" content="{esc(description)}">
<meta property="og:image" content="{og}">
<meta property="og:url" content="{canonical}">
<meta property="og:type" content="website">
<meta name="twitter:card" content="summary_large_image">
<link rel="stylesheet" href="/css/style.css">
<script>
(function(){{var s=null;try{{s=localStorage.getItem('asoltu-theme')}}catch(e){{}}
document.documentElement.setAttribute('data-theme', s||'light');}})();
</script>
</head>
<body>
<a class="skip-link" href="#main">Skip to main content</a>
{header(path)}
<main id="main">
{body}
</main>
{footer()}
{floating_bar()}
<script src="/js/main.js" defer></script>
</body>
</html>"""


def section_eyebrow_title(eyebrow, title, subtitle=None, mobile_break=None):
    sub = f'<p class="lede" style="margin-top:16px">{esc(subtitle)}</p>' if subtitle else ""
    return (
        '<div class="section-head">'
        f'<span class="eyebrow">{esc(eyebrow)}</span>'
        f'<h2 class="section-title">{esc(title)}</h2>{sub}</div>'
    )


def breadcrumb(path, trail):
    parts = []
    for label, href in trail:
        if href:
            parts.append(f'<a href="{href}">{esc(label)}</a>')
        else:
            parts.append(esc(label))
    return f'<div class="breadcrumb">{" / ".join(parts)}</div>'


# ============================================================== HOME PAGE
def home_page():
    featured = next((p for p in PRODUCTS if p.get("featured")), PRODUCTS[0])

    hero = f"""
<section class="hero">
  <div class="aurora"><div class="blob b1"></div><div class="blob b2"></div><div class="blob b3"></div><div class="blob b4"></div></div>
  <div class="hero-inner">
    <div class="pill"><span class="dot"></span>All builds current · Windows, macOS, iOS</div>
    <h1 class="h1">Six apps.<br><span class="grad">Every one free.</span></h1>
    <p class="lede">Native software for Windows, Mac and iPhone. No account, no trial, no upsell.</p>
    <div class="featured-card reveal">
      <span class="start-pill">{icon("star",14)} START HERE</span>
      <div>{product_icon_img(featured, 100, "icon")}</div>
      <h2>{esc(featured["name"])}</h2>
      <p class="tag">{esc(featured["tagline"])}</p>
      {smart_cta(featured)}
      <div><a class="what-it-does" href="{featured["route"]}">What {esc(featured["name"])} does →</a></div>
    </div>
    <div><a class="browse-link" href="/downloads">See all six apps →</a></div>
  </div>
</section>
"""

    cards = "".join(product_card(p) for p in PRODUCTS)
    products_section = f"""
<section class="section subtle">
  <div class="section-inner">
    {section_eyebrow_title("The whole shelf", "Pick one. It installs and it just works.")}
    <div class="product-grid">{cards}</div>
  </div>
</section>
"""

    why_items = [
        ("bolt", "#ffc94d", "Native, not a wrapper", "Rust and Flutter underneath. No hidden browser bloating a simple tool."),
        ("lock", "#2ed3b7", "Nothing phones home", "DataHop never sees your files. No desktop app here needs an account."),
        ("gift", "#6e8bff", "Actually free", "Every desktop app installs and runs without paying us a rupee."),
    ]
    why_cards = "".join(
        f'<div class="why-card reveal"><div class="ico" style="background:{c}22;color:{c}">{icon(i,23)}</div>'
        f"<h3>{esc(t)}</h3><p>{esc(b)}</p></div>"
        for i, c, t, b in why_items
    )
    why_section = f"""
<section class="section">
  <div class="aurora" style="opacity:.55"><div class="blob b1"></div><div class="blob b2"></div><div class="blob b3"></div><div class="blob b4"></div></div>
  <div class="section-inner" style="position:relative">
    {section_eyebrow_title("Why ours", "Built the way we wanted to use them.")}
    <div class="why-grid">{why_cards}</div>
  </div>
</section>
"""

    cta_section = f"""
<section class="section subtle">
  <div class="section-inner">
    <div class="cta-box">
      <h2>Start with one app.</h2>
      <p>Every installer, every platform, on one page.</p>
      <a class="white-btn" href="/downloads">{icon("download",20)}Open Download Center</a>
    </div>
  </div>
</section>
"""
    return hero + products_section + why_section + cta_section


def product_card(p):
    shot_html = ""
    if p.get("shots") and p.get("portrait"):
        # A portrait phone screenshot force-cropped into the landscape
        # shot-wrap (designed for macOS window captures) cut off text
        # mid-word and looked broken. Show it in a small phone frame
        # instead — the whole screenshot, not a random slice of it.
        shot_html = f'<div class="mini-phone"><img src="/assets/shots/{p["shots"][0]}" alt="" loading="lazy"></div>'
    elif p.get("shots"):
        shot_html = f'<div class="shot-wrap"><img src="/assets/shots/{p["shots"][0]}" alt="" loading="lazy"></div>'
    else:
        shot_html = f'<img class="icon" src="/assets/icons/{p["icon"]}" alt="" loading="lazy">'
    platforms = " · ".join(PLATFORM_LABEL[b["platform"]] for b in p["builds"])
    primary = p["builds"][0]
    # A <div>, not an <a>: the download buttons inside .body are themselves
    # <a> tags, and a browser cannot nest an <a> inside another <a> — it
    # silently closes the outer one early, which was splitting each card's
    # art and body into separate elements (the "wrong screenshot on wrong
    # card" bug). The invisible .stretched-link below makes the whole card
    # clickable without wrapping it in a real anchor.
    return f"""
<div class="product-card">
  <a class="stretched-link" href="{p["route"]}" aria-label="Open {esc(p["name"])}"></a>
  <div class="art" style="--card-a1:{p["accent"]}88;--card-a2:{p["accent"]}22"><div class="glow"></div>{shot_html}</div>
  <div class="body">
    <div class="top-row">
      {product_icon_img(p, 44)}
      <div><p class="name">{esc(p["name"])}</p><p class="platforms">{esc(platforms)}</p></div>
    </div>
    <p class="desc">{esc(p["tagline"])}</p>
    <div data-card-cta>{"".join(dl_button(p, b, compact=True) for b in p["builds"])}</div>
  </div>
</div>"""


# =========================================================== DOWNLOADS PAGE
def downloads_page():
    hero = f"""
<section class="hero" style="padding-bottom:50px">
  <div class="aurora"><div class="blob b1"></div><div class="blob b2"></div><div class="blob b3"></div><div class="blob b4"></div></div>
  <div class="hero-inner">
    <h1 class="h1"><span class="grad">Download Center</span></h1>
    <p class="lede">Every ASOLTU app, latest build, for Windows, macOS and iOS. Free, and nothing asks you to sign up first.</p>
  </div>
</section>
"""
    cards = "".join(release_card(p) for p in PRODUCTS)
    list_section = f'<section class="section" style="padding-top:0"><div class="section-inner" style="max-width:900px">{cards}</div></section>'

    help_items = [
        ("windows", "Windows says “Windows protected your PC”", "Click More info, then Run anyway. This appears because our installers are not code-signed yet, not because anything is wrong with the file."),
        ("apple", "macOS says the app is from an unidentified developer", "Open System Settings → Privacy & Security, find the blocked app near the bottom and choose Open Anyway. You only have to do this once."),
        ("help", "Still stuck?", "Write to info@asoltu.com with the app name and your OS version and we will walk you through it."),
    ]
    help_cards = "".join(
        f'<div class="help-card">{icon(i,22)}<h4>{esc(t)}</h4><p>{esc(b)}</p></div>' for i, t, b in help_items
    )
    help_section = f"""
<section class="section subtle">
  <div class="section-inner">
    <h2 class="section-title" style="margin-bottom:40px">Trouble installing?</h2>
    <div class="install-help-grid">{help_cards}</div>
  </div>
</section>
"""
    return hero + list_section + help_section


def release_card(p):
    shot_html = ""
    if p.get("shots"):
        if p.get("portrait"):
            shot_html = f'<div class="art">{phone_frame("/assets/shots/" + p["shots"][0], p["name"])}</div>'
        else:
            shot_html = f'<div class="art">{app_window("/assets/shots/" + p["shots"][0], p["name"], p["name"])}</div>'

    req_lines = "".join(
        f'<div class="req-line">{icon(PLATFORM_ICON[b["platform"]],13)}<span>'
        + esc(b.get("requires", "") + (f' · {b["size"]}' if b.get("size") else ""))
        + "</span></div>"
        for b in p["builds"]
        if b.get("requires")
    )
    buttons = "".join(dl_button(p, b, compact=True) for b in p["builds"])
    details = f"""
<div class="head-row">
  {product_icon_img(p, 56, "icon")}
  <div>
    <div class="title-row"><h3>{esc(p["name"])}</h3><span class="version-chip">v{esc(p["version"])}</span></div>
    <p class="sub">{esc(p["tagline"])}</p>
  </div>
</div>
<div class="buttons">{buttons}</div>
{req_lines}
<a class="what-it-does" href="{p["route"]}" style="margin-top:4px;display:inline-block">See what it does →</a>
"""
    if shot_html:
        body = f'<div class="release-split"><div>{details}</div>{shot_html}</div>'
    else:
        body = details
    accent = p["accent"]
    return f'<div class="release-card" style="--card-border:{accent}55;background:linear-gradient(135deg,{accent}14,transparent 60%)">{body}</div>'


# ============================================================ PRODUCT PAGE
def product_page(p):
    hero_art = product_shot_or_icon(p)
    feats = "".join(
        f'<div class="why-card reveal"><div class="ico" style="background:{p["accent"]}22;color:{p["accent"]}">{icon(i,23)}</div>'
        f"<h3>{esc(t)}</h3><p>{esc(b)}</p></div>"
        for i, t, b in p["features"]
    )
    hero = f"""
<section class="hero">
  <div class="aurora"><div class="blob b1" style="background:radial-gradient(circle,{p["accent"]}44,transparent 72%)"></div>
    <div class="blob b2"></div><div class="blob b3"></div><div class="blob b4"></div></div>
  <div class="hero-inner">
    {product_icon_img(p, 92, "icon")}
    <h1 class="h1" style="margin-top:26px;font-size:clamp(32px,6vw,52px)">{esc(p["name"])}</h1>
    <p style="font-size:22px;font-weight:600;letter-spacing:-.4px;margin:14px auto 0;max-width:600px">{esc(p["tagline"])}</p>
    <p class="lede" style="max-width:600px">{esc(p["description"])}</p>
    <div style="margin-top:30px">{smart_cta(p)}</div>
    <div style="margin-top:56px" class="reveal">{hero_art}</div>
  </div>
</section>
"""
    features_section = f"""
<section class="section subtle">
  <div class="section-inner"><div class="why-grid">{feats}</div></div>
</section>
"""
    gallery_section = ""
    if len(p.get("shots", [])) > 1:
        rest = p["shots"][1:]
        frames = "".join(
            phone_frame(f"/assets/shots/{s}", p["name"]) if p.get("portrait") else app_window(f"/assets/shots/{s}", p["name"], p["name"])
            for s in rest
        )
        gallery_section = f"""
<section class="section">
  <div class="section-inner">
    <h2 class="section-title" style="margin-bottom:44px">A closer look</h2>
    <div class="gallery-wrap">{frames}</div>
  </div>
</section>
"""
    bottom_cta = f"""
<section class="section subtle">
  <div class="section-inner" style="text-align:center;max-width:600px;margin:0 auto">
    {product_icon_img(p, 64, "icon")}
    <h2 class="section-title" style="margin-top:24px">Get {esc(p["name"])}</h2>
    <p style="color:var(--text-muted);margin-top:12px">Version {esc(p["version"])}</p>
    <div style="margin-top:30px;display:flex;justify-content:center">{smart_cta(p)}</div>
  </div>
</section>
"""
    return hero + features_section + gallery_section + bottom_cta


# ================================================================ HUB PAGE
def hub_page(eyebrow, title, subtitle, products, links=None):
    cards = "".join(product_card(p) for p in products)
    products_html = f'<div class="product-grid" style="margin-top:8px">{cards}</div>' if products else ""
    links_html = ""
    if links:
        cards_l = "".join(
            f'<a class="hub-link-card" href="{href}"><div class="ico">{icon(ic,24)}</div>'
            f'<div><h4>{esc(t)}</h4><p>{esc(d)}</p></div><div class="arrow">{icon("arrow-right",20)}</div></a>'
            for t, d, href, ic in links
        )
        links_html = f'<section class="section subtle"><div class="section-inner"><div class="hub-links">{cards_l}</div></div></section>'
    body = f"""
<section class="hero" style="padding-bottom:20px">
  <div class="hero-inner">
    <span class="eyebrow">{esc(eyebrow)}</span>
    <h1 class="h1" style="margin-top:14px;font-size:clamp(30px,5.5vw,54px)">{title}</h1>
    <p class="lede">{esc(subtitle)}</p>
  </div>
</section>
<section class="section" style="padding-top:8px"><div class="section-inner">{products_html}</div></section>
{links_html}
"""
    return body


# =============================================================== LEGAL PAGE
def legal_page(data):
    secs = "".join(
        f"<h2>{esc(h)}</h2><p>{esc(b)}</p>" for h, b in data["sections"]
    )
    body = f"""
<section class="section" style="padding-top:calc(var(--header-h) + 56px)">
  <div class="section-inner legal-page">
    <span class="eyebrow">Legal</span>
    <h1 class="h1" style="font-size:40px;margin-top:14px">{esc(data["title"])}</h1>
    <p class="updated">Last updated: 14 July 2026 · ASOLTU Technologies</p>
    {secs}
    <p style="font-weight:700;color:var(--text-primary)">Questions: info@asoltu.com</p>
  </div>
</section>
"""
    return body


# ========================================================= SIMPLE TEXT PAGE
def simple_page(eyebrow, title, subtitle, sections_html):
    return f"""
<section class="text-page-hero">
  <span class="eyebrow">{esc(eyebrow)}</span>
  <h1 style="margin-top:14px">{esc(title)}</h1>
  <p>{esc(subtitle)}</p>
</section>
{sections_html}
"""


def bullet_grid(items):
    cards = "".join(
        f'<div class="why-card"><h3 style="font-size:16px">{esc(t)}</h3><p>{esc(b)}</p></div>' for t, b in items
    )
    return f'<section class="section"><div class="section-inner"><div class="why-grid">{cards}</div></div></section>'


# ================================================================== WRITE
_ASSET_REF = re.compile(r'(src|href)="(/(?:assets|css|js)/[^"?]+)"')


def _bust_cache(html_body):
    return _ASSET_REF.sub(lambda m: f'{m.group(1)}="{m.group(2)}?v={BUILD_ID}"', html_body)


def write(path_no_ext, html_body):
    """path_no_ext like '/software/datahop' -> site/software/datahop/index.html
    '/' -> site/index.html"""
    if path_no_ext == "/":
        target = os.path.join(OUT, "index.html")
    else:
        target = os.path.join(OUT, path_no_ext.strip("/"), "index.html")
    os.makedirs(os.path.dirname(target), exist_ok=True)
    with open(target, "w") as f:
        f.write(_bust_cache(html_body))


def build():
    if os.path.exists(OUT):
        shutil.rmtree(OUT)
    os.makedirs(OUT)

    # static passthrough
    shutil.copytree(os.path.join(SRC, "..", "assets", "icons", "products"), os.path.join(OUT, "assets", "icons"), dirs_exist_ok=True)
    # Pre-shrunk (128px) copy — the source is 512px+ and would otherwise ship
    # at 60KB+ for a 30px header icon.
    shutil.copy(os.path.join(SRC, "static", "asoltu-logo.png"), os.path.join(OUT, "assets", "icons", "asoltu-logo.png"))
    os.makedirs(os.path.join(OUT, "assets", "shots"), exist_ok=True)
    for p in PRODUCTS:
        for s in p.get("shots", []):
            src = os.path.join(SRC, "..", "assets", "images", "products", s)
            if os.path.exists(src):
                shutil.copy(src, os.path.join(OUT, "assets", "shots", s))
    os.makedirs(os.path.join(OUT, "assets", "fonts"), exist_ok=True)
    shutil.copy(os.path.join(SRC, "..", "assets", "fonts", "PlusJakartaSans.ttf"), os.path.join(OUT, "assets", "fonts", "PlusJakartaSans.ttf"))
    os.makedirs(os.path.join(OUT, "css"), exist_ok=True)
    shutil.copy(os.path.join(SRC, "style.css"), os.path.join(OUT, "css", "style.css"))
    os.makedirs(os.path.join(OUT, "js"), exist_ok=True)
    shutil.copy(os.path.join(SRC, "main.js"), os.path.join(OUT, "js", "main.js"))
    fav = os.path.join(ROOT, "web", "favicon.png")
    if os.path.exists(fav):
        shutil.copy(fav, os.path.join(OUT, "favicon.png"))
    robots = os.path.join(ROOT, "web", "robots.txt")
    if os.path.exists(robots):
        shutil.copy(robots, os.path.join(OUT, "robots.txt"))
    # release binaries live alongside (copied by the caller from web/releases)

    # ---- login redirect (mirrors LoginRedirectPage: bounce straight to ERP)
    erp = SITE["erp"]
    erp_host = erp.replace("https://", "")
    login_html = (
        "<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\">"
        f'<meta http-equiv="refresh" content="0; url={erp}">'
        "<title>Redirecting to ASOLTU ERP&hellip;</title>"
        f'<link rel="canonical" href="{erp}">'
        f"<script>window.location.replace('{erp}');</script></head>"
        f'<body><p>Redirecting to <a href="{erp}">{erp_host}</a>&hellip;</p></body></html>'
    )
    write("/login", login_html)

    # ---- home / downloads    # ---- home / downloads
    write("/", page("ASOLTU — Native apps for Windows, Mac and iPhone", "Six free native apps for Windows, macOS and iOS: file transfer, downloads, remote access and more. No account required.", "/", home_page()))
    write("/downloads", page("Download Center — ASOLTU", "Download every ASOLTU app: DataHop, Download Manager, AsoltuRemote, PDF-O, i2Droid and Asoltu, for Windows, macOS and iOS.", "/downloads", downloads_page()))

    # ---- product pages
    for p in PRODUCTS:
        write(p["route"], page(f'{p["name"]} — ASOLTU', p["tagline"], p["route"], product_page(p)))

    # ---- hubs
    write("/products", page("Products — ASOLTU", "Every ASOLTU product: desktop utilities, mobile apps, and the School ERP platform.", "/products", hub_page(
        "Products", "Everything ASOLTU makes.", "Desktop utilities, mobile apps, and the school platform behind them. Pick one and download it now.",
        PRODUCTS,
        [("School ERP", "Admissions, fees, attendance and exams for a whole campus.", "/business/school-erp", "school"),
         ("Exam Series", "Mock tests and AI proctoring for competitive exams.", "/education/exam-series", "check")],
    )))
    write("/software", page("Software — ASOLTU", "Desktop and mobile utilities from ASOLTU: DataHop, Download Manager, AsoltuRemote, PDF-O and i2Droid.", "/software", hub_page(
        "Desktop & mobile", "Apps you install, not tabs you keep open.", "Built with Rust and Flutter so they start fast, stay small, and keep your files on your own machine.",
        [p for p in PRODUCTS if p["id"] != "asoltu-app"],
    )))
    write("/education", page("Education Software — ASOLTU", "Software for schools and students: School ERP, Exam Series and the Asoltu learning app.", "/education", hub_page(
        "Education", "Software for schools\nand the students in them.", "From running a whole campus to practising for the exam at the end of it, in one ecosystem.",
        [by_id("asoltu-app")],
        [("School ERP", "Attendance, fees, exams and AI-assisted reports in one platform.", "/business/school-erp", "school"),
         ("Exam Series", "Chapterwise and full mock tests for RPSC, REET, SSC, UPSC and ICAI.", "/education/exam-series", "check")],
    )))
    write("/business", page("Business Solutions — ASOLTU", "Software for institutions and businesses: School ERP, document utilities, and custom engineering.", "/business", hub_page(
        "Business", "Software that respects\nhow you already work.", "The campus platform, the document tools around it, and custom builds when what you need does not exist yet.",
        [p for p in PRODUCTS if p["id"] in ("pdf-o", "asoltu-remote")],
        [("School ERP", "A complete campus management system for modern institutions.", "/business/school-erp", "school"),
         ("Talk to us", "Custom Flutter apps, cloud infrastructure and integrations.", "/contact", "chat")],
    )))

    # ---- ERP / exam series demo-led landings (kept minimal, link out to contact/app)
    write("/business/school-erp", page("School ERP — ASOLTU", "A modern operating system for your campus: admissions, fees, attendance, homework, exams and AI-driven reporting.", "/business/school-erp", hub_page(
        "Business", "School ERP", "A modern operating system for your campus. Move beyond spreadsheets — admissions, fees, attendance, homework, exams and AI-driven reporting in one platform.", [],
        [("Book a demo", "See School ERP running on a real campus dataset.", "/contact", "school"),
         ("Admin login", "Already a customer? Sign in to your ERP portal.", SITE["erp"], "arrow-right")],
    )))
    write("/education/exam-series", page("Exam Series — ASOLTU", "Premium mock tests and AI proctoring for RPSC, RAS, REET, SSC, UPSC and ICAI.", "/education/exam-series", hub_page(
        "Education", "Exam Series", "Premium mock tests and AI proctoring. Expert study material, chapterwise tests, and full mock exams for RPSC, RAS, REET, SSC, UPSC and ICAI.", [],
        [("Get the app", "Every mock test lives inside the Asoltu app.", "/education/asoltu-app", "book")],
    )))

    # ---- legal
    for slug, data in LEGAL_PAGES.items():
        write(data["route"], page(f'{data["title"]} — ASOLTU', f'{data["title"]} for asoltu.com.', data["route"], legal_page(data)))

    # ---- about / careers / support / docs / blog / contact
    write("/about", page("About — ASOLTU", "ASOLTU Technologies builds School ERP, Flutter apps, and native desktop software from Rajasthan, India.", "/about", about_page()))
    write("/careers", page("Careers — ASOLTU", "Join ASOLTU Technologies — a team shipping native software and reliable ERP for modern institutions.", "/careers", careers_page()))
    write("/support", page("Support — ASOLTU", "Documentation, onboarding, and help for ASOLTU products and School ERP.", "/support", support_page()))
    write("/documentation", page("Documentation — ASOLTU", "Implementation-oriented guides for ASOLTU School ERP administrators and implementers.", "/documentation", docs_page()))
    write("/blog", page("Blog — ASOLTU", "Notes on building ASOLTU's apps and School ERP.", "/blog", blog_page()))
    write("/contact", page("Contact — ASOLTU", "Get in touch with ASOLTU Technologies for demos, support, or partnership enquiries.", "/contact", contact_page()))

    print(f"Built {sum(len(files) for _,_,files in os.walk(OUT))} files into {OUT}")


# ----------------------------------------------------------- misc content
def about_page():
    points = [
        ("Operators first. Technology second.", "ASOLTU is shaped by real operational complexity: multi-role access, fee cycles, attendance discipline, parent trust, and the need for one system of record."),
        ("Multi-tenant architecture", "Multi-tenant isolation and role-based access by design, so institution data boundaries are enforced by architecture, not convention."),
        ("Modern stack. Enterprise discipline.", "Flutter Web & Mobile, multi-tenant systems, AI reporting foundations, and production hardening for real campuses."),
    ]
    return simple_page(
        "About",
        "About ASOLTU Technologies",
        "ASOLTU Technologies is a modern software engineering company in India. We build School ERP, Flutter apps, web platforms, cloud and AI solutions so schools and businesses run on reliable systems — not spreadsheets.",
        bullet_grid(points) + f"""
<section class="section subtle"><div class="section-inner" style="max-width:700px;text-align:center">
<h2 class="section-title">Contact &amp; service area</h2>
<p style="color:var(--text-secondary);margin-top:16px;line-height:1.7">ASOLTU Technologies · RMA, Ramganj Mandi, Rajasthan, India<br>
Email: info@asoltu.com · Phone: +91-9462133119<br>Hours: Monday to Saturday, 10:00 AM – 7:00 PM IST</p>
</div></section>"""
    )


def careers_page():
    roles = [
        ("Backend / Platform Engineer", "GTM · India · Full-time", "Flutter, Material 3, and multi-tenant SaaS patterns used in real production campuses."),
        ("Customer Success Manager", "GTM · India · Full-time", "Help institutions evaluate ASOLTU School ERP and guide commercial conversations."),
    ]
    role_cards = "".join(
        f'<div class="why-card"><h3 style="font-size:17px">{esc(t)}</h3><p class="tag" style="color:var(--text-muted);font-size:13px;margin:4px 0 10px">{esc(sub)}</p><p>{esc(b)}</p>'
        f'<a class="what-it-does" href="mailto:careers@asoltu.com?subject={esc(t)}" style="display:inline-block;margin-top:14px">Apply via careers@asoltu.com →</a></div>'
        for t, sub, b in roles
    )
    perks = [
        ("Flexible hybrid work", "Collaborate with focus — hybrid-friendly culture for deep engineering and GTM work."),
        ("Learning & conference budget", "Early ownership of product surface area and real production impact."),
        ("Competitive compensation", "Meaningful equity conversations where applicable, plus health benefits as role and location allow."),
    ]
    return simple_page(
        "Careers",
        "Build the future of school software",
        "Join ASOLTU Technologies — a team shipping reliable ERP and native apps for modern institutions.",
        f'<section class="section"><div class="section-inner"><div class="why-grid">{role_cards}</div></div></section>'
        + bullet_grid(perks)
        + '<section class="section subtle"><div class="section-inner" style="text-align:center"><p style="color:var(--text-secondary)">Do not see a perfect match? Write to us anyway — strong generalists are welcome.</p>'
          '<a class="accent-btn" href="mailto:careers@asoltu.com" style="margin-top:16px;display:inline-flex">Email careers@asoltu.com</a></div></section>'
    )


def support_page():
    tiers = [
        ("Community-style self-serve", "Best-effort responses on business days for evaluation and core questions. Documentation access and module how-to assistance."),
        ("Help Center for live campuses", "Faster turnaround for live campuses on paid Professional plans. Role-based sessions for admins, teachers, and finance teams."),
        ("Enterprise success paths", "Named success contact options and custom SLAs via enterprise agreement."),
    ]
    return simple_page(
        "Support",
        "Help your team go live with confidence",
        "Documentation, training, onboarding, ticket paths, and SLAs for ASOLTU products and School ERP.",
        bullet_grid(tiers) + f"""
<section class="section subtle"><div class="section-inner" style="max-width:600px;text-align:center">
<h2 class="section-title">Still need help?</h2>
<p style="color:var(--text-secondary);margin-top:14px">Write to info@asoltu.com or call +91-9462133119. Monday to Saturday, 10:00 AM – 7:00 PM IST.</p>
<a class="accent-btn" href="/contact" style="margin-top:22px;display:inline-flex">Contact us</a>
</div></section>"""
    )


def docs_page():
    topics = [
        ("First-week checklist", "Launch your campus on ASOLTU with a clear first-week sequence: academic year, roles, and first-week checklist."),
        ("Multi-campus administration", "Patterns for education groups and franchise-style rollouts. Institution data boundaries and how marketing leads stay separate from ERP tenants."),
        ("Parent app experience", "Fees status, attendance, homework, and school notices families can trust."),
        ("Classroom tools", "Attendance, homework, results, and communication for teachers and staff."),
        ("Library & transport", "Catalog, issue/return, routes, vehicles, and passenger operations."),
        ("AI-assisted reporting", "How intelligent summaries are generated from operational data for leaders."),
    ]
    return simple_page(
        "Documentation",
        "ASOLTU product documentation",
        "Implementation-oriented guides for administrators, implementers, and campus champions. Browse topics below or contact support for guided help.",
        bullet_grid(topics) + '<section class="section subtle"><div class="section-inner" style="text-align:center">'
        '<a class="accent-btn" href="/contact" style="display:inline-flex">Book implementation call</a></div></section>'
    )


def blog_page():
    return simple_page(
        "Blog",
        "Notes from ASOLTU",
        "Longer-form posts on our apps and School ERP are on the way. Meanwhile, browse the Download Center or get in touch.",
        '<section class="section"><div class="section-inner" style="text-align:center;max-width:520px;margin:0 auto">'
        '<p style="color:var(--text-secondary)">No posts yet — check back soon.</p>'
        '<a class="accent-btn" href="/downloads" style="margin-top:20px;display:inline-flex">Browse downloads</a></div></section>'
    )


def contact_page():
    fields = [
        ("fullName", "Full Name *", "text", True),
        ("schoolName", "School / Organization Name *", "text", True),
        ("mobile", "Mobile Number *", "tel", False),
        ("email", "Email *", "email", False),
        ("city", "City *", "text", False),
        ("state", "State *", "text", False),
        ("numberOfStudents", "Number of Students *", "text", True),
    ]
    field_html = []
    for name, label, itype, full in fields:
        cls = "field full" if full else "field"
        field_html.append(f'<div class="{cls}"><label for="{name}">{esc(label)}</label><input id="{name}" name="{name}" type="{itype}" required></div>')
    field_html.append('<div class="field full"><label for="message">Message *</label><textarea id="message" name="message" required></textarea></div>')

    info_cards = [
        ("mail", "Email", "info@asoltu.com", "mailto:info@asoltu.com"),
        ("phone", "Phone", "+91-9462133119", "tel:+919462133119"),
        ("chat", "WhatsApp", "Chat with us", SITE["whatsapp"]),
        ("pin", "Office", "Ramganj Mandi, Rajasthan", "https://www.google.com/maps/search/?api=1&query=Ramganj+Mandi+Rajasthan+India"),
    ]
    info_html = "".join(
        f'<a class="contact-info-card" href="{href}" target="_blank" rel="noopener">{icon(i,20)}'
        f'<div><div class="lbl">{esc(l)}</div><div class="val">{esc(v)}</div></div></a>'
        for i, l, v, href in info_cards
    )

    body = f"""
<section class="text-page-hero">
  <span class="eyebrow">Contact</span>
  <h1 style="margin-top:14px">Let&rsquo;s talk</h1>
  <p>Demos, pricing, and commercial questions. We reply within one business day.</p>
</section>
<section class="section" style="padding-top:8px">
  <div class="section-inner" style="max-width:760px">
    <div class="contact-card">
      <form id="contact-form">
        <div class="form-grid">{"".join(field_html)}</div>
        <button class="accent-btn" type="submit" style="margin-top:22px" id="contact-submit">Submit Enquiry</button>
        <div class="form-status" id="contact-status" role="status"></div>
      </form>
    </div>
    <div class="contact-info-grid">{info_html}</div>
  </div>
</section>
<script src="https://www.gstatic.com/firebasejs/10.14.1/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.14.1/firebase-firestore-compat.js"></script>
<script>
firebase.initializeApp({{
  apiKey: "AIzaSyAz7U4m0iBMpgi2jBmrT3GQLLQcAUXYmf0",
  appId: "1:474977907871:web:66bddd3ca480cabe1f1eaa",
  projectId: "asoltu-school-erp",
  authDomain: "asoltu-school-erp.firebaseapp.com"
}});
var form = document.getElementById('contact-form');
var status = document.getElementById('contact-status');
var submitBtn = document.getElementById('contact-submit');
form.addEventListener('submit', function(e) {{
  e.preventDefault();
  submitBtn.disabled = true; submitBtn.textContent = 'Sending…';
  var fd = new FormData(form);
  var payload = {{}}; fd.forEach(function(v,k){{ payload[k]=v; }});
  payload.source = 'asoltu.com/contact';
  payload.createdAt = firebase.firestore.FieldValue.serverTimestamp();
  payload.clientTimestamp = new Date().toISOString();
  firebase.firestore().collection('contacts').add(payload).then(function(){{
    status.textContent = 'Thanks — we will get back to you within one business day.';
    status.className = 'form-status ok';
    form.reset();
  }}).catch(function(err){{
    status.textContent = 'Could not submit. Please email info@asoltu.com directly.';
    status.className = 'form-status err';
    console.error(err);
  }}).finally(function(){{
    submitBtn.disabled = false; submitBtn.textContent = 'Submit Enquiry';
  }});
}});
</script>
"""
    return body


if __name__ == "__main__":
    build()
