import 'package:flutter/material.dart';
import 'package:stay_match/features/home/presentation/views/widget/home_nav_bar.dart';
import 'package:stay_match/features/home/presentation/views/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body:  HomeViewBody(),
        bottomNavigationBar: HomeNavBar(),
      ),
    );
  }
}