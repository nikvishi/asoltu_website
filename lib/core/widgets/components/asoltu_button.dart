import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

enum AsoltuButtonVariant { primary, secondary, ghost, gold, navy }

/// Primary marketing CTA button with hover + keyboard focus affordances.
class AsoltuButton extends StatefulWidget {
  const AsoltuButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AsoltuButtonVariant.primary,
    this.icon,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AsoltuButtonVariant variant;
  final IconData? icon;
  final bool expanded;

  @override
  State<AsoltuButton> createState() => _AsoltuButtonState();
}

class _AsoltuButtonState extends State<AsoltuButton> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;

    late final Color bg;
    late final Color fg;
    late final Border? border;

    switch (widget.variant) {
      case AsoltuButtonVariant.primary:
        bg = _hovered ? AppColors.accentBlueLight : AppColors.accentBlue;
        fg = Colors.white;
        border = null;
      case AsoltuButtonVariant.navy:
        bg = _hovered ? AppColors.brandNavyLight : AppColors.brandNavy;
        fg = Colors.white;
        border = null;
      case AsoltuButtonVariant.secondary:
        bg = _hovered ? AppColors.surfaceMuted : Colors.transparent;
        fg = AppColors.brandNavy;
        border = Border.all(color: AppColors.brandNavy, width: 1.4);
      case AsoltuButtonVariant.ghost:
        bg = _hovered
            ? AppColors.brandNavy.withValues(alpha: 0.06)
            : Colors.transparent;
        fg = AppColors.brandNavy;
        border = null;
      case AsoltuButtonVariant.gold:
        bg = _hovered ? AppColors.accentGoldLight : AppColors.accentGold;
        fg = AppColors.textOnGold;
        border = null;
    }

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: enabled ? bg : bg.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: border,
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: AppColors.accentBlue.withValues(alpha: 0.35),
                  blurRadius: 0,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            Icon(widget.icon, size: 18, color: fg),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              widget.label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      child: FocusableActionDetector(
        enabled: enabled,
        onShowFocusHighlight: (v) => setState(() => _focused = v),
        onShowHoverHighlight: (v) => setState(() => _hovered = v),
        mouseCursor:
            enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onPressed?.call();
              return null;
            },
          ),
        },
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: GestureDetector(
          onTap: widget.onPressed,
          behavior: HitTestBehavior.opaque,
          child: child,
        ),
      ),
    );
  }
}
