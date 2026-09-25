import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_urls.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/form_validators.dart';
import '../../../core/widgets/widgets.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  String _category = 'All';
  final _email = TextEditingController();
  bool _subscribed = false;

  /// SEO-ready blog taxonomy (categories for discovery + internal linking).
  static const _categories = [
    'All',
    'School ERP',
    'Education',
    'Technology',
    'AI',
    'Software Development',
    'Cloud',
  ];

  static const _posts = <(String, String, String, String, String)>[
    (
      'Featured',
      'School ERP',
      'How modern School ERP software replaces spreadsheet chaos',
      'A practical look at unifying admissions, fees, attendance and parent communication on one student management system of record.',
      '12 min read',
    ),
    (
      'Article',
      'Education',
      'Five fee-collection habits that improve every term',
      'Process patterns finance teams can adopt without pressuring families unfairly — with school administration software support.',
      '6 min read',
    ),
    (
      'Article',
      'AI',
      'AI reports principals actually use',
      'How to demand decision-ready AI solutions instead of decorative dashboards in school management software.',
      '7 min read',
    ),
    (
      'Article',
      'Education',
      'What school leaders want from digital transformation',
      'Reliability, parent trust and staff adoption — beyond shiny portals for CBSE and RBSE schools.',
      '8 min read',
    ),
    (
      'Article',
      'Technology',
      'Why multi-tenant design matters for education groups',
      'Isolation, scale and operational clarity when you run more than one campus on cloud School ERP.',
      '9 min read',
    ),
    (
      'Article',
      'Cloud',
      'Cloud solutions for school automation in India',
      'How secure cloud infrastructure supports multi-campus School ERP, backups and remote access.',
      '5 min read',
    ),
    (
      'Article',
      'Education',
      'Attendance discipline that parents can trust',
      'Daily habits and school automation software patterns that reduce absence blind spots.',
      '6 min read',
    ),
    (
      'Article',
      'Software Development',
      'Flutter app development for parent and teacher portals',
      'Why stakeholder mobile experiences succeed only when modules share one truth with the core ERP.',
      '7 min read',
    ),
  ];

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  List<(String, String, String, String, String)> get _filtered {
    if (_category == 'All') return _posts;
    return _posts.where((p) => p.$2 == _category).toList();
  }

  @override
  Widget build(BuildContext context) {
    final featured = _posts.first;
    final list = _filtered.where((p) => p != featured || _category != 'All').toList();

    return Column(
      children: [
        PageSection(
          padding: const EdgeInsets.fromLTRB(0, 36, 0, 12),
          child: const FadeIn(
            child: Column(
              children: [
                PageBreadcrumb(current: 'Blog'),
                SizedBox(height: 20),
                SectionHeading(
                  eyebrow: 'Blog',
                  title: 'School ERP & technology insights',
                  subtitle:
                      'Topics we write about: School ERP, Education Technology, AI in Education, School Automation, Flutter, Cloud, Software Development and Business Automation. Full articles publish here as they are authored.',
                  center: true,
                ),
              ],
            ),
          ),
        ),
        PageSection(
          padding: const EdgeInsets.only(bottom: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final c in _categories) ...[
                  FilterChip(
                    label: Text(c),
                    selected: _category == c,
                    onSelected: (_) => setState(() => _category = c),
                    selectedColor: AppColors.accentBlue.withValues(alpha: 0.15),
                    checkmarkColor: AppColors.accentBlue,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _category == c
                          ? AppColors.brandNavy
                          : AppColors.textSecondary,
                    ),
                    side: BorderSide(
                      color: _category == c
                          ? AppColors.accentBlue.withValues(alpha: 0.4)
                          : AppColors.borderLight,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ),
        if (_category == 'All' || featured.$2 == _category)
          PageSection(
            child: _Featured(
              category: featured.$2,
              title: featured.$3,
              body: featured.$4,
              readTime: featured.$5,
            ),
          ),
        PageSection(
          backgroundColor: AppColors.surfaceMuted,
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Articles',
                title: 'From the ASOLTU desk',
                center: true,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 1000 ? 3 : c.maxWidth >= 680 ? 2 : 1;
                  final items = list.isEmpty ? _filtered : list;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: cols == 1 ? 1.65 : 1.12,
                    ),
                    itemBuilder: (context, i) {
                      final p = items[i];
                      return _PostCard(
                        category: p.$2,
                        title: p.$3,
                        body: p.$4,
                        readTime: p.$5,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        PageSection(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.brandNavy,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.hover,
            ),
            child: Column(
              children: [
                const Text(
                  'NEWSLETTER',
                  style: TextStyle(
                    color: AppColors.accentGold,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'School operations insights in your inbox',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Product updates and leadership-friendly guides. No spam.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                if (_subscribed)
                  const Text(
                    'Thanks — you are on the list.',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  )
                else
                  LayoutBuilder(
                    builder: (context, c) {
                      final wide = c.maxWidth > 520;
                      final field = TextFormField(
                        controller: _email,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Work email',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                      final button = AsoltuButton(
                        label: 'Subscribe',
                        onPressed: () {
                          final err = FormValidators.email(_email.text);
                          if (err != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(err)),
                            );
                            return;
                          }
                          setState(() => _subscribed = true);
                        },
                      );
                      if (wide) {
                        return Row(
                          children: [
                            Expanded(child: field),
                            const SizedBox(width: 12),
                            button,
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [field, const SizedBox(height: 12), button],
                      );
                    },
                  ),
                TextButton(
                  onPressed: () => launchUrl(Uri.parse(AppUrls.salesEmail)),
                  child: const Text(
                    'Prefer email? info@asoltu.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Featured extends StatelessWidget {
  const _Featured({
    required this.category,
    required this.title,
    required this.body,
    required this.readTime,
  });

  final String category;
  final String title;
  final String body;
  final String readTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          colors: [
            AppColors.brandNavy,
            AppColors.accentBlue.withValues(alpha: 0.9),
          ],
        ),
        boxShadow: AppShadows.hover,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FEATURED · $category',
            style: const TextStyle(
              color: AppColors.accentGold,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          Text(body, style: const TextStyle(color: Colors.white70, height: 1.5)),
          const SizedBox(height: 10),
          Text(readTime, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 18),
          AsoltuButton(
            label: 'Discuss with our team',
            onPressed: () => context.go(AppRoutes.contact),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    required this.category,
    required this.title,
    required this.body,
    required this.readTime,
  });

  final String category;
  final String title;
  final String body;
  final String readTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: AppColors.accentBlue,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.brandNavy,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Expanded(child: Text(body)),
          Row(
            children: [
              Text(
                readTime,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.go(AppRoutes.contact),
                child: const Text('Talk to us →'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
