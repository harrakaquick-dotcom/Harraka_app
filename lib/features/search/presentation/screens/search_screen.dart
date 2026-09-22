import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';

class _Suggestion {
  const _Suggestion(this.label, this.sub);
  final String label;
  final String sub;
}

const _suggestions = [
  _Suggestion('Alphonso mangoes', 'in Fruits · 9 min'),
  _Suggestion('Mango milkshake', 'in Beverages · 11 min'),
  _Suggestion('Mango pickle', 'in Staples · 12 min'),
  _Suggestion('Aam papad', 'in Snacks · 8 min'),
];

const _trending = ['Cold brew', 'Curd 400g', 'Bananas', 'Bread', 'Paneer', 'Ice cream'];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController(text: 'mango');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_Suggestion> get _matches {
    final q = _controller.text.trim().toLowerCase();
    if (q.isEmpty) return _suggestions;
    return _suggestions.where((s) => s.label.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final matches = _matches;
    final showEmpty = _controller.text.trim().isNotEmpty && matches.isEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Padding(
                      padding: EdgeInsets.all(AppSpacing.xs),
                      child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              onChanged: (_) => setState(() {}),
                              style: AppTextStyles.bodyMedium,
                              decoration: const InputDecoration(
                                isCollapsed: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: showEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: 60),
                      child: Column(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryLight,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.search_off, color: AppColors.primaryDark, size: 36),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'No results for "${_controller.text.trim()}"',
                            style: AppTextStyles.headingMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Check the spelling or try a related item. We restock most SKUs every 4 hours.',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                            onPressed: () => Navigator.of(context).pushNamed(RouteNames.category),
                            child: const Text('Browse categories'),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SUGGESTIONS',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                          ...matches.map(
                            (s) => InkWell(
                              onTap: () => Navigator.of(context).pushNamed(RouteNames.productDetails, arguments: 'p2'),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        color: AppColors.surface,
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(s.label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                          Text(s.sub, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.north_west, size: 16, color: AppColors.textDisabled),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'TRENDING IN INDIRANAGAR',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Wrap(
                            spacing: AppSpacing.sm,
                            runSpacing: AppSpacing.sm,
                            children: _trending.map((label) {
                              return InkWell(
                                onTap: () => Navigator.of(context).pushNamed(RouteNames.category),
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    label,
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.primaryDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
