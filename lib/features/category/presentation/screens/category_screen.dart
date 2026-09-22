import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../home/data/sample_catalog.dart';
import '../../../home/presentation/widgets/product_grid_card.dart';

const _aisles = ['All', 'Fresh fruit', 'Exotic', 'Vegetables', 'Herbs', 'Cut & peeled'];

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  int _aisle = 0;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

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
                    child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Fruits & Vegetables', style: AppTextStyles.headingMedium),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 88,
                    child: Container(
                      color: AppColors.surface,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        itemCount: _aisles.length,
                        itemBuilder: (context, i) {
                          final active = i == _aisle;
                          return InkWell(
                            onTap: () => setState(() => _aisle = i),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: 6),
                              decoration: BoxDecoration(
                                color: active ? Colors.white : Colors.transparent,
                                border: Border(
                                  left: BorderSide(
                                    color: active ? AppColors.primary : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _aisles[i],
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: active ? AppColors.primaryDark : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.sm, AppSpacing.sm, AppSpacing.sm, 90),
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.sm,
                      mainAxisSpacing: AppSpacing.sm,
                      childAspectRatio: 0.66,
                      children: sampleCatalog.map((product) {
                        return ProductGridCard(
                          product: product,
                          quantityInCart: cart[product.id] ?? 0,
                          onOpen: () => Navigator.of(context)
                              .pushNamed(RouteNames.productDetails, arguments: product.id),
                          onAdd: () => ref.read(cartProvider.notifier).add(product.id, 1),
                        );
                      }).toList(),
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
