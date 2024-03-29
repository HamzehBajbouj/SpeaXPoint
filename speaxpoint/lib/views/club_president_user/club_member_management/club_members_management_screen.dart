import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/app/app_routes.gr.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/text_fields.dart';
import 'package:auto_route/auto_route.dart';
import 'package:speaxpoint/view_models/club_president_vm/club_members_management_view_model.dart';
import 'package:speaxpoint/view_models/club_president_vm/manage_member_account_view_model.dart';

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
  String _search = "";
  ClubMembersManagementViewModel? _clubMembersManagementViewModel;

  @override
  void initState() {
    super.initState();
    _clubMembersManagementViewModel =
        Provider.of<ClubMembersManagementViewModel>(context, listen: false);
  }

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
        backgroundColor: const Color(AppMainColors.backgroundAndContent),
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
                          context
                              .pushRoute(SetAndManageMemberAccountRouter(
                                  isInEditMode: false))
                              .then(
                                //this is to refresh the page when coming back to this page again
                                (_) => setState(() {}),
                              );
                        } else {
                          context
                              .pushRoute(ManageAccountRouter(
                                  isInEditMode: false,
                                  isTheUserPresidentl: true))
                              .then(
                                (_) => setState(() {}),
                              );
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
                  hintText: "Search for a Member",
                  onChangeCallBack: (data) {
                    setState(() {
                      _search = data;
                    });
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
                Expanded(
                  child: FutureBuilder(
                    future:
                        _clubMembersManagementViewModel!.getAllMembersDetails(),
                    builder: (
                      context,
                      AsyncSnapshot<List<Toastmaster>> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(AppMainColors.p40),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data![index].toastmasterName!
                                      .toLowerCase()
                                      .contains(_search)
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                      child: Card(
                                        margin: const EdgeInsets.all(0),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              CommonUIProperties
                                                  .cardRoundedEdges),
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
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                width: 45,
                                                height: 45,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(
                                                                    color: Color(AppMainColors.p40),

                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                imageUrl:
                                                    "https://www.incimages.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg"),
                                          ),
                                          title: Text(
                                            snapshot
                                                .data![index].toastmasterName!,
                                            style: const TextStyle(
                                              fontFamily:
                                                  CommonUIProperties.fontType,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color(AppMainColors.p90),
                                            ),
                                          ),
                                          subtitle: Text(
                                            snapshot.data![index]
                                                .memberOfficalRole!,
                                            style: const TextStyle(
                                              fontFamily:
                                                  CommonUIProperties.fontType,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Color(AppMainColors.p40),
                                            ),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              if (widget.fromSetUpRouter) {
                                                context
                                                    .pushRoute(
                                                        SetAndManageMemberAccountRouter(
                                                            isInEditMode: true))
                                                    .then(
                                                      (_) => setState(() {}),
                                                    );
                                              } else {
                                                context
                                                    .pushRoute(
                                                      ManageAccountRouter(
                                                        isInEditMode: true,
                                                        isTheUserPresidentl:
                                                            true,
                                                        userId: snapshot
                                                            .data![index]
                                                            .toastmasterId!,
                                                      ),
                                                    )
                                                    .then(
                                                      (_) => setState(() {}),
                                                    );
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.settings_outlined,
                                              color: Color(AppMainColors.p40),
                                              size: 23,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'There are not Members Currently in the Club',
                              style: TextStyle(
                                fontFamily: CommonUIProperties.fontType,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Color(AppMainColors.p70),
                              ),
                            ),
                          );
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
                )
              ],
            ),
          ),
        ));
  }
}
