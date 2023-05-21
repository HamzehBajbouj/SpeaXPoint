import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';
import 'package:speaxpoint/views/toastmaster_user/allocate_role_players/update_existing_role_player_dialog.dart';

class AddClubMemberRolePlayerBottomSheet extends StatefulWidget {
  final String chapterMeetingId;
  final String clubId;
  const AddClubMemberRolePlayerBottomSheet({
    super.key,
    required this.chapterMeetingId,
    required this.clubId,
  });

  @override
  State<AddClubMemberRolePlayerBottomSheet> createState() =>
      _AddClubMemberRolePlayerBottomSheetState();
}

class _AddClubMemberRolePlayerBottomSheetState
    extends State<AddClubMemberRolePlayerBottomSheet> {
  late AllocateRolePlayersViewModel _allocateRolePlayersVM;
  List<String> listOfRole = LisrOfRolesPlayers.values
      .map((e) => e.name.replaceAll('_', ' '))
      .toList();

  bool _showRoleNumber = true;
  bool _clubHasMembers = false;
  //these are the initiail data which will be updated whenever the scrollers are change
  String _roleName = LisrOfRolesPlayers.Speaker.name;
  int _rolePlace = 1;
  late Toastmaster _selectedClubMember;
  int _lengthOfListMembers = 0;
  late Future<List<Toastmaster>> _listMmebers;

  @override
  void initState() {
    super.initState();
    _allocateRolePlayersVM =
        Provider.of<AllocateRolePlayersViewModel>(context, listen: false);
    listOfRole.remove(LisrOfRolesPlayers.MeetingVisitor.name);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _initMemberListAndStates();
  }

  void _initMemberListAndStates() async {
    _listMmebers = _allocateRolePlayersVM.getClubMemberList(widget.clubId);
    await _listMmebers.then(
      (list) {
        _clubHasMembers = list.isNotEmpty;
        _selectedClubMember = list[0];
        //we need to call it to update redrae the states/widgets after we got the results
        //to hide the widgets accroding to _clubHasMembers variable
        setState(
          () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select Role Player",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p80),
                  ),
                ),
                textButton(
                  callBack: () async {
                    await _allocateRolePlayersVM
                        .validateRoleAvailability(
                            widget.chapterMeetingId, _roleName, _rolePlace)
                        .then(
                      (value) {
                        value.whenSuccess(
                          (success) async {
                            if (success) {
                              //when succes is true it mean that there is no existing role player
                              //with the same role and place order
                              await _allocateRolePlayersVM
                                  .allocateNewPlayerFromClub(
                                      widget.chapterMeetingId,
                                      _selectedClubMember,
                                      _roleName,
                                      _rolePlace,
                                      AllocatedRolePlayerType.ClubMember.name)
                                  .then(
                                (value) {
                                  value.whenSuccess(
                                    (_) {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            } else {
                              //display dialog when the role is occupid by another toastmaster
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return UpdateExitingRolePlayerDialog(
                                    guestName: null,
                                    chapterMeetingId: widget.chapterMeetingId,
                                    roleName: _roleName,
                                    rolePlace: _rolePlace,
                                    selectedToastmaster: _selectedClubMember,
                                    allocatedRolePlayerType:
                                        AllocatedRolePlayerType.ClubMember.name,
                                  );
                                },
                              ).then(
                                (_) {
                                  Navigator.pop(context);
                                },
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  content: const Text(
                    "Confirm",
                    style: TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                FutureBuilder(
                  future: _listMmebers,
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
                      if (snapshot.hasData) {
                        return snapshot.data!.isEmpty
                            ? const Center(child: Text("Club Has No Members"))
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Member Name",
                                      style: TextStyle(
                                        fontFamily: CommonUIProperties.fontType,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(AppMainColors.p80),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: 200,
                                      height: 150,
                                      child: ListWheelScrollView.useDelegate(
                                        onSelectedItemChanged: (value) {
                                          setState(() {
                                            _selectedClubMember =
                                                snapshot.data![value];
                                          });
                                        },
                                        itemExtent: 50,
                                        perspective: 0.005,
                                        diameterRatio: 1.2,
                                        controller: FixedExtentScrollController(
                                            initialItem: 0),
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        childDelegate:
                                            ListWheelChildBuilderDelegate(
                                          childCount: snapshot.data!.length,
                                          builder: (context, index) {
                                            return FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                snapshot.data![index]
                                                        .toastmasterName ??
                                                    " ",
                                                style: const TextStyle(
                                                  fontFamily: CommonUIProperties
                                                      .fontType,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                  color:
                                                      Color(AppMainColors.p60),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      } else {
                        return const Text(
                            "Error: unable to fetch club members");
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
                const SizedBox(
                  width: 15,
                ),
                Visibility(
                  visible: _clubHasMembers,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Member Role",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 70,
                          height: 150,
                          child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              String currentSelectRole = listOfRole[value];
                              if (currentSelectRole == "Speaker" ||
                                  currentSelectRole ==
                                      LisrOfRolesPlayers.Speach_Evaluator.name
                                          .replaceAll("_", " ")) {
                                setState(() {
                                  _showRoleNumber = true;
                                  _roleName = listOfRole[value];
                                });
                              } else {
                                setState(() {
                                  _showRoleNumber = false;
                                  _roleName = listOfRole[value];
                                  //this part is importantlly need, because when the rolePlace
                                  //is hidden it will keep the previous value which leads to allow
                                  //having Ah counter 1 , Ah counter 2 , so it's important to update it
                                  _rolePlace = 1;
                                });
                              }
                            },
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            controller:
                                FixedExtentScrollController(initialItem: 0),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: listOfRole.length,
                              builder: (context, index) {
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    listOfRole[index],
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p60),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _showRoleNumber && _clubHasMembers,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Role Place",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 70,
                          height: 150,
                          child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              setState(() {
                                _rolePlace = value + 1;
                              });
                            },
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 20,
                              builder: (context, index) {
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    (index + 1).toString(),
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Color(AppMainColors.p60),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
