// ASOLTU static site — vanilla JS, no framework, no build step needed.
(function () {
  'use strict';

  /* ---------------------------------------------------------- theme ---- */
  var root = document.documentElement;
  var STORAGE_KEY = 'asoltu-theme';

  function applyTheme(mode) {
    root.setAttribute('data-theme', mode);
    try { localStorage.setItem(STORAGE_KEY, mode); } catch (e) {}
    document.querySelectorAll('[data-theme-icon]').forEach(function (el) {
      el.innerHTML = mode === 'dark' ? ICON_SUN : ICON_MOON;
    });
  }

  function initTheme() {
    var saved = null;
    try { saved = localStorage.getItem(STORAGE_KEY); } catch (e) {}
    var mode = saved || (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    // Default is light regardless of system preference, to match the
    // designed-for-light first impression; only an explicit saved choice
    // or toggle click moves to dark.
    applyTheme(saved || 'light');
  }

  var ICON_SUN = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/></svg>';
  var ICON_MOON = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.8A9 9 0 1111.2 3a7 7 0 009.8 9.8z"/></svg>';

  document.addEventListener('click', function (e) {
    var t = e.target.closest('[data-theme-toggle]');
    if (!t) return;
    var current = root.getAttribute('data-theme') === 'dark' ? 'dark' : 'light';
    applyTheme(current === 'dark' ? 'light' : 'dark');
  });

  initTheme();

  /* ------------------------------------------------------- header scroll */
  var header = document.querySelector('.site-header');
  if (header) {
    var onScroll = function () {
      if (window.scrollY > 12) header.classList.add('scrolled');
      else header.classList.remove('scrolled');
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  /* ---------------------------------------------------------- mega menu */
  var trigger = document.querySelector('[data-mega-trigger]');
  var menu = document.querySelector('[data-mega-menu]');
  if (trigger && menu) {
    var closeTimer = null;
    var open = function () {
      clearTimeout(closeTimer);
      menu.classList.add('open');
    };
    var scheduleClose = function () {
      closeTimer = setTimeout(function () { menu.classList.remove('open'); }, 150);
    };
    trigger.addEventListener('mouseenter', open);
    trigger.addEventListener('mouseleave', scheduleClose);
    menu.addEventListener('mouseenter', open);
    menu.addEventListener('mouseleave', scheduleClose);
    trigger.addEventListener('click', function (e) {
      e.preventDefault();
      menu.classList.toggle('open');
    });
  }

  /* ------------------------------------------------------- mobile drawer */
  var drawer = document.querySelector('[data-drawer]');
  document.addEventListener('click', function (e) {
    if (e.target.closest('[data-drawer-open]')) drawer && drawer.classList.add('open');
    if (e.target.closest('[data-drawer-close]') || e.target.closest('.mobile-drawer .scrim')) {
      drawer && drawer.classList.remove('open');
    }
  });

  /* --------------------------------------------------------- OS detect */
  function detectPlatform() {
    var ua = navigator.userAgent.toLowerCase();
    var touch = navigator.maxTouchPoints || 0;
    if (ua.indexOf('iphone') > -1 || ua.indexOf('ipad') > -1 || (ua.indexOf('mac') > -1 && touch > 1)) return 'appstore';
    if (ua.indexOf('android') > -1) return 'playstore';
    if (ua.indexOf('win') > -1) return 'windows';
    if (ua.indexOf('mac') > -1) return 'macos';
    return null;
  }
  window.__asoltuPlatform = detectPlatform();

  var PLATFORM_ICON_SVG = {
    windows: '<svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M3 5.5L10 4.5V11H3zM11 4.3L21 3v8H11zM3 12h7v6.5L3 17.5zM11 12h10v8L11 18.7z"/></svg>',
    macos: '<svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M16.4 1.5c.1 1.1-.3 2.2-1 3-.7.8-1.9 1.5-3 1.4-.1-1.1.4-2.2 1-3 .7-.8 2-1.4 3-1.4zM20.6 17.2c-.5 1.2-.8 1.7-1.5 2.7-1 1.5-2.4 3.3-4.1 3.3-1.5 0-1.9-1-4-1s-2.5 1-4 1c-1.7 0-3-1.6-4-3.1-2.2-3.2-2.5-7-1.1-9 1-1.5 2.6-2.4 4.1-2.4 1.6 0 2.6 1.1 4 1.1s2.1-1.1 4-1.1c1.4 0 2.9.8 3.9 2.1-3.4 1.9-2.9 6.7 1.7 7.4z"/></svg>',
    appstore: '<svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M16.4 1.5c.1 1.1-.3 2.2-1 3-.7.8-1.9 1.5-3 1.4-.1-1.1.4-2.2 1-3 .7-.8 2-1.4 3-1.4zM20.6 17.2c-.5 1.2-.8 1.7-1.5 2.7-1 1.5-2.4 3.3-4.1 3.3-1.5 0-1.9-1-4-1s-2.5 1-4 1c-1.7 0-3-1.6-4-3.1-2.2-3.2-2.5-7-1.1-9 1-1.5 2.6-2.4 4.1-2.4 1.6 0 2.6 1.1 4 1.1s2.1-1.1 4-1.1c1.4 0 2.9.8 3.9 2.1-3.4 1.9-2.9 6.7 1.7 7.4z"/></svg>',
    playstore: '<svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M3.6 2.3c-.4.3-.6.8-.6 1.4v16.6c0 .6.2 1.1.6 1.4l.1.1L13 12.5v-.2L3.7 2.2z"/><path d="M16.2 15.7l-3.2-3.2v-.2l3.2-3.2 3.7 2.1c1 .6 1 1.6 0 2.2z" opacity=".85"/><path d="M13 12.3l3.2 3.4-9.6 5.5c-.4.2-.9.2-1.4-.1z" opacity=".7"/><path d="M13 11.7L4.2 3l1.4-.1c.5-.3 1-.3 1.4-.1l9.6 5.5z" opacity=".55"/></svg>'
  };
  var PLATFORM_LABEL = { windows: 'Windows', macos: 'macOS', appstore: 'App Store', playstore: 'Google Play' };
  var PLATFORM_CTA = {
    windows: 'Download {n} for Windows', macos: 'Download {n} for Mac',
    appstore: 'Get {n} on the App Store', playstore: 'Get {n} on Google Play'
  };
  function downloadAttrs(a, platform) {
    if (platform === 'windows' || platform === 'macos') a.setAttribute('download', '');
    else { a.setAttribute('target', '_blank'); a.setAttribute('rel', 'noopener'); }
  }
  function renderPrimary(a, data, nameInLabel) {
    var icon = PLATFORM_ICON_SVG[data.platform].replace('width="20" height="20"', a.classList.contains('compact') ? 'width="18" height="18"' : 'width="20" height="20"');
    var label = nameInLabel ? PLATFORM_CTA[data.platform].replace('{n}', data.name) : PLATFORM_LABEL[data.platform];
    var sizeHtml = data.size && !a.classList.contains('compact') ? '<span class="size">' + data.size + '</span>' : '';
    a.className = a.classList.contains('compact') ? 'dl-btn compact' : 'dl-btn';
    a.setAttribute('data-role', 'primary');
    a.href = data.url;
    downloadAttrs(a, data.platform);
    a.innerHTML = icon + '<span>' + label + '</span>' + sizeHtml;
  }
  function renderSecondary(a, data) {
    var icon = PLATFORM_ICON_SVG[data.platform].replace('width="20" height="20"', 'width="15" height="15"');
    var text = PLATFORM_LABEL[data.platform] + (data.size ? ' · ' + data.size : '');
    a.className = 'dl-secondary';
    a.setAttribute('data-role', 'secondary');
    a.href = data.url;
    downloadAttrs(a, data.platform);
    a.innerHTML = icon + '<span>' + text + '</span>';
  }

  // Swaps which build is the large primary button to match the visitor's
  // OS. Server renders builds[0] as primary (crawlable, works with no JS);
  // this promotes the matching build by re-rendering both the current
  // primary and the matched secondary from their own data-build JSON, so
  // nothing is duplicated or left half-hidden.
  document.querySelectorAll('[data-smart-cta]').forEach(function (block) {
    var host = detectPlatform();
    if (!host) return;
    var primaryEl = block.querySelector('[data-role="primary"]');
    if (!primaryEl) return;
    var primaryData = JSON.parse(primaryEl.getAttribute('data-build'));
    if (primaryData.platform === host) return; // already showing the right build

    var secondarySlot = block.querySelector('[data-secondary-slot]');
    if (!secondarySlot) return;
    var matchEl = null;
    secondarySlot.querySelectorAll('a[data-role="secondary"]').forEach(function (a) {
      var d = JSON.parse(a.getAttribute('data-build'));
      if (d.platform === host) matchEl = a;
    });
    if (!matchEl) return;

    var nameInLabel = block.getAttribute('data-name-in-label') !== 'false';
    var matchData = JSON.parse(matchEl.getAttribute('data-build'));
    renderPrimary(matchEl, matchData, nameInLabel);
    renderSecondary(primaryEl, primaryData);

    var primarySlot = block.querySelector('[data-primary-slot]');
    primarySlot.innerHTML = '';
    primarySlot.appendChild(matchEl);
    secondarySlot.appendChild(primaryEl);

    var req = block.querySelector('[data-req]');
    if (req) {
      req.textContent = matchData.requires
        ? matchData.requires + (matchData.size ? ' · ' + matchData.size : '')
        : '';
    }
  });

  /* ------------------------------------------------------- scroll reveal */
  var io = 'IntersectionObserver' in window
    ? new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('in');
            io.unobserve(entry.target);
          }
        });
      }, { threshold: 0.1 })
    : null;
  document.querySelectorAll('.reveal').forEach(function (el) {
    if (io) io.observe(el); else el.classList.add('in');
  });

  /* ------------------------------------------------------ book demo modal */
  document.addEventListener('click', function (e) {
    if (e.target.closest('[data-book-demo]')) {
      e.preventDefault();
      window.location.href = '/contact';
    }
  });
})();
