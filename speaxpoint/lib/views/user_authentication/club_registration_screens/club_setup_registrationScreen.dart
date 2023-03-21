import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart' as ui_widget;
import 'package:auto_route/auto_route.dart';

class ClubSetUpRegistrationScreen extends StatefulWidget {
  const ClubSetUpRegistrationScreen({super.key});

  @override
  State<ClubSetUpRegistrationScreen> createState() =>
      _ClubSetUpRegistrationState();
}

class _ClubSetUpRegistrationState extends State<ClubSetUpRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "SpeaXPoint",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 41,
                          fontWeight: FontWeight.w600,
                          color: Color(AppMainColors.p100),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "One step left! set up your club profile and members.",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p80),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () {
                        context.pushRoute(ClubProfileManagementSetUpRouter());
                        // .push(const );
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
                        // context.router.push(ClubMembersManagementSetUpRouter(
                        //     fromSetUpRouter: true));
                        print(
                            "dddddd 1" + context.router.currentPath.toString());
                        // context.router.pushNamed(
                        //     "/clubRegistration/clubUsernameRegistration/clubMembersManagementSetUp/true");

                        context.pushRoute(ClubMembersManagementSetUpRouter(
                            fromSetUpRouter: true));

                        print(
                            "dddddd 2" + context.router.currentPath.toString());
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
                Column(
                  children: [
                    ui_widget.filledTextButton(
                        callBack: () {
                          context.router.pushAndPopUntil(
                              const ClubPresidentHomeRouter(),
                              predicate: ModalRoute.withName(
                                  ClubPresidentHomeRouter.name));
                        },
                        content: "Skip For Now"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
