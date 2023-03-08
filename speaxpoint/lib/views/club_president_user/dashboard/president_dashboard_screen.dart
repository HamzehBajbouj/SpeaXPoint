import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:auto_route/auto_route.dart';

class PresidentDashboardScreen extends StatelessWidget {
  const PresidentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Quick Access",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(AppMainColors.p90),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                context.router.navigate(const ClubProfileManagementRouter());
              },
              highlightColor: const Color(AppMainColors.selectedOption),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.3,
                    color: const Color(AppMainColors.p50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Manage Club Profile",
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(AppMainColors.p80),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 130,
                            child: Text(
                              "To Edit your club's name, photo, website link and contact number.",
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: Color(AppMainColors.p40),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        fit: BoxFit.fill,
                        "assets/images/personal_info.svg",
                        allowDrawingOutsideViewBox: false,
                        width: 150,
                        height: 80,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {
                context.router.push(const ClubMembersManagementRouter());
              },
              highlightColor: const Color(AppMainColors.selectedOption),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.3,
                    color: const Color(AppMainColors.p50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        fit: BoxFit.fill,
                        "assets/images/people.svg",
                        allowDrawingOutsideViewBox: false,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Manage Club Members",
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(AppMainColors.p80),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 130,
                            child: Text(
                              "To register your club's member and assign their roles.",
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: Color(AppMainColors.p40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
