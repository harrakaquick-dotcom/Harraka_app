import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Diagonal-stripe placeholder used everywhere a product photo would go
/// (product cards, cart line items, the product detail hero) — stands in
/// until real product photography is wired up.
class ProductImagePlaceholder extends StatelessWidget {
  const ProductImagePlaceholder({super.key, this.borderRadius = AppRadius.medium});

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CustomPaint(painter: _StripePainter(), child: const SizedBox.expand()),
    );
  }
}

class _StripePainter extends CustomPainter {
  static const _stripeWidth = 8.0;
  static const _colorA = AppColors.surface;
  static const _colorB = Color(0xFFEAE5DF);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = _colorA);
    final diagonal = size.width + size.height;
    final paint = Paint()..color = _colorB;
    canvas.save();
    canvas.rotate(0.6109); // ~35 degrees, matching the design's 135deg stripe
    for (double x = -diagonal; x < diagonal; x += _stripeWidth * 2) {
      canvas.drawRect(Rect.fromLTWH(x, -diagonal, _stripeWidth, diagonal * 2), paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
