import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_Gradient_button.dart';

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.buttonLabel,
  });

  final String imageAsset;
  final String title;
  final String description;
  final String buttonLabel;
}

const _pages = [
  _OnboardingPageData(
    imageAsset: 'assets/images/splash/onboarding_rider.png',
    title: 'Ten minutes. That is the whole promise.',
    description:
        'Dark stores across your city keep 4,000 everyday items two streets away from you.',
    buttonLabel: 'Next',
  ),
  _OnboardingPageData(
    imageAsset: 'assets/images/splash/onboarding_produce.png',
    title: 'Fresh picked twice a day',
    description:
        'Fruit, veg and dairy arrive at the store each morning and evening. Nothing sits overnight.',
    buttonLabel: 'Next',
  ),
  _OnboardingPageData(
    imageAsset: 'assets/images/splash/onboarding_tracking.png',
    title: 'Watch it come to your door',
    description:
        'Live rider tracking, contactless drop and refunds settled within 24 hours.',
    buttonLabel: 'Create account',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == _pages.length - 1) {
      Navigator.of(context).pushReplacementNamed(RouteNames.signup);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed(RouteNames.signup),
                  child: Text(
                    'Skip',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(AppRadius.large),
                            ),
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            child: Image.asset(page.imageAsset),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        const SizedBox(height: AppSpacing.xs),
                        Text(page.title, style: AppTextStyles.headingLarge),
                        const SizedBox(height: AppSpacing.sm),
                        Text(page.description, style: AppTextStyles.bodyMedium),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                      radius: AppRadius.small,
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.border,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppGradientButton(
                    label: _pages[_page].buttonLabel,
                    onPressed: _next,
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
