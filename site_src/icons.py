"""Small inline SVG icon set — no icon font, no extra request.

Each icon is a bare <svg> (viewBox only); callers wrap it and set size/color
via CSS on the parent. Stroke-based to match Material's rounded outline look
used throughout the Flutter build.
"""

_STROKE = 'fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"'

ICONS = {
    "shield": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M12 3l7 3v6c0 4.5-3 7.5-7 9-4-1.5-7-4.5-7-9V6z"/></svg>',
    "infinity": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M6 12a3 3 0 100 6 3 3 0 002-.9L16 9a3 3 0 112 5.1M18 12a3 3 0 10-2 5.1L8 9a3 3 0 10-2 5"/></svg>',
    "radar": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M12 12l7-7M12 2a10 10 0 100 20"/><path d="M12 6a6 6 0 100 12"/></svg>',
    "chip": f'<svg viewBox="0 0 24 24" {_STROKE}><rect x="6" y="6" width="12" height="12" rx="2"/><path d="M9 2v4M15 2v4M9 18v4M15 18v4M2 9h4M2 15h4M18 9h4M18 15h4"/></svg>',
    "split": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M6 3v6l6 6v6M18 3v6l-6 6"/></svg>',
    "restore": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M3 12a9 9 0 109-9 9 9 0 00-8 5"/><path d="M3 3v5h5"/></svg>',
    "cursor": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M5 3l14 8-6 1-3 6z"/></svg>',
    "swap": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M4 8h13M13 4l4 4-4 4M20 16H7M11 20l-4-4 4-4"/></svg>',
    "scan": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M4 8V5a1 1 0 011-1h3M20 8V5a1 1 0 00-1-1h-3M4 16v3a1 1 0 001 1h3M20 16v3a1 1 0 01-1 1h-3M3 12h18"/></svg>',
    "compress": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M8 3v4a1 1 0 01-1 1H3M16 3v4a1 1 0 001 1h4M8 21v-4a1 1 0 00-1-1H3M16 21v-4a1 1 0 011-1h4"/></svg>',
    "pen": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M12 20h9M16.5 3.5a2.1 2.1 0 013 3L7 19l-4 1 1-4z"/></svg>',
    "wifi": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M5 13a11 11 0 0114 0M8.5 16.5a6 6 0 017 0M12 20h.01"/></svg>',
    "trend": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M3 17l6-6 4 4 8-8M15 7h6v6"/></svg>',
    "bolt": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M13 2L4 14h6l-1 8 9-12h-6z"/></svg>',
    "lock": f'<svg viewBox="0 0 24 24" {_STROKE}><rect x="4" y="11" width="16" height="10" rx="2"/><path d="M8 11V7a4 4 0 118 0v4"/></svg>',
    "gift": f'<svg viewBox="0 0 24 24" {_STROKE}><rect x="3" y="8" width="18" height="13" rx="1"/><path d="M12 8v13M3 12h18M12 8c-2 0-4-1.5-4-3.5S9.5 2 11 2c2 0 3 2 1 6M12 8c2 0 4-1.5 4-3.5S13.5 2 12 2c-2 0-3 2-1 6z"/></svg>',
    "download": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M12 3v13M7 11l5 5 5-5M4 21h16"/></svg>',
    "windows": f'<svg viewBox="0 0 24 24" fill="currentColor"><path d="M3 5.5L10 4.5V11H3zM11 4.3L21 3v8H11zM3 12h7v6.5L3 17.5zM11 12h10v8L11 18.7z"/></svg>',
    "apple": f'<svg viewBox="0 0 24 24" fill="currentColor"><path d="M16.4 1.5c.1 1.1-.3 2.2-1 3-.7.8-1.9 1.5-3 1.4-.1-1.1.4-2.2 1-3 .7-.8 2-1.4 3-1.4zM20.6 17.2c-.5 1.2-.8 1.7-1.5 2.7-1 1.5-2.4 3.3-4.1 3.3-1.5 0-1.9-1-4-1s-2.5 1-4 1c-1.7 0-3-1.6-4-3.1-2.2-3.2-2.5-7-1.1-9 1-1.5 2.6-2.4 4.1-2.4 1.6 0 2.6 1.1 4 1.1s2.1-1.1 4-1.1c1.4 0 2.9.8 3.9 2.1-3.4 1.9-2.9 6.7 1.7 7.4z"/></svg>',
    "playstore": f'<svg viewBox="0 0 24 24" fill="currentColor"><path d="M3.6 2.3c-.4.3-.6.8-.6 1.4v16.6c0 .6.2 1.1.6 1.4l.1.1L13 12.5v-.2L3.7 2.2z"/><path d="M16.2 15.7l-3.2-3.2v-.2l3.2-3.2 3.7 2.1c1 .6 1 1.6 0 2.2z" opacity=".85"/><path d="M13 12.3l3.2 3.4-9.6 5.5c-.4.2-.9.2-1.4-.1z" opacity=".7"/><path d="M13 11.7L4.2 3l1.4-.1c.5-.3 1-.3 1.4-.1l9.6 5.5z" opacity=".55"/></svg>',
    "school": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M2 9l10-5 10 5-10 5z"/><path d="M6 11v5c0 1.5 2.5 3 6 3s6-1.5 6-3v-5M22 9v6"/></svg>',
    "check": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M20 6L9 17l-5-5"/></svg>',
    "arrow-right": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M5 12h14M13 5l7 7-7 7"/></svg>',
    "chevron-down": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M6 9l6 6 6-6"/></svg>',
    "menu": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M3 6h18M3 12h18M3 18h18"/></svg>',
    "close": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M18 6L6 18M6 6l12 12"/></svg>',
    "chat": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M21 11.5a8.4 8.4 0 01-8.9 8.4A8.6 8.6 0 013 15.9 8.4 8.4 0 019.5 3.1 8.6 8.6 0 0121 11.5z"/></svg>',
    "mail": f'<svg viewBox="0 0 24 24" {_STROKE}><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg>',
    "phone": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M22 16.9v3a2 2 0 01-2.2 2 19.8 19.8 0 01-8.6-3 19.5 19.5 0 01-6-6 19.8 19.8 0 01-3-8.7A2 2 0 014.1 2h3a2 2 0 012 1.7c.1 1 .3 2 .6 3a2 2 0 01-.5 2L8 10a16 16 0 006 6l1.3-1.2a2 2 0 012-.5c1 .3 2 .5 3 .6a2 2 0 011.7 2z"/></svg>',
    "pin": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 1116 0z"/><circle cx="12" cy="10" r="3"/></svg>',
    "help": f'<svg viewBox="0 0 24 24" {_STROKE}><circle cx="12" cy="12" r="10"/><path d="M9.1 9a3 3 0 015.8 1c0 2-3 2-3 4M12 17h.01"/></svg>',
    "star": f'<svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.1 6.3 7 1-5 4.9 1.2 7-6.3-3.3L5.7 21l1.2-7-5-4.9 7-1z"/></svg>',
    "sun": f'<svg viewBox="0 0 24 24" {_STROKE}><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>',
    "moon": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M21 12.8A9 9 0 1111.2 3a7 7 0 009.8 9.8z"/></svg>',
    "briefcase": f'<svg viewBox="0 0 24 24" {_STROKE}><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 21V5a2 2 0 00-2-2h-4a2 2 0 00-2 2v16"/></svg>',
    "book": f'<svg viewBox="0 0 24 24" {_STROKE}><path d="M4 19.5A2.5 2.5 0 016.5 17H20M4 19.5A2.5 2.5 0 006.5 22H20V2H6.5A2.5 2.5 0 004 4.5z"/></svg>',
    "life-buoy": f'<svg viewBox="0 0 24 24" {_STROKE}><circle cx="12" cy="12" r="10"/><circle cx="12" cy="12" r="4"/><path d="M4.9 4.9l4.2 4.2M19.1 4.9l-4.2 4.2M4.9 19.1l4.2-4.2M19.1 19.1l-4.2-4.2"/></svg>',
}


def icon(name, size=20):
    svg = ICONS.get(name, ICONS["check"])
    return svg.replace("<svg ", f'<svg width="{size}" height="{size}" ', 1)
