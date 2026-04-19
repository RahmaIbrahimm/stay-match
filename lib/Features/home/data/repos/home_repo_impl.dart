import 'package:stay_match/core/networking/api_service.dart';

import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  ApiService apiService;
  HomeRepoImpl({required this.apiService});
}