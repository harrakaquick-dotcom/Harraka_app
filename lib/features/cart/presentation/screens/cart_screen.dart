import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/product_image_placeholder.dart';
import '../../../home/data/sample_catalog.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);

    final itemTotal = notifier.itemTotal;
    final mrpTotal = notifier.mrpTotal;
    final delivery = itemTotal >= 199 ? 0 : 25;
    const handling = 9;
    final coupon = itemTotal > 0 ? 50 : 0;
    final grandTotal = (itemTotal + delivery + handling - coupon).clamp(0, 1 << 30);
    final savings = mrpTotal - itemTotal + coupon + (itemTotal >= 199 ? 25 : 0);

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
                      Text('Your cart', style: AppTextStyles.headingMedium),
                      Text(
                        'Arriving in 9 minutes',
                        style: AppTextStyles.caption.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: cart.isEmpty
                  ? Center(
                      child: Text(
                        'Your cart is empty',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(AppRadius.medium),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                            child: Column(
                              children: [
                                ...cart.entries.map((e) {
                                  final product = productById(e.key);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 52,
                                          height: 52,
                                          child: ProductImagePlaceholder(),
                                        ),
                                        const SizedBox(width: AppSpacing.sm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(product.name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                              Text(product.pack, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                              Text(
                                                '₹${product.price * e.value}',
                                                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                        ),
                                        _Stepper(
                                          qty: e.value,
                                          onInc: () => notifier.add(e.key, 1),
                                          onDec: () => notifier.add(e.key, -1),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                InkWell(
                                  onTap: () => Navigator.of(context).pushNamed(RouteNames.home),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '+ Add more items',
                                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              border: Border.all(color: const Color(0xFFF6D3CA)),
                              borderRadius: BorderRadius.circular(AppRadius.medium),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'FRESH50 applied',
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '− ₹$coupon',
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w800),
                                ),
                              ],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bill details', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                                const SizedBox(height: AppSpacing.xs),
                                _BillRow('Item total', '₹$itemTotal', AppColors.textPrimary),
                                _BillRow('Delivery fee', delivery == 0 ? 'FREE' : '₹$delivery', delivery == 0 ? AppColors.secondary : AppColors.textPrimary),
                                _BillRow('Handling charge', '₹$handling', AppColors.textPrimary),
                                _BillRow('Coupon FRESH50', '− ₹$coupon', AppColors.secondary),
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
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(AppRadius.medium),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Deliver to Home', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                                    Text('Flat 21, Sunrise Residency', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => Navigator.of(context).pushNamed(RouteNames.addresses),
                                  child: Text(
                                    'Change',
                                    style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            if (cart.isNotEmpty)
              Container(
                padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('₹$grandTotal', style: AppTextStyles.headingMedium),
                        Text(
                          'You save ₹$savings',
                          style: AppTextStyles.caption.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: AppSpacing.lg),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.medium)),
                      ),
                      onPressed: () => Navigator.of(context).pushNamed(RouteNames.checkout),
                      child: const Text('Proceed to pay →'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BillRow extends StatelessWidget {
  const _BillRow(this.label, this.value, this.color);

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTextStyles.bodyMedium.copyWith(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.qty, required this.onInc, required this.onDec});

  final int qty;
  final VoidCallback onInc;
  final VoidCallback onDec;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDec,
            child: const SizedBox(width: 28, height: 30, child: Icon(Icons.remove, size: 16, color: AppColors.primary)),
          ),
          Container(
            width: 24,
            height: 30,
            color: AppColors.primary,
            alignment: Alignment.center,
            child: Text(
              '$qty',
              style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
          InkWell(
            onTap: onInc,
            child: const SizedBox(width: 28, height: 30, child: Icon(Icons.add, size: 16, color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
