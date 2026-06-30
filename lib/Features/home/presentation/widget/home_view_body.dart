import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/apartments/presentation/manager/apartment_cubit.dart';
import 'package:stay_match/Features/home/presentation/widget/rooms_section.dart';
import 'package:stay_match/Features/my_properties/presentation/manager/my_properties_cubit.dart';
import 'package:stay_match/Features/rooms/presentation/manager/rooms_cubit.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../apartments/data/models/all_apartments_response.dart';
import '../../../apartments/presentation/widgets/shared/apartment_card.dart';
import '../../../rooms/data/models/get_all_rooms.dart';
import '../../../rooms/presentation/widgets/shared/room_card.dart';
import '../manager/home_cubit.dart';
import 'add_or_show_property.dart';
import 'apartment_section.dart';
import 'home_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  bool get wantKeepAlive => true; // Keeps state alive
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    var apartmentCubit = context.read<ApartmentCubit>();
    var roomsCubit = context.read<RoomsCubit>();
    var myPropertiesCubit = context.read<MyPropertiesCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      child: RefreshIndicator(
        strokeWidth: 1,
        color: AppColors.primary,
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        onRefresh: ()async {
          await apartmentCubit.refreshApartments();
          await roomsCubit.refreshRooms();
          await myPropertiesCubit.getMyProperties();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HomeHeader(size: size, tabController: _tabController),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),

            // ← ADD THIS: show search results OR normal home content
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
                  );
                }

                if (state is HomeFailure) {
                  return SliverFillRemaining(
                    child: Center(child: Text(state.errMessage)),
                  );
                }

                if (state is HomeSuccess) {
                  final homeCubit = context.read<HomeCubit>();
                  final isEntire = homeCubit.selectedProperty == HomeSearchFilter.entire;

                  if (isEntire) {
                    final items = state.response.data?.entireProperties?.items ?? [];
                    return _buildEntireResults(items);
                  } else {
                    final items = state.response.data?.sharedProperties?.items ?? [];
                    return _buildSharedResults(items);
                  }
                }

                // Default: normal home content
                return SliverList(
                  delegate: SliverChildListDelegate([
                    ApartmentSection(),
                    SizedBox(height: 24.h),
                    RoomsSection(),
                    SizedBox(height: 24.h),
                    AddOrShowMyProperties(),
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildEntireResults(List items) {
    if (items.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text('No apartments found')),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          // index 0 = header, index 1+ = items[index - 1]
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultsHeader('Apartments', items.length),
                SizedBox(height: 12.h),
              ],
            );
          }
          final item = items[index - 1]; // ← offset by 1
          return _buildEntirePropertyCard(item); // ← your card here
        },
        childCount: items.length + 1, // ← +1 for header
      ),
    );
  }
  Widget _buildResultsHeader(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$count $title found', style: AppStyles.bold16poppins),
        TextButton(
          onPressed: () => context.read<HomeCubit>().emit(HomeInitial()),
          child: Text('Clear', style: AppStyles.medium14poppins.copyWith(color: AppColors.primary)),
        ),
      ],
    );
  }

// Same fix for shared:
  Widget _buildSharedResults(List items) {
    if (items.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text('No rooms found')),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultsHeader('Shared Properties', items.length),
                SizedBox(height: 12.h),
              ],
            );
          }
          final property = items[index - 1]; // ← offset by 1
          return _buildSharedPropertyCard(property);
        },
        childCount: items.length + 1, // ← +1 for header
      ),
    );
  }
  Widget _buildEntirePropertyCard(dynamic item) {
    // Convert search Items to AllApartmentsItems shape
    final adapted = AllApartmentsItems(
      id: item.id,
      name: item.name,
      city: item.city,
      street: item.street,
      monthlyRent: item.monthlyRent,
      numberOfBedrooms: item.numberOfBedrooms,
      numberOfGuestBathrooms: item.numberOfGuestBathrooms,
      numberOfEnSuiteBathrooms: item.numberOfEnSuiteBathrooms,
      size: item.size,
      coverImageUrl: item.coverImageUrl,
    );
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: ApartmentCard(property: adapted, scaleUp: true),
    );
  }
  Widget _buildSharedPropertyCard(dynamic item) {
    final adaptedRooms = (item.rooms as List?)?.map((room) => AllRooms(
      id: room.id,
      roomName: room.roomName,
      monthRent: room.monthRent,
      isAvailable: room.isAvailable,
      availableFrom: room.availableFrom,
      status: room.status,
    )).toList() ?? [];

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: SizedBox(
        height: 325.h,
        child: RoomCard(
          scaleUp: true,
          coverImageUrl: item.coverImageUrl,
          name: item.name,
          street: item.street,
          city: item.city,
          id: item.id,
          rooms: adaptedRooms, item: item.propertyMatchScore,
        ),
      ),
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/Features/apartments/presentation/manager/apartment_cubit.dart';
// import 'package:stay_match/Features/home/presentation/widget/rooms_section.dart';
// import 'package:stay_match/Features/my_properties/presentation/manager/my_properties_cubit.dart';
// import 'package:stay_match/Features/rooms/presentation/manager/rooms_cubit.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
//
// import '../../../../core/constants/app_styles.dart';
// import '../manager/home_cubit.dart';
// import 'add_or_show_property.dart';
// import 'apartment_section.dart';
// import 'home_header.dart';
//
// class HomeViewBody extends StatefulWidget {
//   const HomeViewBody({super.key});
//
//   @override
//   State<HomeViewBody> createState() => _HomeViewBodyState();
// }
//
// class _HomeViewBodyState extends State<HomeViewBody>
//     with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   @override
//   bool get wantKeepAlive => true; // Keeps state alive
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     var size = MediaQuery.of(context).size;
//     var apartmentCubit = context.read<ApartmentCubit>();
//     var roomsCubit = context.read<RoomsCubit>();
//     var myPropertiesCubit = context.read<MyPropertiesCubit>();
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
//       child: RefreshIndicator(
//         strokeWidth: 1,
//         color: AppColors.primary,
//         backgroundColor: Colors.white.withValues(alpha: 0.9),
//         onRefresh: ()async {
//           await apartmentCubit.refreshApartments();
//           await roomsCubit.refreshRooms();
//           await myPropertiesCubit.getMyProperties();
//         },
//         child: CustomScrollView(
//           slivers: [
//             SliverList(
//               delegate: SliverChildListDelegate([
//                 HomeHeader(size: size, tabController: _tabController),
//                 SizedBox(height: 16.h),
//                 // discover apartments
//                 ApartmentSection(),
//                 SizedBox(height: 24.h),
//                 // discover rooms
//                 RoomsSection(),
//                 SizedBox(height: 24.h),
//                 AddOrShowMyProperties(),
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }