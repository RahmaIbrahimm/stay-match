import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/shared_proeprty/room_details_host_pill.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/shared_proeprty/section_header.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/shared_proeprty/stats_grid.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/draggable_chatbot_fab.dart';

import 'amenities_wrap.dart';
import 'details_room_card.dart';
import 'image_carousel.dart';
import 'map_sections.dart';
import 'nearby_services_list.dart';

class SharedPropertyBody extends StatefulWidget {
  final SharedApartmentDetailsData data;

  const SharedPropertyBody({required this.data});

  @override
  State<SharedPropertyBody> createState() => _SharedPropertyBodyState();
}

class _SharedPropertyBodyState extends State<SharedPropertyBody> {
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
          child: SharedPropertyImageCarousel(
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
              RoomDetailsHostPill(hostName: d.hostName, hostId: d.hostId),
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
              StatsGrid(data: d, rentLabel: rentLabel, roomCount: rooms.length),
              SizedBox(height: 20.h),

              // Shared Amenities
              if (d.amenities != null) ...[
                SharedPropertySectionHeader(
                  icon: Icons.star_sharp,
                  label: 'Shared Amenities',
                ),
                SizedBox(height: 10.h),
                AmenitiesWrap(amenities: d.amenities!),
                SizedBox(height: 20.h),
              ],

              // Nearby Services
              if (d.nearbyServices != null) ...[
                SharedPropertySectionHeader(
                  icon: Icons.apartment,
                  label: 'Nearby Services',
                ),
                SizedBox(height: 10.h),
                NearbyServicesList(services: d.nearbyServices!),
                SizedBox(height: 20.h),
              ],
              SizedBox(height: 10.h),
              SizedBox(height: 20.h),

              // Map
              if (d.latitude != null && d.longitude != null) ...[
                MapSection(
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
              child: SharedPropertySectionHeader(label: 'Available Rooms'),
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
                itemBuilder: (_, i) => DetailsRoomCard(
                  room: rooms[i],
                  propertyId: widget.data.id?.toInt() ?? 0, isMyProperty: widget.data.isMyProperty?? false,
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