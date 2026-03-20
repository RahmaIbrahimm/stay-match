import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stay_match/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

}