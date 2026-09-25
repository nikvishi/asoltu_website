import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/products.dart';
import '../../theme/theme_manager.dart';
import '../../utils/host_platform.dart';

Future<void> _open(Build build) async {
  final uri = Uri.parse(build.url);
  await launchUrl(
    uri,
    // Store links open in a new tab; a direct binary must stay in this one so
    // the browser starts the download instead of opening a blank window.
    webOnlyWindowName: build.platform.isStore ? '_blank' : '_self',
  );
}

/// Big filled call to action for one build.
class DownloadButton extends StatefulWidget {
  const DownloadButton({
    super.key,
    required this.product,
    required this.build,
    this.compact = false,
    this.expand = false,
    this.productNameInLabel = false,
  });

  final Product product;
  final Build build;

  /// Smaller padding and type, for use inside cards.
  final bool compact;
  final bool expand;

  /// Names the app in the button ("Download DataHop for macOS") instead of the
  /// platform alone, so a visitor is never told to download an unnamed file.
  final bool productNameInLabel;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final b = widget.build;
    final size = b.size;
    final label = widget.compact
        ? b.platform.label
        : widget.productNameInLabel
        ? b.platform.ctaLabelFor(widget.product.name)
        : b.platform.ctaLabel;

    return LayoutBuilder(
      builder: (context, constraints) {
        final showSize =
            size != null && !widget.compact && constraints.maxWidth > 360;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: () => _open(b),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
              padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? 18 : 28,
                vertical: widget.compact ? 12 : 17,
              ),
              decoration: BoxDecoration(
                gradient: context.accentGradient,
                borderRadius: BorderRadius.circular(widget.compact ? 10 : 12),
                boxShadow: [
                  BoxShadow(
                    color: context.primaryAccent.withValues(
                      alpha: _hovered ? 0.45 : 0.28,
                    ),
                    blurRadius: _hovered ? 28 : 18,
                    offset: Offset(0, _hovered ? 10 : 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: widget.expand
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    b.platform.icon,
                    color: Colors.white,
                    size: widget.compact ? 17 : 20,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: widget.compact ? 14 : 16,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ),
                  if (showSize) ...[
                    const SizedBox(width: 10),
                    Text(
                      size,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.72),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Quieter variant, for the builds the visitor's OS cannot run.
class SecondaryDownloadLink extends StatefulWidget {
  const SecondaryDownloadLink({super.key, required this.build});

  final Build build;

  @override
  State<SecondaryDownloadLink> createState() => _SecondaryDownloadLinkState();
}

class _SecondaryDownloadLinkState extends State<SecondaryDownloadLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final b = widget.build;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _open(b),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                b.platform.icon,
                size: 15,
                color: _hovered ? context.textPrimary : context.textMuted,
              ),
              const SizedBox(width: 7),
              Text(
                b.size == null
                    ? b.platform.label
                    : '${b.platform.label} · ${b.size}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hovered ? context.textPrimary : context.textMuted,
                  decoration: _hovered
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: context.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Leads with the build matching the visitor's OS and demotes the rest.
///
/// When the OS cannot be detected (or the product has no build for it) every
/// build is offered with equal weight instead.
class SmartDownloadCta extends StatelessWidget {
  const SmartDownloadCta({
    super.key,
    required this.product,
    this.alignment = WrapAlignment.center,
    this.productNameInLabel = false,
  });

  final Product product;
  final WrapAlignment alignment;

  /// Passed through to the primary button. See [DownloadButton].
  final bool productNameInLabel;

  @override
  Widget build(BuildContext context) {
    if (product.builds.isEmpty) {
      // Not released yet — an empty button row here would read as broken
      // rather than as "coming soon".
      return Text(
        'Coming soon',
        textAlign: switch (alignment) {
          WrapAlignment.start => TextAlign.start,
          WrapAlignment.end => TextAlign.end,
          _ => TextAlign.center,
        },
        style: TextStyle(
          color: context.textMuted,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    final host = detectHostPlatform();
    final primary = host == null ? null : product.buildFor(host);
    final others = product.builds
        .where((b) => b != primary)
        .toList(growable: false);

    if (primary == null) {
      return Wrap(
        alignment: alignment,
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final b in product.builds)
            DownloadButton(
              product: product,
              build: b,
              productNameInLabel: productNameInLabel,
            ),
        ],
      );
    }

    final crossAxis = switch (alignment) {
      WrapAlignment.start => CrossAxisAlignment.start,
      WrapAlignment.end => CrossAxisAlignment.end,
      _ => CrossAxisAlignment.center,
    };

    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        DownloadButton(
          product: product,
          build: primary,
          productNameInLabel: productNameInLabel,
        ),
        if (primary.requirements != null) ...[
          const SizedBox(height: 10),
          Text(
            // The button already carries the size on wide layouts; repeating it
            // here just read as clutter.
            primary.requirements!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: context.textMuted),
          ),
        ],
        if (others.isNotEmpty) ...[
          const SizedBox(height: 6),
          Wrap(
            alignment: alignment,
            children: [for (final b in others) SecondaryDownloadLink(build: b)],
          ),
        ],
      ],
    );
  }
}
