import 'package:stay_match/core/networking/api_service.dart';

import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl(this.apiService);
  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}