import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';

class _Notif {
  const _Notif({required this.title, required this.body, required this.time, required this.unread});
  final String title;
  final String body;
  final String time;
  final bool unread;
}

const _notifs = [
  _Notif(
    title: 'Rohit is 2 minutes away',
    body: 'Order #HQ-48213 · keep your phone handy.',
    time: 'Just now',
    unread: true,
  ),
  _Notif(
    title: '₹50 off your next order',
    body: 'FRESH50 is back for the weekend, min order ₹299.',
    time: '2 h ago',
    unread: true,
  ),
  _Notif(
    title: 'Refund settled',
    body: '₹89 for the missing egg tray is back in your wallet.',
    time: 'Yesterday',
    unread: false,
  ),
  _Notif(
    title: 'Mango season starts today',
    body: 'Ratnagiri Alphonso, delivered in 10 minutes.',
    time: '2 d ago',
    unread: false,
  ),
];

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Padding(
                      padding: EdgeInsets.only(right: AppSpacing.sm),
                      child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                    ),
                  ),
                  Expanded(child: Text('Notifications', style: AppTextStyles.headingMedium)),
                  Text(
                    'Mark all read',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: _notifs.length,
                separatorBuilder: (_, _) => const Divider(height: 1, color: AppColors.border),
                itemBuilder: (context, i) {
                  final n = _notifs[i];
                  return Container(
                    color: n.unread ? const Color(0xFFFFFBFA) : Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.notifications, size: 16, color: AppColors.primary),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(n.title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              Text(n.body, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                              const SizedBox(height: 3),
                              Text(n.time, style: AppTextStyles.caption.copyWith(color: AppColors.textDisabled)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
