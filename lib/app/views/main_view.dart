import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../controllers/persistent_navigation_controller.dart';

class MainView extends GetView<PersistentNavigationController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      screens: controller.buildScreens(),
      items: controller.navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}