import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class _PayMethod {
  const _PayMethod({required this.id, required this.short, required this.label, required this.sub, this.subColor});
  final String id;
  final String short;
  final String label;
  final String sub;
  final Color? subColor;
}

const _payMethods = [
  _PayMethod(id: 'upi', short: 'UPI', label: 'UPI · Pay by any app', sub: 'Instant, no charges', subColor: AppColors.secondary),
  _PayMethod(id: 'card', short: 'CARD', label: 'Card ending 4421', sub: 'HDFC Debit'),
  _PayMethod(id: 'wallet', short: 'WLT', label: 'Harraka Wallet', sub: 'Balance ₹340'),
  _PayMethod(id: 'pod', short: 'POD', label: 'Pay on delivery', sub: 'Cash or UPI at door'),
];

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  String _selected = 'upi';
  bool _placed = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final itemTotal = notifier.itemTotal;
    final delivery = itemTotal >= 199 ? 0 : 25;
    final coupon = itemTotal > 0 ? 50 : 0;
    final grandTotal = (itemTotal + delivery + 9 - coupon).clamp(0, 1 << 30);
    final payLabel = _payMethods.firstWhere((m) => m.id == _selected).label;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment', style: AppTextStyles.headingMedium),
                      Text('Paying ₹$grandTotal', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: _placed
                    ? _OrderPlaced(
                        grandTotal: grandTotal,
                        payLabel: payLabel,
                        onTrack: () => Navigator.of(context).pushNamed(RouteNames.orderTracking),
                      )
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(AppRadius.medium),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                            child: Column(
                              children: _payMethods.map((m) {
                                final on = m.id == _selected;
                                return InkWell(
                                  onTap: () => setState(() => _selected = m.id),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 38,
                                          height: 38,
                                          decoration: BoxDecoration(
                                            color: on ? AppColors.primary : AppColors.primaryLight,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            m.short,
                                            style: AppTextStyles.caption.copyWith(
                                              color: on ? Colors.white : AppColors.primaryDark,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(m.label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                              Text(
                                                m.sub,
                                                style: AppTextStyles.caption.copyWith(color: m.subColor ?? AppColors.textSecondary),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          on ? Icons.radio_button_checked : Icons.radio_button_off,
                                          color: on ? AppColors.primary : AppColors.border,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(AppRadius.medium),
                            ),
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Item total', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                                    Text('₹$itemTotal', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Savings applied', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                                    Text('− ₹$coupon', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                const Divider(height: AppSpacing.md, color: AppColors.border),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('To pay', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w800)),
                                    Text('₹$grandTotal', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              const Icon(Icons.shield_outlined, size: 16, color: AppColors.textSecondary),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  'Payments secured, refunds within 24 hours',
                                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _placed ? AppColors.secondary : AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.medium)),
                  ),
                  onPressed: _placed ? null : () => setState(() => _placed = true),
                  child: Text(_placed ? 'Order confirmed ✓' : 'Pay ₹$grandTotal'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderPlaced extends StatelessWidget {
  const _OrderPlaced({required this.grandTotal, required this.payLabel, required this.onTrack});

  final int grandTotal;
  final String payLabel;
  final VoidCallback onTrack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl, horizontal: AppSpacing.md),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white, size: 30),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Order placed', style: AppTextStyles.headingMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '₹$grandTotal paid via $payLabel.\nRider assigned, arriving in 9 minutes.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: 0.38,
              minHeight: 6,
              backgroundColor: AppColors.secondaryLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Packed', style: AppTextStyles.caption.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
              Text('Out for delivery', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              Text('At your door', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: onTrack,
            child: Text(
              'Track order →',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
