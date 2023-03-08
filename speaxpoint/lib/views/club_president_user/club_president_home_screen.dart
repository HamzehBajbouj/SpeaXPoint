import 'package:auto_route/auto_route.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:flutter/material.dart';

class ClubPresidentHomeScreen extends StatelessWidget {
  const ClubPresidentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        backgroundColor: const Color(AppMainColors.backgroundAndContent),
        routes: const [
          ClubPresidentDashboardRouter(),
          ClubProfileManagementRouter()
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return SalomonBottomBar(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: [
                SalomonBottomBarItem(
                  selectedColor: const Color(AppMainColors.p70),
                  unselectedColor: const Color(AppMainColors.p40),
                  icon: const Icon(
                    Icons.home_filled,
                    size: 30,
                  ),
                  title: const Text('Home'),
                ),
                SalomonBottomBarItem(
                  selectedColor: const Color(AppMainColors.p70),
                  unselectedColor: const Color(AppMainColors.p40),
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  title: const Text('Profile'),
                ),
              ]);
        });
  }
}
