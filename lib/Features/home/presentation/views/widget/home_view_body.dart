import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // return ListView(
    //   padding: EdgeInsets.all(16),
    //   children: [
    //     Container(
    //       height: size.height * 0.25,
    //       width: double.infinity,
    //       padding: EdgeInsets.symmetric(horizontal: 18),
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage(AppImages.homeHeader),
    //           fit: BoxFit.cover,
    //         ),
    //         borderRadius: BorderRadius.circular(15),
    //       ),
    //       clipBehavior: Clip.antiAlias,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 '${AppStrings.stayMatch} ',
    //                 style: AppStyles.logo.copyWith(
    //                   color: AppColors.textColorWhite,
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Text(
    //                   AppStrings.homeHeader,
    //                   style: AppStyles.secondary.copyWith(
    //                     color: AppColors.textColorWhite,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           TabBar(
    //             controller: _tabController,
    //             tabs: [Text('data'), Text('data')],
    //           ),
    //         ],
    //       ),
    //     ),
    //     Expanded(
    //       child: TabBarView(
    //         controller: _tabController,
    //         children: [
    //           Text(
    //             'sldkfsdklflsdkflskddddddddddddddd',
    //             style: TextStyle(fontSize: 50),
    //           ),
    //           Text(
    //             'sldkfsdklflsdkflskddddddddddddddd',
    //             style: TextStyle(fontSize: 50),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: size.height * 0.25,
          floating: true,
          pinned: true,
          title: Container(
              height: size.height * 0.25,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${AppStrings.stayMatch} ',
                        style: AppStyles.logo.copyWith(
                          color: AppColors.textColorWhite,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          AppStrings.homeHeader,
                          style: AppStyles.secondary.copyWith(
                            color: AppColors.textColorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: [Text('data'), Text('data')],
                  ),
                ],
              ),
            ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            background: Image.asset(AppImages.homeHeader, fit: BoxFit.cover),
            expandedTitleScale: 1,
            title: CustomTextFormField(hintText: 'hintText', validator: (v){}, controller: TextEditingController()),
          ),
        ),
        // SliverAppBar(
        //   expandedHeight: size.height * 0.25,
        //   floating: false,
        //   pinned: true,
        //   snap: false,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   flexibleSpace: FlexibleSpaceBar(
        //     collapseMode: CollapseMode.pin,
        //     titlePadding: EdgeInsets.zero,
        //     title: LayoutBuilder(
        //       builder: (context, constraints) {
        //         final double appBarHeight = constraints.biggest.height;
        //         final double expandedHeight = 220;
        //         final double collapsedHeight = kToolbarHeight + 60;
        //
        //         double collapseProgress =
        //             (expandedHeight - appBarHeight) /
        //             (expandedHeight - collapsedHeight);
        //         collapseProgress = collapseProgress.clamp(0.0, 1.0);
        //
        //         final double topSectionOpacity = (1 - collapseProgress * 1.5)
        //             .clamp(0.0, 1.0);
        //         final double middleSectionOpacity = (1 - collapseProgress * 1.3)
        //             .clamp(0.0, 1.0);
        //
        //         return Container(
        //           color: Colors.white,
        //           height: appBarHeight,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               if (topSectionOpacity > 0)
        //                 Opacity(
        //                   opacity: topSectionOpacity,
        //                   child: Container(
        //                     padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                       Row(
        //                               crossAxisAlignment: CrossAxisAlignment.start,
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               children: [
        //                                 Text(
        //                                   '${AppStrings.stayMatch} ',
        //                                   style: AppStyles.logo.copyWith(
        //                                     color: AppColors.textColorWhite,
        //                                   ),
        //                                 ),
        //                                 Expanded(
        //                                   child: Text(
        //                                     AppStrings.homeHeader,
        //                                     style: AppStyles.secondary.copyWith(
        //                                       color: AppColors.textColorWhite,
        //                                       fontWeight: FontWeight.bold,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),                                Row(children: []),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //
        //               Row(
        //                 children: [
        //                   Expanded(
        //                     child: CustomTextFormField(
        //                       hintText: collapseProgress > 0.5
        //                           ? 'Search...'
        //                           : 'Search apartments, rooms...',
        //                       validator: (String? p1) {},
        //                       controller: TextEditingController(),
        //                     ),
        //                   ),
        //                   const SizedBox(width: 8),
        //                   Container(
        //                     height: 46,
        //                     padding: const EdgeInsets.symmetric(horizontal: 16),
        //                     decoration: BoxDecoration(
        //                       color: Colors.blue,
        //                       borderRadius: BorderRadius.circular(12),
        //                     ),
        //                     child: const Center(
        //                       child: Text(
        //                         'Search',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontWeight: FontWeight.w500,
        //                           fontSize: 14,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //
        //               if (collapseProgress > 0.7)
        //                 Container(
        //                   margin: const EdgeInsets.only(bottom: 4),
        //                   child: Container(
        //                     width: 36,
        //                     height: 4,
        //                     decoration: BoxDecoration(
        //                       color: Colors.grey.shade300,
        //                       borderRadius: BorderRadius.circular(10),
        //                     ),
        //                   ),
        //                 ),
        //             ],
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        SliverFillRemaining(),
        // SliverList.builder(
        //   itemBuilder: (context, index) {
        //     return Text('sdffffffffffasd', style: TextStyle(fontSize: 50));
        //   },
        //   itemCount: 25,
        // ),
        // SliverResizingHeader(
        //   maxExtentPrototype: CustomTextFormField(hintText: 'hintText', validator: (v){}, controller: TextEditingController()),
        //   child: Container(
        //   height: size.height * 0.25,
        //   width: double.infinity,
        //   padding: EdgeInsets.symmetric(horizontal: 18),
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(AppImages.homeHeader),
        //       fit: BoxFit.cover,
        //     ),
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        //   clipBehavior: Clip.antiAlias,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             '${AppStrings.stayMatch} ',
        //             style: AppStyles.logo.copyWith(
        //               color: AppColors.textColorWhite,
        //             ),
        //           ),
        //           Expanded(
        //             child: Text(
        //               AppStrings.homeHeader,
        //               style: AppStyles.secondary.copyWith(
        //                 color: AppColors.textColorWhite,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       TabBar(
        //         controller: _tabController,
        //         tabs: [Text('data'), Text('data')],
        //       ),
        //     ],
        //   ),
        // ),
        // )
      ],
    );
  }
}