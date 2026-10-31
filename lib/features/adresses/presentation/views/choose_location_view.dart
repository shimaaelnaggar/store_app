import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import 'package:store/core/constants/app_colors.dart';
import 'package:store/core/helper/show_message.dart';
import 'package:store/core/widgets/app_top_bar.dart';
import 'package:store/features/adresses/presentation/bloc/addresses_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entites/addresses.dart';
import '../widgets/custom_bottom_sheet.dart';

class ChooseLocationView extends StatefulWidget {
  const ChooseLocationView({Key? key}) : super(key: key);

  @override
  State<ChooseLocationView> createState() => _ChooseLocationViewState();
}

class _ChooseLocationViewState extends State<ChooseLocationView> {
  late MapController mapController;
  late TextEditingController searchController;

  LatLng selectedLocation = const LatLng(30.0444, 31.2357);

  bool isLocating = false;
  bool mapReady = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    mapController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> goToCurrentLocation() async {
    if (isLocating) return;

    setState(() => isLocating = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled && mounted) {
        showMessage(
          context: context,
          message: ' please, enable location services',
          backgroundColor: AppColors.warningColor,
        );
        return;
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever && mounted) {
        if (mounted) {
          showMessage(
              context: context,
              message: 'please, grant location permission',
              backgroundColor: AppColors.warningColor);
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      if (!mounted) return;

      final location = LatLng(
        position.latitude,
        position.longitude,
      );

      setState(() => selectedLocation = location);

      if (mapReady) {
        mapController.move(location, 16);
      }
    } catch (_) {
      showMessage(
        context: context,
        message: 'Something went wrong',
        backgroundColor: AppColors.errorColor,
      );
    } finally {
      if (mounted) {
        setState(() => isLocating = false);
      }
    }
  }

  Future<void> searchLocation(String query) async {
    final searchQuery = query.trim();
    if (searchQuery.length < 3) {
      if (mounted) {
        showMessage(
          context: context,
          message: 'Search term must be at least 3 characters',
          backgroundColor: AppColors.warningColor,
        );
      }
      return;
    }

    if (searchQuery.isEmpty) return;
    try {
      final dio = getIt<Dio>(
        instanceName: 'locationSearchDio',
      );
      final response = await dio.get(
        '/search',
        queryParameters: {
          'q': searchQuery,
          'format': 'jsonv2',
          'limit': 1,
        },
      );

      final data = response.data;

      if (data is! List || data.isEmpty) {
        if (mounted) {
          showMessage(
            context: context,
            message: 'No results found',
            backgroundColor: AppColors.warningColor,
          );
        }
        return;
      }

      final place = data.first;

      final latitude = double.parse(place['lat'].toString());
      final longitude = double.parse(place['lon'].toString());

      final location = LatLng(latitude, longitude);

      if (!mounted) return;

      setState(() {
        selectedLocation = location;
      });

      if (mapReady) {
        mapController.move(location, 15);
      }
    } on DioException catch (e) {
      debugPrint('Search error: ${e.message}');

      if (!mounted) return;

      showMessage(
        context: context,
        message: 'Unable to search for the location; please try again.',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(
              title: 'Choose Location',
              showActions: false,
            ),
            Expanded(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: selectedLocation,
                      initialZoom: 13,
                      onMapReady: () {
                        mapReady = true;
                      },
                      onPositionChanged: (camera, hasGesture) {
                        if (hasGesture && mounted) {
                          setState(() {
                            selectedLocation = camera.center;
                          });
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.store',
                      ),
                    ],
                  ),
                  IgnorePointer(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 36.h),
                        child: Icon(
                          Icons.location_pin,
                          size: 48.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    left: 16.w,
                    right: 16.w,
                    child: CustomTextField(
                      hintText: 'Search for an area or address',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: searchController,
                        builder: (context, value, child) {
                          final hasText = value.text.isNotEmpty;

                          return hasText
                              ? IconButton(
                                  onPressed: searchController.clear,
                                  icon: const Icon(Icons.close),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      showCounter: false,
                      onFieldSubmitted: searchLocation,
                    ),
                  ),
                  Positioned(
                    right: 16.w,
                    bottom: 240.h,
                    child: Column(
                      children: [
                        mapControl(
                          icon: Icons.add,
                          onTap: () {
                            mapController.move(
                              selectedLocation,
                              mapController.camera.zoom + 1,
                            );
                          },
                        ),
                        SizedBox(height: 8.h),
                        mapControl(
                          icon: Icons.remove,
                          onTap: () {
                            mapController.move(
                              selectedLocation,
                              mapController.camera.zoom - 1,
                            );
                          },
                        ),
                        SizedBox(height: 16.h),
                        mapControl(
                          icon: Icons.my_location,
                          onTap: goToCurrentLocation,
                          isLoading: isLocating,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: CustomBottomSheet(
                        onConfirm: () async {
                          final address = await context.push<Addresses>(
                            '/address-details',
                            extra: AddressDetailsArgs(
                              selectedLocation: selectedLocation,
                              addressesBloc: context.read<AddressesBloc>(),
                            ),
                          );

                          if (!context.mounted || address == null) return;

                          context.pop(address);
                        },
                        location:
                            '${selectedLocation.latitude.toStringAsFixed(5)}, '
                            '${selectedLocation.longitude.toStringAsFixed(5)}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mapControl({
    required IconData icon,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(12.r),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: SizedBox(
          width: 44.w,
          height: 44.h,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    icon,
                    color: AppColors.primaryColor,
                  ),
          ),
        ),
      ),
    );
  }
}
