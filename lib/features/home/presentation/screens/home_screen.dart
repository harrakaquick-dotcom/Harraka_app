import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routing/route_names.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../data/sample_catalog.dart';
import '../widgets/product_grid_card.dart';

class _Banner {
  const _Banner({required this.tag, required this.title, required this.sub, required this.gradient, required this.solid});
  final String tag;
  final String title;
  final String sub;
  final Gradient? gradient;
  final Color? solid;
}

const _banners = [
  _Banner(
    tag: 'FRESH DROP',
    title: 'Alphonso season is here',
    sub: 'Flat 30% off · today only',
    gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
    solid: null,
  ),
  _Banner(
    tag: '10-MIN PROMISE',
    title: 'Late? Delivery fee on us',
    sub: 'Every order, every store',
    gradient: null,
    solid: AppColors.primaryLight,
  ),
  _Banner(
    tag: 'NEW',
    title: 'Chef-ready meal kits',
    sub: 'Dinner sorted under ₹199',
    gradient: LinearGradient(colors: [AppColors.textPrimary, Color(0xFF3A2A26)]),
    solid: null,
  ),
];

const _homeCategories = [
  'Fruits & Veg',
  'Dairy & Eggs',
  'Snacks',
  'Beverages',
  'Staples',
  'Home care',
  'Personal care',
  'Baby',
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _bannerController = PageController();
  int _banner = 0;

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: AppColors.primary,
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.xs, AppSpacing.lg, AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      color: AppColors.secondary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    'Delivery in 10 minutes',
                                    style: AppTextStyles.headingMedium.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              InkWell(
                                onTap: () => Navigator.of(context).pushNamed(RouteNames.addresses),
                                child: Text(
                                  'Flat 21, Sunrise Residency, Indiranagar  ▾',
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryLight),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pushNamed(RouteNames.notifications),
                          child: const Padding(
                            padding: EdgeInsets.only(right: AppSpacing.sm, top: 4),
                            child: Icon(Icons.notifications_none, color: Colors.white),
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primaryDark,
                          child: Text(
                            'AR',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(RouteNames.search),
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                      child: Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: AppColors.textSecondary, size: 18),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              'Search "atta", "cold coffee", "eggs"',
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 132,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _bannerController,
                          itemCount: _banners.length,
                          onPageChanged: (i) => setState(() => _banner = i),
                          itemBuilder: (context, i) {
                            final b = _banners[i];
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                              decoration: BoxDecoration(gradient: b.gradient, color: b.solid),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    b.tag,
                                    style: AppTextStyles.caption.copyWith(
                                      color: b.solid != null ? AppColors.primaryDark : AppColors.primaryLight,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    b.title,
                                    style: AppTextStyles.headingMedium.copyWith(
                                      color: b.solid != null ? AppColors.primaryDark : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    b.sub,
                                    style: AppTextStyles.caption.copyWith(
                                      color: b.solid != null ? AppColors.primaryDark : AppColors.primaryLight,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Positioned(
                          left: 12,
                          bottom: 10,
                          child: Row(
                            children: List.generate(_banners.length, (i) {
                              final active = i == _banner;
                              return Container(
                                margin: const EdgeInsets.only(right: 5),
                                width: active ? 18 : 6,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: active ? Colors.white : Colors.white.withValues(alpha: 0.55),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xs),
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                  childAspectRatio: 0.8,
                  children: _homeCategories.map((label) {
                    return InkWell(
                      onTap: () => Navigator.of(context).pushNamed(RouteNames.category),
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(AppRadius.medium),
                              ),
                              child: const Icon(Icons.shopping_basket_outlined, color: AppColors.primaryDark),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fastest near you', style: AppTextStyles.headingMedium),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Filters',
                        style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  cart.isEmpty ? AppSpacing.lg : 90,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}
