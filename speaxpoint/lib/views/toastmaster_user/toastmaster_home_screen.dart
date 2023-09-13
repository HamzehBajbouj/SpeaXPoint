import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';

class ToastmasterHomeScreen extends StatefulWidget {
  const ToastmasterHomeScreen({super.key});

  @override
  State<ToastmasterHomeScreen> createState() => _ToastmasterHomeScreenState();
}

class _ToastmasterHomeScreenState extends State<ToastmasterHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      routes: const [
        ToastmasterDashboardRouter(),
        ToastmasterScheduledMeetingsRouter(),
        ToastmasterProfileManagementRouter(),
        RecordedSessionsRouter(),
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
                  Icons.calendar_month_outlined,
                  size: 30,
                ),
                title: const Text('Meetings'),
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
              SalomonBottomBarItem(
                selectedColor: const Color(AppMainColors.p70),
                unselectedColor: const Color(AppMainColors.p40),
                icon: const Icon(
                  Icons.bar_chart_rounded,
                  size: 30,
                ),
                title: const Text('Statistics'),
              ),
            ]);
      },
    );
  }
}
