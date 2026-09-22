import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/product_image_placeholder.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../home/data/sample_catalog.dart';

const _variants = [
  {'pack': '400 g', 'price': '₹139'},
  {'pack': '800 g', 'price': '₹249'},
  {'pack': '1.6 kg', 'price': '₹469'},
];

const _highlights = [
  ['Shelf life', '4–5 days'],
  ['Origin', 'Ratnagiri, MH'],
  ['Storage', 'Cool, dry place'],
  ['Returns', 'Instant refund'],
];

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int _variant = 1;

  @override
  Widget build(BuildContext context) {
    final product = productById(widget.productId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          height: 270,
                          width: double.infinity,
                          child: ProductImagePlaceholder(borderRadius: 0),
                        ),
                        Positioned(
                          top: 14,
                          left: 16,
                          child: InkWell(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(Icons.arrow_back, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  product.eta,
                                  style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                'In stock at Indiranagar store',
                                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(product.name, style: AppTextStyles.headingLarge),
                          const SizedBox(height: 4),
                          Text(product.pack, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text('₹${product.price}', style: AppTextStyles.headingLarge),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                '₹${product.mrp}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textDisabled,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                '${product.discountPercent}% off',
                                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: List.generate(_variants.length, (i) {
                              final on = i == _variant;
                              final v = _variants[i];
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: i == _variants.length - 1 ? 0 : AppSpacing.sm),
                                  child: InkWell(
                                    onTap: () => setState(() => _variant = i),
                                    borderRadius: BorderRadius.circular(AppRadius.medium),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                                      decoration: BoxDecoration(
                                        color: on ? AppColors.primaryLight : Colors.white,
                                        border: Border.all(color: on ? AppColors.primary : AppColors.border, width: 1.5),
                                        borderRadius: BorderRadius.circular(AppRadius.medium),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            v['pack']!,
                                            style: AppTextStyles.caption.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: on ? AppColors.primaryDark : AppColors.textPrimary,
                                            ),
                                          ),
                                          Text(
                                            v['price']!,
                                            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              border: Border.all(color: const Color(0xFFF6D3CA)),
                              borderRadius: BorderRadius.circular(AppRadius.medium),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Save ₹50 with FRESH50',
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'On orders above ₹299 · auto-applied at cart',
                                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text('Highlights', style: AppTextStyles.headingMedium),
                          ..._highlights.map(
                            (h) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(h[0], style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                                  Text(h[1], style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('₹${product.price}', style: AppTextStyles.headingMedium),
                      Text(
                        '10 min delivery',
                        style: AppTextStyles.caption.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.medium)),
                      ),
                      onPressed: () {
                        ref.read(cartProvider.notifier).add(product.id, 1);
                        Navigator.of(context).pushNamed(RouteNames.cart);
                      },
                      child: const Text('Add to cart'),
                    ),
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
