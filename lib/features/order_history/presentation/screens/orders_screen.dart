import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';

class _Order {
  const _Order({
    required this.id,
    required this.date,
    required this.items,
    required this.status,
    required this.delivered,
    required this.summary,
    required this.total,
  });

  final String id;
  final String date;
  final String items;
  final String status;
  final bool delivered;
  final String summary;
  final String total;
}

const _orders = [
  _Order(
    id: '#HQ-48213',
    date: 'Today, 9:41 AM',
    items: '4 items',
    status: 'In transit',
    delivered: false,
    summary: 'Milk, brown eggs, atta, chips',
    total: '₹385',
  ),
  _Order(
    id: '#HQ-47980',
    date: 'Yesterday, 7:12 PM',
    items: '7 items',
    status: 'Delivered',
    delivered: true,
    summary: 'Curd, bananas, bread, cold brew, paneer',
    total: '₹742',
  ),
  _Order(
    id: '#HQ-47710',
    date: '6 Sep, 11:02 AM',
    items: '3 items',
    status: 'Delivered',
    delivered: true,
    summary: 'Mangoes, ice cream, chips',
    total: '₹318',
  ),
];

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Text('Your orders', style: AppTextStyles.headingMedium),
            ),
            Expanded(
              child: _orders.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: 70),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                            child: const Icon(Icons.receipt_long_outlined, color: AppColors.primaryDark, size: 40),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text('No orders yet', style: AppTextStyles.headingMedium),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Your first 10-minute delivery is one tap away.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: _orders.length,
                      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, i) {
                        final o = _orders[i];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(AppRadius.medium),
                          ),
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(o.id, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                                      Text(
                                        '${o.date} · ${o.items}',
                                        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: o.delivered ? AppColors.surface : AppColors.secondaryLight,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Text(
                                      o.status,
                                      style: AppTextStyles.caption.copyWith(
                                        color: o.delivered ? AppColors.textSecondary : AppColors.secondary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(o.summary, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                              const Divider(height: AppSpacing.md, color: AppColors.border),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(o.total, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w800)),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: AppColors.primary, width: 1.5),
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                                    ),
                                    onPressed: () => Navigator.of(context).pushNamed(
                                      o.delivered ? RouteNames.cart : RouteNames.orderTracking,
                                    ),
                                    child: Text(
                                      o.delivered ? 'Reorder' : 'Track',
                                      style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
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
