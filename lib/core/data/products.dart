import 'package:flutter/material.dart';

/// Where a build can be downloaded from.
enum Platform { windows, macOS, appStore, playStore, android }

extension PlatformDisplay on Platform {
  String get label => switch (this) {
        Platform.windows => 'Windows',
        Platform.macOS => 'macOS',
        Platform.appStore => 'App Store',
        Platform.playStore => 'Google Play',
        Platform.android => 'Android',
      };

  String get ctaLabel => switch (this) {
        Platform.windows => 'Download for Windows',
        Platform.macOS => 'Download for macOS',
        Platform.appStore => 'Download on the App Store',
        Platform.playStore => 'Get it on Google Play',
        Platform.android => 'Download APK',
      };

  IconData get icon => switch (this) {
        Platform.windows => Icons.window_rounded,
        Platform.macOS => Icons.apple,
        Platform.appStore => Icons.apple,
        Platform.playStore => Icons.shop_rounded,
        Platform.android => Icons.android_rounded,
      };

  /// Names the app in the call to action, e.g. "Download DataHop for macOS".
  String ctaLabelFor(String product) => switch (this) {
        Platform.windows => 'Download $product for Windows',
        Platform.macOS => 'Download $product for Mac',
        Platform.appStore => 'Get $product on the App Store',
        Platform.playStore => 'Get $product on Google Play',
        Platform.android => 'Download $product APK',
      };

  /// Store links leave the site; direct binaries do not.
  bool get isStore => this == Platform.appStore || this == Platform.playStore;
}

class Build {
  const Build({
    required this.platform,
    required this.url,
    this.size,
    this.requirements,
  });

  final Platform platform;
  final String url;

  /// Human-readable file size. Null for store links.
  final String? size;

  /// Minimum OS, shown under the download button.
  final String? requirements;
}

class ProductFeatureItem {
  const ProductFeatureItem(this.title, this.description, this.icon);
  final String title;
  final String description;
  final IconData icon;
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.route,
    required this.iconAsset,
    required this.version,
    required this.builds,
    required this.features,
    this.screenshots = const [],
    this.accent = const Color(0xFF4D8DFF),
    this.releasedOn,
    this.supportEmail,
  });

  final String id;
  final String name;

  /// One line, shown on cards and under the hero title.
  final String tagline;
  final String description;
  final String route;

  /// Real app icon extracted from the shipped app or the App Store listing.
  final String iconAsset;
  final String version;
  final List<Build> builds;
  final List<ProductFeatureItem> features;
  final List<String> screenshots;

  /// Per-product tint, used for the card glow and icon halo.
  final Color accent;
  final String? releasedOn;

  /// Shown as a "Need help?" contact on the product page when set — for
  /// apps whose store listing points its Support URL at this page, so the
  /// page has to carry real contact info on its own.
  final String? supportEmail;

  Build? buildFor(Platform p) {
    for (final b in builds) {
      if (b.platform == p) return b;
    }
    return null;
  }

  bool get isDesktop =>
      buildFor(Platform.windows) != null || buildFor(Platform.macOS) != null;

  /// Primary screenshot for hero and card art, if the product has one.
  String? get heroShot => screenshots.isEmpty ? null : screenshots.first;
}

/// Every downloadable ASOLTU product, in the order they appear on the site.
///
/// This is the only place release URLs, versions and sizes live — the
/// downloads page, the product pages and the homepage all read from here.
const List<Product> kProducts = [
  Product(
    id: 'datahop',
    name: 'DataHop',
    tagline: 'Send files device to device. No cloud, no accounts.',
    description:
        'DataHop opens an encrypted WebRTC channel straight between two devices. '
        'Your files never touch a server, there is no size limit, and nobody has '
        'to sign up for anything.',
    route: '/software/datahop',
    iconAsset: 'assets/icons/products/datahop.png',
    version: '1.0.0',
    accent: Color(0xFF3DD68C),
    // TODO: needs real captures — the datahop_* assets are empty mockups.
    screenshots: [],
    builds: [
      Build(
        platform: Platform.windows,
        url: '/releases/DataHop-Windows-Setup.exe',
        size: '125 MB',
        requirements: 'Windows 10 or later, 64-bit',
      ),
      Build(
        platform: Platform.macOS,
        url: '/releases/DataHop-Mac-Installer.dmg',
        size: '156 MB',
        requirements: 'macOS 11 Big Sur or later',
      ),
    ],
    features: [
      ProductFeatureItem(
        'End-to-end encrypted',
        'Files move directly between devices. They never reach our servers.',
        Icons.lock_rounded,
      ),
      ProductFeatureItem(
        'No size limit',
        'Send a 40 GB folder as easily as a screenshot. No upload, no queue.',
        Icons.all_inclusive_rounded,
      ),
      ProductFeatureItem(
        'Finds nearby devices',
        'Peers on the same network pair automatically, or scan a QR code.',
        Icons.radar_rounded,
      ),
    ],
  ),
  Product(
    id: 'download-manager',
    name: 'Download Manager',
    tagline: 'Saturate your connection. Survive any crash.',
    description:
        'A Rust download engine that splits every file across parallel streams '
        'and checkpoints as it goes. Pull the plug mid-download and it picks up '
        'exactly where it stopped.',
    route: '/software/download-manager',
    iconAsset: 'assets/icons/products/download-manager.png',
    version: '1.0.0',
    accent: Color(0xFF4D8DFF),
    // TODO: needs real captures — the adm_* assets are empty window mockups.
    screenshots: [],
    builds: [
      Build(
        platform: Platform.windows,
        url: '/releases/Asoltu-Download-Manager-Setup-1.0.0.exe',
        size: '74 MB',
        requirements: 'Windows 10 or later, 64-bit',
      ),
      Build(
        platform: Platform.macOS,
        url: '/releases/Asoltu-Download-Manager-1.0.0.dmg',
        size: '5.5 MB',
        requirements: 'macOS 11 Big Sur or later',
      ),
    ],
    features: [
      ProductFeatureItem(
        'Rust engine',
        'Memory-safe and highly concurrent, so network I/O is never the bottleneck.',
        Icons.memory_rounded,
      ),
      ProductFeatureItem(
        'Segmented downloads',
        'Every file is split across parallel HTTP streams to max out your line.',
        Icons.call_split_rounded,
      ),
      ProductFeatureItem(
        'Crash-safe resume',
        'A power cut or a dropped connection costs you nothing. Resume and continue.',
        Icons.restore_rounded,
      ),
    ],
  ),
  Product(
    id: 'asoltu-remote',
    name: 'AsoltuRemote',
    tagline: 'Your desktop, from anywhere, in under a megabyte.',
    description:
        'A tiny desktop agent for Windows and macOS plus an iOS client. '
        'Low-latency control, secure signalling, and file transfer between the '
        'machines you actually use.',
    route: '/software/asoltu-remote',
    iconAsset: 'assets/icons/products/asoltu-remote.png',
    version: '1.0.0',
    accent: Color(0xFF9B7CFF),
    // TODO: needs real captures — remote_1/2 are a personal desktop capture
    // and remote_3 is blank.
    screenshots: [],
    builds: [
      Build(
        platform: Platform.windows,
        url: '/releases/AsoltuRemote-Setup.exe',
        size: '856 KB',
        requirements: 'Windows 10 or later, 64-bit',
      ),
      Build(
        platform: Platform.macOS,
        url: '/releases/AsoltuRemote-Mac.zip',
        size: '781 KB',
        requirements: 'macOS 11 Big Sur or later',
      ),
    ],
    features: [
      ProductFeatureItem(
        'Low-latency control',
        'Mouse and keyboard input translated across platforms without the lag.',
        Icons.mouse_rounded,
      ),
      ProductFeatureItem(
        'File transfer built in',
        'Move files between host and client without a second tool.',
        Icons.swap_horiz_rounded,
      ),
      ProductFeatureItem(
        'Device ID and password',
        'Authenticated over secure signalling servers. Nothing is left open.',
        Icons.shield_rounded,
      ),
    ],
  ),
  Product(
    id: 'pdf-o',
    name: 'PDF-O',
    tagline: 'Scan, edit and compress documents on your iPhone.',
    description:
        'Turn your camera into a scanner, run OCR over what you capture, then '
        'edit, sign and compress the result — all on device.',
    route: '/software/pdf-o',
    iconAsset: 'assets/icons/products/pdfo.jpg',
    version: '1.1.2',
    accent: Color(0xFFFF6B57),
    screenshots: [
      'assets/images/products/pdfo_1.png',
      'assets/images/products/pdfo_2.png',
    ],
    builds: [
      Build(
        platform: Platform.appStore,
        url: 'https://apps.apple.com/in/app/pdf-o/id6797936978',
        requirements: 'iPhone and iPad, iOS 15 or later',
      ),
    ],
    features: [
      ProductFeatureItem(
        'OCR that reads anything',
        'Search inside a scanned page the moment you capture it.',
        Icons.document_scanner_rounded,
      ),
      ProductFeatureItem(
        'Real compression',
        'Cut a 40 MB scan down to a few megabytes without turning it to mush.',
        Icons.compress_rounded,
      ),
      ProductFeatureItem(
        'Edit and sign',
        'Reorder pages, annotate, and drop in a signature before you send.',
        Icons.draw_rounded,
      ),
    ],
  ),
  Product(
    id: 'i2droid',
    name: 'i2Droid',
    tagline: 'Bridge your iPhone and your Android devices.',
    description:
        'The Hopp project. Move files and data across the ecosystem boundary '
        'over your local network, without a cloud round-trip in the middle.',
    route: '/software/i2droid',
    iconAsset: 'assets/icons/products/i2droid.jpg',
    version: '1.0',
    accent: Color(0xFF3DD68C),
    screenshots: [
      'assets/images/products/hopp_1.png',
      'assets/images/products/hopp_2.png',
    ],
    builds: [
      Build(
        platform: Platform.appStore,
        url: 'https://apps.apple.com/in/app/i2droid/id6803780035',
        requirements: 'iPhone and iPad, iOS 15 or later',
      ),
    ],
    features: [
      ProductFeatureItem(
        'Cross-ecosystem transfer',
        'iPhone to Android and back, without emailing files to yourself.',
        Icons.sync_alt_rounded,
      ),
      ProductFeatureItem(
        'Stays on your network',
        'Local transfers that never leave the room, let alone the country.',
        Icons.wifi_rounded,
      ),
    ],
  ),
  Product(
    id: 'asoltu-app',
    name: 'Asoltu',
    tagline: 'Every Indian competitive exam, practised in one app.',
    description:
        'Chapterwise and full-length mock tests for RPSC, REET, SSC, UPSC and '
        'ICAI, with the most secure live test system we have built.',
    route: '/education/asoltu-app',
    iconAsset: 'assets/icons/products/asoltu.jpg',
    version: '1.4.17',
    accent: Color(0xFFF5B21A),
    screenshots: [
      'assets/images/products/asoltu_app_1.jpg',
      'assets/images/products/asoltu_app_2.jpg',
      'assets/images/products/asoltu_app_3.jpg',
      'assets/images/products/asoltu_app_4.jpg',
    ],
    builds: [
      Build(
        platform: Platform.appStore,
        url: 'https://apps.apple.com/in/app/asoltu/id6796294470',
        requirements: 'iPhone and iPad, iOS 15 or later',
      ),
      Build(
        platform: Platform.playStore,
        url:
            'https://play.google.com/store/apps/details?id=com.absolutetutorials.app',
        requirements: 'Android 8.0 or later',
      ),
    ],
    features: [
      ProductFeatureItem(
        'Secure live tests',
        'Real exam conditions, with the anti-cheat that live testing needs.',
        Icons.verified_user_rounded,
      ),
      ProductFeatureItem(
        'Track every attempt',
        'Scores, accuracy and completion, subject by subject, over time.',
        Icons.trending_up_rounded,
      ),
    ],
  ),
];

/// Khata-Bahi — not in [kProducts] on purpose. It has no `builds` yet
/// (the App Store listing is still in review), and every card grid, the
/// nav dropdown and the downloads page assume every catalogue product has
/// at least one build to offer. This page exists only so the App Store
/// Connect "Support URL" for the listing has somewhere real to land, with
/// contact info a reviewer or user can actually use — add it to
/// [kProducts] once the listing is live and a store `Build` exists.
const kKhataBahiProduct = Product(
  id: 'khata-bahi',
  name: 'Khata-Bahi',
  tagline: 'GST billing, khata, stock and accounts for Indian shops.',
  description:
      'Create GST tax invoices in seconds, keep customer and supplier khata '
      '(udhaar), track stock, record expenses, and post proper double-entry '
      'vouchers — Day Book, Cash Book, ledgers, trial balance, P&L and '
      'balance sheet. Built for Indian kirana stores, traders and small '
      'businesses, in Hindi and English.',
  route: '/software/khata-bahi',
  iconAsset: 'assets/icons/products/khata-bahi.png',
  version: '1.0.0',
  accent: Color(0xFF3F51B5),
  screenshots: [
    'assets/images/products/khata_bahi_1.png',
    'assets/images/products/khata_bahi_2.png',
    'assets/images/products/khata_bahi_3.png',
  ],
  builds: [],
  supportEmail: 'support@asoltu.com',
  features: [
    ProductFeatureItem(
      'GST invoices, done right',
      'CGST / SGST, HSN codes and outstanding balances on every bill.',
      Icons.receipt_long_rounded,
    ),
    ProductFeatureItem(
      'Party khata',
      'Who will give, who will get — customer and supplier ledgers at a glance.',
      Icons.menu_book_rounded,
    ),
    ProductFeatureItem(
      'Double-entry books',
      'Day Book, Cash Book, trial balance, P&L and balance sheet — kept automatically.',
      Icons.account_balance_rounded,
    ),
  ],
);

Product? productById(String id) {
  for (final p in kProducts) {
    if (p.id == id) return p;
  }
  return null;
}

/// Desktop products, in homepage order.
List<Product> get desktopProducts =>
    kProducts.where((p) => p.isDesktop).toList();

/// Mobile-only products.
List<Product> get mobileProducts =>
    kProducts.where((p) => !p.isDesktop).toList();
