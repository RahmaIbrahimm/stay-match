import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/heart_favourite_button.dart';

import '../../../../core/routing/app_routing.dart';
import '../../../google_maps/presentation/views/google_maps_view.dart';
import '../../../google_maps/presentation/widgets/maps_helper.dart';
import '../../../rooms/presentation/manager/shared_property_cubit.dart';

class SharedPropertyView extends StatelessWidget {
  final int propertyId;

  const SharedPropertyView({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SharedPropertyCubit(roomsRepo: getIt.get<RoomsRepoImpl>())
            ..fetchDetails(propertyId: propertyId),
      child: const _SharedPropertyScaffold(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Scaffold
// ─────────────────────────────────────────────────────────────────────────────

class _SharedPropertyScaffold extends StatelessWidget {
  const _SharedPropertyScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textColorPrimary,
            size: 22.r,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Apartment Details',
          style: AppStyles.semiBold18poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: AppColors.textColorPrimary,
              size: 22.r,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<SharedPropertyCubit, SharedPropertyState>(
        builder: (context, state) {
          if (state is SharedPropertyInitial ||
              state is SharedPropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SharedPropertyFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errMessage,
                    textAlign: TextAlign.center,
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () =>
                        context.read<SharedPropertyCubit>().retry(),
                    child: Text(
                      'Try again',
                      style: AppStyles.semiBold14poppins.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is SharedPropertySuccess) {
            return _SharedPropertyBody(data: state.details.data!);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Body
// ─────────────────────────────────────────────────────────────────────────────

class _SharedPropertyBody extends StatefulWidget {
  final SharedApartmentDetailsData data;

  const _SharedPropertyBody({required this.data});

  @override
  State<_SharedPropertyBody> createState() => _SharedPropertyBodyState();
}

class _SharedPropertyBodyState extends State<_SharedPropertyBody> {
  final _picNotifier = ValueNotifier<int>(1);

  @override
  void dispose() {
    _picNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final images = d.propertyImages ?? [];
    final numImages = images.isEmpty ? 1 : images.length;
    final rooms = d.rooms ?? [];

    // Rent range from rooms
    final rents =
        rooms.map((r) => r.monthRent ?? 0).where((v) => v > 0).toList()..sort();
    final rentLabel = rents.isEmpty
        ? '—'
        : rents.length == 1
        ? '${rents.first}k'
        : '${rents.first} - ${rents.last}';

    return CustomScrollView(
      slivers: [
        // ── 1. Image carousel ──────────────────────────────────────────────
        SliverToBoxAdapter(
          child: _ImageCarousel(
            images: images,
            numImages: numImages,
            picNotifier: _picNotifier,
            propertyId: d.id?.toInt() ?? 0,
            isSaved: d.isSaved ?? false,
          ),
        ),

        // ── 2. All detail content ──────────────────────────────────────────
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20.h),
              // Host pill
              _HostPill(hostName: d.hostName, hostId: d.hostId),
              SizedBox(height: 8.h),

              // Name
              Text(
                d.name ?? 'Unnamed Property',
                style: AppStyles.bold24poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),

              // Location
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14.r,
                    color: AppColors.textColorSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      [
                        d.street,
                        d.city,
                        d.government,
                      ].where((e) => e != null && e.isNotEmpty).join(', '),
                      style: AppStyles.regular12poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Stats grid
              _StatsGrid(
                data: d,
                rentLabel: rentLabel,
                roomCount: rooms.length,
              ),
              SizedBox(height: 20.h),

              // Shared Amenities
              if (d.amenities != null) ...[
                _SectionHeader(
                  icon: Icons.star_sharp,
                  label: 'Shared Amenities',
                ),
                SizedBox(height: 10.h),
                AmenitiesWrap(amenities: d.amenities!),
                SizedBox(height: 20.h),
              ],

              // Nearby Services
              if (d.nearbyServices != null) ...[
                _SectionHeader(icon: Icons.apartment, label: 'Nearby Services'),
                SizedBox(height: 10.h),
                _NearbyServicesList(services: d.nearbyServices!),
                SizedBox(height: 20.h),
              ],

              // House Rules — placeholder booleans, TODO: wire to real data
              // _SectionHeader(icon: Icons.scale, label: 'House Rules'),
              SizedBox(height: 10.h),
              // _HouseRules(
              //   // TODO: replace these with real fields from the API when available
              //   noSmoking: true,
              //   noPets: true,
              //   visitorsAllowedUntil11: true,
              //   quietHours: true,
              // ),
              SizedBox(height: 20.h),

              // Map
              if (d.latitude != null && d.longitude != null) ...[
                _MapSection(
                  latitude: d.latitude!.toDouble(),
                  longitude: d.longitude!.toDouble(),
                  city: d.city,
                  government: d.government,
                ),
                SizedBox(height: 20.h),
              ],

              // About
              if (d.description != null && d.description!.isNotEmpty) ...[
                Text(
                  'About the Apartment',
                  style: AppStyles.bold18poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  d.description!,
                  style: AppStyles.regular14poppins.copyWith(
                    color: AppColors.textColorSecondary,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ]),
          ),
        ),

        // ── 3. Available Rooms ─────────────────────────────────────────────
        if (rooms.isNotEmpty) ...[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverToBoxAdapter(
              child: _SectionHeader(label: 'Available Rooms'),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: rooms.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (_, i) => _RoomCard(
                  room: rooms[i],
                  propertyId: widget.data.id?.toInt() ?? 0,
                ),
              ),
            ),
          ),
        ],

        SliverToBoxAdapter(child: SizedBox(height: 40.h)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Image carousel
// ─────────────────────────────────────────────────────────────────────────────

class _ImageCarousel extends StatelessWidget {
  final List<PropertyImages> images;
  final int numImages;
  final ValueNotifier<int> picNotifier;
  final int propertyId;
  final bool isSaved;

  const _ImageCarousel({
    required this.images,
    required this.numImages,
    required this.picNotifier,
    required this.propertyId,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: Stack(
        children: [
          // Pages
          PageView.builder(
            onPageChanged: (v) => picNotifier.value = v + 1,
            itemCount: numImages,
            itemBuilder: (_, i) {
              final url = images.isNotEmpty ? (images[i].imageUrl ?? '') : '';
              return CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.bgGrey,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.bgGrey,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 40.r,
                    color: AppColors.textColorSecondary,
                  ),
                ),
              );
            },
          ),

          // View Reviews — top left
          Positioned(
            top: 12.h,
            left: 12.w,
            child: GestureDetector(
              onTap: () {
                // TODO: context.pushNamed(AppRouting.reviewsViewName, extra: propertyId)
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'View Reviews',
                  style: AppStyles.semiBold12poppins.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // todo: share — top right
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Row(
              children: [
                Container(
                  width: 34.r,
                  height: 34.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: AppColors.elevationShadow,
                  ),
                  child: HeartFavoriteButton(
                    id: propertyId,
                    initialSavedStatus: isSaved,
                    scaleUp: true,
                  ),
                ),
                SizedBox(width: 6.w),
                // _ImgBtn(icon: Icons.share_outlined, onTap: () {}),
              ],
            ),
          ),

          // Page counter — top right (below icons)
          Positioned(
            bottom: 20.h,
            right: 10.w,
            child: ValueListenableBuilder<int>(
              valueListenable: picNotifier,
              builder: (_, val, __) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '$val / $numImages',
                  style: AppStyles.semiBold12poppins.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),

          // Dot indicator — bottom
          Positioned(
            bottom: 10.h,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: picNotifier,
              builder: (_, val, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  numImages,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: (val - 1) == i ? 16.w : 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.white, width: 0.3.r),
                      color: (val - 1) == i ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImgBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ImgBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34.r,
        height: 34.r,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: AppColors.elevationShadow,
        ),
        child: Icon(icon, size: 16.r, color: AppColors.textColorPrimary),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Host pill
// ─────────────────────────────────────────────────────────────────────────────

class _HostPill extends StatelessWidget {
  final String? hostName;
  final String? hostId;

  const _HostPill({this.hostName, this.hostId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          context.pushNamed(
            AppRouting.otherUserProfileName,
            extra: hostId.toString(),
          );
        }
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.r),
          alignment: Alignment.center,
          width: 200.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.person, size: 20.sp, color: Colors.white),
                ),
                WidgetSpan(child: SizedBox(width: 8.w)),
                TextSpan(
                  text: hostName ?? 'Host Name',
                  style: AppStyles.semiBold16poppins.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stats grid
// ─────────────────────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  final SharedApartmentDetailsData data;
  final String rentLabel;
  final int roomCount;

  const _StatsGrid({
    required this.data,
    required this.rentLabel,
    required this.roomCount,
  });

  @override
  Widget build(BuildContext context) {
    final cells = [
      _StatData(Icons.straighten, '${data.size ?? 0} m²', 'Total Area'),
      _StatData(Icons.monetization_on_outlined, rentLabel, 'Rent (EGP)'),
      _StatData(Icons.bed_outlined, '$roomCount Rooms', 'Available'),
      _StatData(Icons.meeting_room_outlined, '$roomCount Rooms', 'Total Rooms'),
      if (data.minimumStay != null)
        _StatData(
          Icons.calendar_today_outlined,
          '${data.minimumStay} mo',
          'Min. Stay',
        ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cells.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (_, i) => _StatCell(s: cells[i]),
    );
  }
}

class _StatData {
  final IconData icon;
  final String value;
  final String label;

  const _StatData(this.icon, this.value, this.label);
}

class _StatCell extends StatelessWidget {
  final _StatData s;

  const _StatCell({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.secondaryScaffBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(s.icon, size: 20.r, color: AppColors.primary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  s.label,
                  style: AppStyles.semiBold14poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),
                Text(
                  s.value,
                  style: AppStyles.medium12poppins.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final IconData? icon;
  final String label;

  const _SectionHeader({this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(icon, size: 16.r, color: AppColors.textColorPrimary),
        SizedBox(width: 8.w),
        Text(
          label,
          style: AppStyles.bold16poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Amenities wrap
// ─────────────────────────────────────────────────────────────────────────────

class AmenitiesWrap extends StatelessWidget {
  final Amenities amenities;

  const AmenitiesWrap({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    final chips = <_ChipData>[
      if (amenities.wifi == true) _ChipData(Icons.wifi, 'High-speed Wi-Fi'),
      if (amenities.washer == true)
        _ChipData(Icons.local_laundry_service, 'Washer & Dryer'),
      if (amenities.airConditioning == true)
        _ChipData(Icons.ac_unit, 'Central Air'),
      if (amenities.freeParking == true)
        _ChipData(Icons.local_parking, 'Free Parking'),
      if (amenities.tv == true) _ChipData(Icons.tv, 'TV'),
      if (amenities.refrigerator == true)
        _ChipData(Icons.kitchen, 'Refrigerator'),
      if (amenities.microwave == true) _ChipData(Icons.microwave, 'Microwave'),
      if (amenities.oven == true)
        _ChipData(Icons.outdoor_grill_outlined, 'Oven'),
      if (amenities.cooktop == true)
        _ChipData(Icons.soup_kitchen_outlined, 'Cooktop'),
      if (amenities.dishwasher == true)
        _ChipData(Icons.countertops_outlined, 'Dishwasher'),
      if (amenities.kettle == true)
        _ChipData(Icons.emoji_food_beverage_outlined, 'Kettle'),
      if (amenities.smokeAlarm == true)
        _ChipData(MdiIcons.smokeDetectorAlertOutline, 'Smoke Alarm'),
      if (amenities.fireExtinguisher == true)
        _ChipData(Icons.fire_extinguisher_outlined, 'Fire Extinguisher'),
    ];

    if (chips.isEmpty) {
      return Text(
        'No amenities listed',
        style: AppStyles.regular14poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      );
    }

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: chips
          .map(
            (c) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: AppColors.stroke),
                boxShadow: AppColors.elevationShadow,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(c.icon, size: 14.r, color: AppColors.primary),
                  SizedBox(width: 6.w),
                  Text(
                    c.label,
                    style: AppStyles.regular12poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ChipData {
  final IconData icon;
  final String label;

  const _ChipData(this.icon, this.label);
}

// ─────────────────────────────────────────────────────────────────────────────
// Nearby services list
// ─────────────────────────────────────────────────────────────────────────────

class _NearbyServicesList extends StatelessWidget {
  final NearbyServices services;

  const _NearbyServicesList({required this.services});

  @override
  Widget build(BuildContext context) {
    final list = <_ChipData>[
      if (services.hasPublicTransport == true)
        _ChipData(Icons.directions_transit, 'Public Transport'),
      if (services.hasGroceryStore == true)
        _ChipData(Icons.local_grocery_store_outlined, 'Grocery Store'),
      if (services.hasPharmacy == true)
        _ChipData(Icons.local_pharmacy_outlined, 'Pharmacy'),
      if (services.hasHospital == true)
        _ChipData(Icons.local_hospital_outlined, 'Hospital'),
      if (services.hasSchool == true)
        _ChipData(Icons.school_outlined, 'School'),
      if (services.hasUniversity == true)
        _ChipData(Icons.account_balance_outlined, 'University'),
      if (services.hasParking == true)
        _ChipData(Icons.local_parking, 'Parking'),
      if (services.hasMall == true)
        _ChipData(Icons.shopping_bag_outlined, 'Mall'),
      if (services.hasRestaurants == true)
        _ChipData(Icons.restaurant_outlined, 'Restaurants'),
      if (services.hasPark == true) _ChipData(Icons.park_outlined, 'Park'),
      if (services.hasGym == true) _ChipData(Icons.fitness_center, 'Gym'),
      if (services.isSafeArea == true)
        _ChipData(Icons.shield_outlined, 'Safe Area'),
      if (services.hasPoliceStation == true)
        _ChipData(Icons.local_police_outlined, 'Police Station'),
      if (services.isQuietArea == true)
        _ChipData(Icons.volume_off_outlined, 'Quiet Area'),
      if (services.hasMosqueNearby == true)
        _ChipData(Icons.mosque_outlined, 'Mosque Nearby'),
      if (services.hasChurchNearby == true)
        _ChipData(Icons.church_outlined, 'Church Nearby'),
    ];

    if (list.isEmpty) {
      return Text(
        'No nearby services listed',
        style: AppStyles.regular14poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      );
    }

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: list
          .map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.blueGrey,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(e.icon, size: 16.r, color: AppColors.primary),
                  SizedBox(width: 8.w),
                  Text(
                    e.label,
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// House Rules  (booleans — TODO: wire to real API fields when available)
// ─────────────────────────────────────────────────────────────────────────────

class _HouseRules extends StatelessWidget {
  // TODO: replace these hardcoded booleans with real model fields
  // e.g. data.houseRules.noSmoking, data.houseRules.noPets, etc.
  final bool noSmoking;
  final bool noPets;
  final bool visitorsAllowedUntil11;
  final bool quietHours;

  const _HouseRules({
    required this.noSmoking,
    required this.noPets,
    required this.visitorsAllowedUntil11,
    required this.quietHours,
  });

  @override
  Widget build(BuildContext context) {
    final rules = <_RuleData>[
      if (noSmoking)
        _RuleData(
          Icons.smoke_free,
          const Color(0xFFE53935),
          'No smoking inside the apartment',
          false,
        ),
      if (noPets)
        _RuleData(
          Icons.pets,
          const Color(0xFFE53935),
          'Pets are not permitted',
          false,
        ),
      if (visitorsAllowedUntil11)
        _RuleData(
          Icons.check_circle_outline,
          const Color(0xFF43A047),
          'Visitors allowed until 11 PM',
          true,
        ),
      if (quietHours)
        _RuleData(
          Icons.check_circle_outline,
          const Color(0xFF43A047),
          'Maintain quiet hours (10 PM – 8 AM)',
          true,
        ),
    ];

    if (rules.isEmpty) return const SizedBox.shrink();

    return Column(
      children: rules
          .map(
            (r) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Icon(r.icon, size: 18.r, color: r.color),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      r.label,
                      style: AppStyles.regular14poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _RuleData {
  final IconData icon;
  final Color color;
  final String label;
  final bool allowed;

  const _RuleData(this.icon, this.color, this.label, this.allowed);
}

// ─────────────────────────────────────────────────────────────────────────────
// Map section
// ─────────────────────────────────────────────────────────────────────────────

class _MapSection extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String? city;
  final String? government;

  const _MapSection({
    required this.latitude,
    required this.longitude,
    this.city,
    this.government,
  });

  @override
  Widget build(BuildContext context) {
    final locationLabel = [
      city,
      government,
    ].where((e) => e != null && e.isNotEmpty).join(', ');

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to full GoogleMapsView
        context.pushNamed(AppRouting.googleMapsViewName,
          extra: {'latitude': latitude.toString(), 'longitude': longitude.toString(),'isStatic':'true'});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.stroke),
          boxShadow: AppColors.elevationShadow,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              child: IgnorePointer(
                child: GoogleMapsView(
                  initialLatitude: latitude,
                  initialLongitude: longitude,
                  mapContext: MapContext.staticView,
                  mapView: MapViewType.partialView,
                ),
              ),
            ),
            if (locationLabel.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(14.r),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16.r,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        locationLabel,
                        style: AppStyles.semiBold14poppins.copyWith(
                          color: AppColors.textColorPrimary,
                        ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Available room card
// ─────────────────────────────────────────────────────────────────────────────

class _RoomCard extends StatelessWidget {
  final Rooms room;
  final int propertyId;

  const _RoomCard({required this.room, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: room.coverImageUrl ?? '',
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(height: 120.h, color: AppColors.bgGrey),
                errorWidget: (_, __, ___) => Container(
                  height: 120.h,
                  color: AppColors.bgGrey,
                  child: Icon(
                    Icons.bed_outlined,
                    size: 30.r,
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ),
              if (room.monthRent != null)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '${room.monthRent} EGP/mo',
                      style: AppStyles.semiBold10poppins.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  room.roomName ?? 'Room',
                  style: AppStyles.semiBold14poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'View Room Details',
                    textStyle: AppStyles.semiBold14poppins,
                    borderRadius: 8,
                    verticalPadding: 8,
                    onPressed: () {
                      // TODO: context.pushNamed(
                      //   AppRouting.roomDetailsViewName,
                      //   extra: {'roomId': room.id?.toInt(), 'propertyId': propertyId},
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Circle arrow button
// ─────────────────────────────────────────────────────────────────────────────

class _CircleArrowBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleArrowBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.r,
        height: 28.r,
        decoration: BoxDecoration(
          color: AppColors.blueGrey,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18.r, color: AppColors.primary),
      ),
    );
  }
}