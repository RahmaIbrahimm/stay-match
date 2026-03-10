import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/features/properties/manager/properties_cubit.dart';
import 'package:stay_match/features/properties/presentation/widgets/property_card.dart';
import 'package:stay_match/features/properties/data/models/get_all_apartments.dart';

import '../../../../core/networking/dio_consumer.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../properties/data/repos/properties_repo_impl.dart';
import 'home_header.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Data>? properties =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              HomeHeader(size: size, tabController: _tabController),
              // todo : all data from network (api)
                Container(
                  // height: size.height * 0.2,
                  // width: size.width * 0.4,
                  color: Colors.lightBlueAccent[100],
                  child: BlocConsumer<PropertiesCubit, PropertiesState>(
                    listener: (context, state) async {
                      if (state is GetPropertiesSuccess) {
                        properties = state.response.data;
                      }
                      if (state is GetPropertiesFailure) {
                        // todo: add snack bar / toast
                      }
                    },
                    builder: (context, state) {
                      // Loading state
                      // todo: custom loading state?
                      if (state is GetPropertiesLoading) {
                        return CircularProgressIndicator();
                      }

                      // Success state - data is HERE
                      else if (state is GetPropertiesSuccess) {
                        if (state.response.data != null && state.response.data!.isNotEmpty) {
                          return CachedNetworkImage(imageUrl:state.response.data![0].coverImageUrl!);
                        } else {
                          // todo: add what would appear when there is no data ?
                          return Text('No data');
                        }
                      }

                      // Failure state
                      else if (state is GetPropertiesFailure) {
                        return Text('Error: ${state.errMessage}');
                      }

                      // Initial state (before any loading)
                      else {
                        return Container(); // or loading, or nothing
                      }
                    },
                  ),
                ),


            ]),
          ),
          SliverFillRemaining(),
        ],
      ),
    );
  }
}
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stay_match/core/networking/dio_consumer.dart';
// import 'package:stay_match/core/utils/service_locator.dart';
// import 'package:stay_match/features/properties/data/models/get_all_apartments.dart';
// import 'package:stay_match/features/properties/data/repos/properties_repo_impl.dart';
// import 'package:stay_match/features/properties/manager/properties_cubit.dart';
//
// class PropertyCard extends StatelessWidget {
//   PropertyCard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }