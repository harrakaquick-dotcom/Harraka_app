import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Simple animated placeholder box for loading states.
class ShimmerLoader extends StatefulWidget {
  const ShimmerLoader({super.key, this.height = 16, this.width = double.infinity, this.borderRadius});

  final double height;
  final double width;
  final BorderRadius? borderRadius;

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(AppRadius.small),
            color: Color.lerp(AppColors.surface, AppColors.border, (t < 0.5 ? t : 1 - t) * 2),
          ),
        );
      },
    );
  }
}
