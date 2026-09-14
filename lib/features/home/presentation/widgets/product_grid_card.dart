import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/product_image_placeholder.dart';
import '../../domain/entities/product.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({
    super.key,
    required this.product,
    required this.quantityInCart,
    required this.onOpen,
    required this.onAdd,
  });

  final Product product;
  final int quantityInCart;
  final VoidCallback onOpen;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final inCart = quantityInCart > 0;
    return InkWell(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: Stack(
                children: [
                  const Positioned.fill(child: ProductImagePlaceholder()),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product.eta,
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              product.pack,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${product.price}',
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      '₹${product.mrp}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textDisabled,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: onAdd,
                  borderRadius: BorderRadius.circular(9),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: inCart ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                    child: Text(
                      inCart ? '$quantityInCart in cart' : 'ADD',
                      style: AppTextStyles.caption.copyWith(
                        color: inCart ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
