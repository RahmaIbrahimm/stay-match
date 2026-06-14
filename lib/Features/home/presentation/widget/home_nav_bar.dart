import 'package:flutter/material.dart';

import '../../../../../core/constants/app_icons.dart';
import 'custom_bottom_nav_button.dart';

class HomeNavBar extends StatelessWidget {
  HomeNavBar({super.key});

  final List<Widget> navBarDestinations = [
    // file exchange
    NavigationDestination(
      icon: CustomBottomNavButton(
        onPressed: () {},
        icon: ImageIcon(AssetImage(AppIcons.folderExchangeIcon)),
      ),
      label: '',
    ),
    // grid
    NavigationDestination(
      icon: CustomBottomNavButton(
        onPressed: () {},
        icon: ImageIcon(AssetImage(AppIcons.gridIcon)),
      ),
      label: '',
    ),
    // add circle
    NavigationDestination(
      icon: CustomBottomNavButton(
        onPressed: () {},
        icon: ImageIcon(AssetImage(AppIcons.addCircleIcon)),
      ),
      label: '',
    ),
    // home
    NavigationDestination(
      icon: CustomBottomNavButton(
        onPressed: () {},
        icon: ImageIcon(AssetImage(AppIcons.homeIcon)),
      ),
      label: '',
    ),
    // chat bubble
    NavigationDestination(
      icon: CustomBottomNavButton(
        onPressed: () {},
        icon: ImageIcon(AssetImage(AppIcons.chatBubbleIcon)),
      ),
      label: '',
    ),
    // profile
    NavigationDestination(
      icon: CustomBottomNavButton(
        onPressed: () {},
        icon: ImageIcon(AssetImage(AppIcons.profileIcon)),
      ),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.white,

      destinations: navBarDestinations,
      backgroundColor: Colors.transparent,
    );
  }
}