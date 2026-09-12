import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:harraka/core/routing/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/saved_address_tile.dart';

class _SavedAddress {
  const _SavedAddress({
    required this.label,
    required this.etaMinutes,
    required this.addressLine,
  });

  final String label;
  final int etaMinutes;
  final String addressLine;
}

const _savedAddresses = [
  _SavedAddress(
    label: 'Home',
    etaMinutes: 10,
    addressLine: 'Flat 21, Sunrise Residency, Indiranagar 560038',
  ),
  _SavedAddress(
    label: 'Work',
    etaMinutes: 14,
    addressLine: '4th floor, Prestige Atrium, Koramangala',
  ),
  _SavedAddress(
    label: "Mum's place",
    etaMinutes: 22,
    addressLine: '12 Church Street, Whitefield',
  ),
];

// Default camera position until the user's location is available.
const _defaultCenter = LatLng(12.9716, 77.5946);

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final _searchController = TextEditingController();
  GoogleMapController? _mapController;
  bool _locating = false;

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _useCurrentLocation() async {
    setState(() => _locating = true);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 16),
      );
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _SearchBar(controller: _searchController),
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: _defaultCenter,
                      zoom: 15,
                    ),
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) => _mapController = controller,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Icon(Icons.location_on, color: AppColors.primary, size: 40),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    InkWell(
                      onTap: _locating ? null : _useCurrentLocation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        child: Row(
                          children: [
                            _locating
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : const Icon(Icons.my_location, color: AppColors.primary, size: 20),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              'Use my current location',
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: AppColors.border, height: AppSpacing.lg),
                    Text('Saved addresses', style: AppTextStyles.headingMedium),
                    const SizedBox(height: AppSpacing.xs),
                    ..._savedAddresses.map(
                      (address) => SavedAddressTile(
                        label: address.label,
                        etaMinutes: address.etaMinutes,
                        addressLine: address.addressLine,
                        onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteNames.home,
                          (route) => false,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    InkWell(
                      onTap: () {
                        // TODO: navigate to a full "add new address" form.
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        child: Text(
                          '+ Add new address',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.sm),
      child: TextField(
        controller: controller,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search society, street or area',
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.large),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
