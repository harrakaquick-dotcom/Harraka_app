import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';

class _TimelineStep {
  const _TimelineStep(this.label, this.time, this.done);
  final String label;
  final String time;
  final bool done;
}

const _timeline = [
  _TimelineStep('Order confirmed', '9:41 AM', true),
  _TimelineStep('Packed at Indiranagar store', '9:43 AM', true),
  _TimelineStep('Rohit picked up your order', '9:45 AM', true),
  _TimelineStep('Arriving at your door', 'ETA 9:51 AM', false),
];

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: CustomPaint(painter: _RoutePainter()),
                  ),
                  Positioned(
                    top: 14,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary,
                        borderRadius: BorderRadius.circular(AppRadius.small),
                      ),
                      child: Text(
                        'Arriving in 6 min',
                        style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    right: 16,
                    child: InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(AppRadius.medium),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.primaryLight,
                            child: Text(
                              'RS',
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rohit S. is on the way', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                                Text('Order #HQ-48213 · 4 items', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              'Call',
                              style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ..._timeline.map((t) {
                      final isLast = t == _timeline.last;
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: t.done ? AppColors.secondary : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: t.done ? AppColors.secondary : AppColors.primary, width: 2),
                                  ),
                                ),
                                if (!isLast)
                                  Expanded(
                                    child: Container(
                                      width: 2,
                                      color: t.done ? AppColors.secondary : AppColors.border,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.label,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: t.done ? AppColors.textPrimary : AppColors.primaryDark,
                                      ),
                                    ),
                                    Text(t.time, style: AppTextStyles.caption.copyWith(color: AppColors.textDisabled)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primary, width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.medium)),
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(RouteNames.support),
                            child: Text('Need help', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w800)),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.textPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.medium)),
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(RouteNames.orderHistory),
                            child: const Text('All orders'),
                          ),
                        ),
                      ],
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
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.surface);

    final gridPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.82)
      ..lineTo(size.width * 0.33, size.height * 0.73)
      ..lineTo(size.width * 0.38, size.height * 0.52)
      ..lineTo(size.width * 0.62, size.height * 0.42)
      ..lineTo(size.width * 0.77, size.height * 0.24);

    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    canvas.drawCircle(Offset(size.width * 0.18, size.height * 0.82), 9, Paint()..color = AppColors.secondary);
    canvas.drawCircle(Offset(size.width * 0.77, size.height * 0.24), 9, Paint()..color = AppColors.primaryDark);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
