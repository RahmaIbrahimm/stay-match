import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/properties/data/models/get_all_apartments.dart';
import 'package:stay_match/features/properties/data/repos/properties_repo_impl.dart';
import 'package:stay_match/features/properties/manager/properties_cubit.dart';

class PropertyCard extends StatelessWidget {
   PropertyCard({super.key});
  List<Data>? properties =[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            PropertiesCubit(
              PropertiesRepoImpl(apiService: getIt.get<DioConsumer>()),
            )..getAllApartments(),
        child: Container(
          // height: size.height * 0.2,
          // width: size.width * 0.4,
          color: Colors.lightBlueAccent[100],
          child: BlocConsumer<PropertiesCubit, PropertiesState>(
            listener: (context, state) async {
              if (state is GetPropertiesSuccess) {
                properties = state.response.data;
              }
              if (state is GetPropertiesFailure) {
                // todo: add snack bar
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

    );
  }
}