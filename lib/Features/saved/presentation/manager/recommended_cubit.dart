import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/saved/data/models/recommended_properties_response.dart';

import '../../data/repos/saved_properties_repo_impl.dart';

part 'recommended_state.dart';

class RecommendedCubit extends Cubit<RecommendedState> {
  final SavedPropertiesRepoImpl repo;

  RecommendedCubit(this.repo) : super(RecommendedInitial()) {
    fetchRecommendations();
  }

  Future<void> fetchRecommendations({int limit = 2}) async {
    // 1. Check if we already have data visible
    if (state is RecommendedSuccess) {
      final currentResponse = (state as RecommendedSuccess).response;
      emit(RecommendedMoreLoading(currentResponse: currentResponse));
    } else {
      emit(RecommendedLoading());
    }

    // 2. Fetch data with the updated limit
    final response = await repo.getRecommendedProperties(limit: limit);

    response.fold(
          (fail) => emit(RecommendedFailure(errMessage: fail.errMessage)),
          (resp) => emit(RecommendedSuccess(response: resp)),
    );
  }
}