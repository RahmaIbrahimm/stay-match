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
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  bool get wantKeepAlive => true; // Keeps state alive
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      child: RefreshIndicator(
        backgroundColor: AppColors.containerColor,
        strokeWidth: 1,
        color: AppColors.primary,
        onRefresh: ()async {
          await context.read<ApartmentCubit>().refreshApartments();
          await context.read<RoomsCubit>().refreshRooms();
          await context.read<MyPropertiesCubit>().getMyProperties();
          // todo: add refreshing my properties
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