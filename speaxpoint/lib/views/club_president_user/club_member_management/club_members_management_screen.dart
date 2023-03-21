import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:auto_route/auto_route.dart';

class ClubMembersManagementScreen extends StatefulWidget {
  const ClubMembersManagementScreen(
      {super.key, @PathParam("fromSetUp") required this.fromSetUpRouter});

  final bool fromSetUpRouter;

  @override
  State<ClubMembersManagementScreen> createState() =>
      _ClubMembersManagementScreenState();
}

class _ClubMembersManagementScreenState
    extends State<ClubMembersManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Color(AppMainColors.p70),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Manage Members",
            style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(AppMainColors.p70),
            ),
          ),
        ),
        backgroundColor: Color(AppMainColors.backgroundAndContent),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Club Members",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(AppMainColors.p70),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.fromSetUpRouter) {
                          context.pushRoute(SetAndManageMemberAccountRouter(
                              isInEditMode: false));
                        } else {
                          context.pushRoute(
                              ManageAccountRouter(isInEditMode: false));
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(AppMainColors.p5),
                          shape: BoxShape.rectangle,
                        ),
                        child: const Center(
                          child: Text(
                            "New +",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(AppMainColors.p70),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                outlineTextFiledWithLeadingIcon(
                  controller: TextEditingController(),
                  hintText: "Search for a Member",
                  onChangeCallBack: (data) {
                    null;
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Color(AppMainColors.p20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  margin: const EdgeInsets.all(0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        CommonUIProperties.cardRoundedEdges),
                    side: const BorderSide(
                      width: 1.3,
                      style: BorderStyle.solid,
                      color: Color(AppMainColors.p20),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          width: 45,
                          height: 45,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageUrl:
                              "https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg"),
                    ),
                    title: const Text(
                      "Hamzeh Bajbouj",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(AppMainColors.p90),
                      ),
                    ),
                    subtitle: const Text(
                      "Vice president of education",
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Color(AppMainColors.p40),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        if (widget.fromSetUpRouter) {
                          //here we are able to go to the ClubProfileManagementSetUpRouter but when we try ManageMemberAccountSetUpRouter we go no where
                          context.pushRoute(SetAndManageMemberAccountRouter(
                              isInEditMode: true));
                        } else {
                          //this one works but it doesn't include the return navigation button
                          // context.router.pushNamed(
                          //     "/clubPresidentHomeScreen/clubPresidentDashboard/manageMemberAccount/true");
                          //this one is the correct one
                          context.pushRoute(
                              ManageAccountRouter(isInEditMode: true));
                        }
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Color(AppMainColors.p40),
                        size: 23,
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
