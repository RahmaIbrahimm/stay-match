import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'other_user_profile_state.dart';

class OtherUserProfileCubit extends Cubit<OtherUserProfileState> {
  OtherUserProfileCubit() : super(OtherUserProfileInitial());
}