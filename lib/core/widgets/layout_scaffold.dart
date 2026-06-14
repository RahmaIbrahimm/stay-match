import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/widgets/nav_bar.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavBar(navigationShell: navigationShell),
    );
  }
}