import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/view_models/authentication_vm/log_in_view_model.dart';

class ToastmasterDashboardScreen extends StatefulWidget {
  const ToastmasterDashboardScreen({super.key});

  @override
  State<ToastmasterDashboardScreen> createState() =>
      _ToastmasterDashboardScreenState();
}

class _ToastmasterDashboardScreenState
    extends State<ToastmasterDashboardScreen> {
  bool loggedUserIsVPE = false;
  late LogInViewModel _logInViewModel;
  String currentMemberClubRole = "";
  @override
  void initState() {
    super.initState();
    _logInViewModel = Provider.of<LogInViewModel>(context, listen: false);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentMemberClubRole = await _logInViewModel.getDataFromLocalDataBase(
      keySearch: "memberOfficalRole",
    );

    if (currentMemberClubRole ==
        ToastmasterRoles.Vice_President_Education.name.replaceAll("_", " ")) {
      setState(
        () {
          loggedUserIsVPE = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
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
              Visibility(
                visible: loggedUserIsVPE,
                child: InkWell(
                  onTap: () {
                    context.pushRoute(const ManageComingSessionsRouter());
                  },
                  highlightColor: const Color(AppMainColors.selectedOption),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          CommonUIProperties.cardRoundedEdges),
                      border: Border.all(
                        width: 1.3,
                        color: const Color(AppMainColors.p50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "Manage Coming Sessions",
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
                                width: 150,
                                child: Text(
                                  "Manage and prepare incoming chapter meetings sessions.",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(AppMainColors.p40),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              fit: BoxFit.contain,
                              "assets/images/selection.svg",
                              allowDrawingOutsideViewBox: false,
                              width: 160,
                              height: 90,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  context.pushRoute(const SearchChapterMeetingRouter());
                },
                highlightColor: const Color(AppMainColors.selectedOption),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        CommonUIProperties.cardRoundedEdges),
                    border: Border.all(
                      width: 1.3,
                      color: const Color(AppMainColors.p50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Explore Coming Meeting",
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
                              width: 150,
                              child: Text(
                                "Explore and search coming chapter meetings by other clubs.",
                                maxLines: 3,
                                style: TextStyle(
                                  fontFamily: CommonUIProperties.fontType,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(AppMainColors.p40),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SvgPicture.asset(
                            fit: BoxFit.contain,
                            "assets/images/conference_speaker.svg",
                            allowDrawingOutsideViewBox: false,
                            width: 200,
                            height: 150,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
