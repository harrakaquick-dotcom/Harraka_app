import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';

class _MenuItem {
  const _MenuItem(this.label, this.sub, this.route);
  final String label;
  final String sub;
  final String route;
}

const _menu = [
  _MenuItem('My orders', 'Track, reorder, invoices', RouteNames.orderHistory),
  _MenuItem('Saved addresses', 'Home, Work + 2 more', RouteNames.addresses),
  _MenuItem('Payment methods', 'UPI, 1 card, wallet', RouteNames.checkout),
  _MenuItem('Help & support', 'Chat with us, 24×7', RouteNames.support),
];

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final Map<String, bool> _toggles = {'notif': true, 'contactless': true, 'dark': false};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.primaryDark,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        'AR',
                        style: AppTextStyles.headingMedium.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Aarav Rathi', style: AppTextStyles.headingMedium.copyWith(color: Colors.white)),
                          Text(
                            '+91 98••• ••210 · Member since 2024',
                            style: AppTextStyles.caption.copyWith(color: AppColors.primaryLight),
                          ),
                        ],
                      ),
                    ),
                    Text('Edit', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryLight, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _StatCard(label: 'Orders', value: '42', color: AppColors.textPrimary),
                        const SizedBox(width: AppSpacing.sm),
                        _StatCard(label: 'Avg delivery', value: '9m', color: AppColors.secondary),
                        const SizedBox(width: AppSpacing.sm),
                        _StatCard(label: 'Saved', value: '₹2.4k', color: AppColors.primary),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Column(
                        children: _menu.map((m) {
                          return InkWell(
                            onTap: () => Navigator.of(context).pushNamed(m.route),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: const Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(m.label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                        Text(m.sub, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, size: 18, color: AppColors.textDisabled),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.sm),
                            child: Text('Settings', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                          ),
                          _toggleRow('notif', 'Order notifications', 'Rider updates and offers'),
                          _toggleRow('contactless', 'Contactless delivery', 'Leave at the door'),
                          _toggleRow('dark', 'Dark mode', 'Follows system by default'),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: Text(
                        'Log out',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleRow(String key, String label, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Text(sub, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Switch(
            value: _toggles[key]!,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.secondary,
            onChanged: (v) => setState(() => _toggles[key] = v),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Column(
          children: [
            Text(value, style: AppTextStyles.headingMedium.copyWith(color: color)),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
