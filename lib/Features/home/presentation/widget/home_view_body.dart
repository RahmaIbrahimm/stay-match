import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/apartments/presentation/manager/apartment_cubit.dart';
import 'package:stay_match/Features/home/presentation/widget/rooms_section.dart';
import 'package:stay_match/Features/my_properties/presentation/manager/my_properties_cubit.dart';
import 'package:stay_match/Features/rooms/presentation/manager/rooms_cubit.dart';
import 'package:stay_match/core/constants/app_colors.dart';

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
            SliverList(
              delegate: SliverChildListDelegate([
                HomeHeader(size: size, tabController: _tabController),
                SizedBox(height: 16.h),
                // discover apartments
                ApartmentSection(),
                SizedBox(height: 24.h),
                // discover rooms
                RoomsSection(),
                SizedBox(height: 24.h),
                AddOrShowMyProperties(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}