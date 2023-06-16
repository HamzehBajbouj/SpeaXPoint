import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/models/club_account.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:auto_route/auto_route.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/club_president_vm/club_profile_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubProfileManagementScreen extends StatefulWidget {
  const ClubProfileManagementScreen(
      {super.key,
      required this.forViewOnly,
      required this.fromAnnouncementPage,
      this.clubId});
  final bool forViewOnly;
  final bool fromAnnouncementPage;
  final String? clubId;

  @override
  State<ClubProfileManagementScreen> createState() =>
      _ClubProfileManagementScreenState();
}

class _ClubProfileManagementScreenState
    extends State<ClubProfileManagementScreen> {
  late ClubProfileViewModel _clubProfileViewModel;

  @override
  void initState() {
    super.initState();
    _clubProfileViewModel =
        Provider.of<ClubProfileViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: widget.forViewOnly && widget.fromAnnouncementPage
            ? null
            : [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    size: 28,
                    color: Color(AppMainColors.backgroundAndContent),
                  ),
                  onPressed: () {
                    context.pushRoute(const EditClubProfileRouter()).then((_) {
                      setState(() {});
                    });
                  },
                ),
              ],
        leading: widget.forViewOnly && widget.fromAnnouncementPage
            ? const BackButton(
                color: Color(AppMainColors.backgroundAndContent),
              )
            : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Club Profile",
          style: TextStyle(
            fontFamily: CommonUIProperties.fontType,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppMainColors.backgroundAndContent),
          ),
        ),
      ),
      backgroundColor: const Color(AppMainColors.backgroundAndContent),
      body: FutureBuilder(
        future: widget.fromAnnouncementPage
            ? _clubProfileViewModel.getClubDetails(
                getClubIdFromLocalDatabase: false, clubId: widget.clubId!)
            : _clubProfileViewModel.getClubDetails(
                getClubIdFromLocalDatabase: true),
        builder: (
          context,
          AsyncSnapshot<ClubAccount?> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(AppMainColors.p40),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              ClubAccount clubAccount = snapshot.data!;

              if (clubAccount.clubProfileWasSetUp == null ||
                  (clubAccount.clubProfileWasSetUp != null &&
                      !clubAccount.clubProfileWasSetUp!)) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        SvgPicture.asset(
                          fit: BoxFit.fill,
                          "assets/images/searching.svg",
                          allowDrawingOutsideViewBox: false,
                          width: 150,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Could Not Find The Club Profile",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.p90),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 320,
                          child: Text(
                            "We could not find the club profile details, as the club president has not "
                            " created the club profile yet.",
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: CommonUIProperties.fontType,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(AppMainColors.p50),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        outlinedButton(
                            callBack: () {
                              context
                                  .pushRoute(const EditClubProfileRouter())
                                  .then((_) {
                                setState(() {});
                              });
                            },
                            content: "Set Up Now"),
                      ],
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(AppMainColors.p40),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageUrl: clubAccount.backgroundImageURL!,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 130, left: 20),
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.shortestSide / 2,
                                ),
                                border: Border.all(
                                  color: const Color(
                                      AppMainColors.backgroundAndContent),
                                  width: 4,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.shortestSide / 2,
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(AppMainColors.p40),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  imageUrl: clubAccount.profileImageURL!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clubAccount.clubName!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(AppMainColors.p90),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 100, minHeight: 20),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  Text(
                                    clubAccount.profileDescription!,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: clubAccount.clubPhoneNumber != null,
                                  child: Row(
                                    children: [
                                      linksIcons(
                                          action: () async {
                                            final url = Uri.parse(
                                                'tel:${clubAccount.clubPhoneNumber!}');
                                            if (await canLaunchUrl(url)) {
                                              launchUrl(url);
                                            } else {
                                              log("Can't launch $url");
                                            }
                                          },
                                          iconData: Icons.call_outlined),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: clubAccount.webSiteLink != null,
                                  child: Row(
                                    children: [
                                      linksIcons(
                                          action: () async {
                                            final url = Uri.parse(
                                                clubAccount.webSiteLink!);
                                            if (await canLaunchUrl(url)) {
                                              launchUrl(url);
                                            } else {
                                              log("Can't launch $url");
                                            }
                                          },
                                          iconData: Icons.insert_link_rounded),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: clubAccount.officialEmail != null,
                                  child: Row(
                                    children: [
                                      linksIcons(
                                          action: () async {
                                            String email = Uri.encodeComponent(
                                                clubAccount.officialEmail!);
                                            String subject = Uri.encodeComponent(
                                                "Hello ${clubAccount.clubName}");
                                            String body =
                                                Uri.encodeComponent("Hi");
                                            //output: Hello%20Flutter
                                            Uri mail = Uri.parse(
                                                "mailto:$email?subject=$subject&body=$body");
                                            if (await launchUrl(mail)) {
                                              //email app opened
                                            } else {
                                              log("Can't launch $mail");
                                            }
                                          },
                                          iconData: Icons.email_outlined),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: clubAccount.clubLocationLink != null,
                                  child: linksIcons(
                                      action: () async {
                                        final url = Uri.parse(
                                            clubAccount.clubLocationLink!);
                                        if (await canLaunchUrl(url)) {
                                          launchUrl(url);
                                        } else {
                                          log("Can't launch $url");
                                        }
                                      },
                                      iconData: Icons.location_on_outlined),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clubAccount.clubOverviewTitle!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: CommonUIProperties.fontType,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(AppMainColors.p90),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 300,
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      Text(
                                        clubAccount.clubOverviewDescription!,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          fontFamily:
                                              CommonUIProperties.fontType,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Color(AppMainColors.p50),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            } else {
              return const Center(
                  child: Text("You Have not set up the club profile yet"));
            }
          } else {
            return Text(
              'State: ${snapshot.connectionState}',
              style: const TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(AppMainColors.warningError75),
              ),
            );
          }
        },
      ),
    );
  }

  Widget linksIcons(
      {required VoidCallback action, required IconData iconData}) {
    return InkWell(
      onTap: action,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(AppMainColors.p30),
            width: 1.5,
          ),
          borderRadius:
              BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
        ),
        child: Icon(
          iconData,
          size: 35,
          color: const Color(AppMainColors.p30),
        ),
      ),
    );
  }
}
