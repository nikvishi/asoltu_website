import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_urls.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_shadows.dart';
import '../../analytics/analytics_hooks.dart';

/// Bottom-right animated contact FABs: WhatsApp, Call, Email.
class FloatingContactBar extends StatefulWidget {
  const FloatingContactBar({super.key});

  @override
  State<FloatingContactBar> createState() => _FloatingContactBarState();
}

class _FloatingContactBarState extends State<FloatingContactBar>
    with SingleTickerProviderStateMixin {
  bool _open = false;

  static const _whatsApp = AppUrls.whatsApp;
  static const _phone = AppUrls.phoneTel;
  static const _email = AppUrls.salesEmail;

  Future<void> _launch(String url, String name) async {
    AnalyticsHooks.trackCtaClick(name);
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_open) ...[
            _FabAction(
              tooltip: 'WhatsApp',
              icon: Icons.chat_rounded,
              color: const Color(0xFF25D366),
              onTap: () => _launch(_whatsApp, 'whatsapp'),
            ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.3, end: 0),
            const SizedBox(height: 10),
            _FabAction(
              tooltip: 'Call',
              icon: Icons.call_rounded,
              color: AppColors.accentBlue,
              onTap: () => _launch(_phone, 'call'),
            ).animate().fadeIn(delay: 40.ms, duration: 200.ms).slideY(begin: 0.3, end: 0),
            const SizedBox(height: 10),
            _FabAction(
              tooltip: 'Email',
              icon: Icons.email_rounded,
              color: AppColors.brandNavy,
              onTap: () => _launch(_email, 'email'),
            ).animate().fadeIn(delay: 80.ms, duration: 200.ms).slideY(begin: 0.3, end: 0),
            const SizedBox(height: 12),
          ],
          FloatingActionButton(
            heroTag: 'asoltu_contact_fab',
            backgroundColor: AppColors.accentBlue,
            foregroundColor: Colors.white,
            elevation: 3,
            onPressed: () => setState(() => _open = !_open),
            tooltip: _open ? 'Close contact options' : 'Contact us',
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _open ? Icons.close_rounded : Icons.support_agent_rounded,
                key: ValueKey(_open),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FabAction extends StatelessWidget {
  const _FabAction({
    required this.tooltip,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String tooltip;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        side: BorderSide(color: AppColors.borderLight),
      ),
      shadowColor: AppColors.brandNavy.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            boxShadow: AppShadows.soft,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                tooltip,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.brandNavy,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
