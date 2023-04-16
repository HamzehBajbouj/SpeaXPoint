import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speaxpoint/models/toastmaster.dart';
import 'package:speaxpoint/models/volunteer_slot.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';
import 'package:speaxpoint/view_models/toastmaster_vm/allocate_role_players_view_model.dart';

class ManageVolunteerSlotBottomSheet extends StatefulWidget {
  const ManageVolunteerSlotBottomSheet({
    super.key,
    required this.chapterMeetingId,
    required this.slotDetails,
  });
  final String chapterMeetingId;
  final VolunteerSlot slotDetails;
  @override
  State<ManageVolunteerSlotBottomSheet> createState() =>
      _EditTicketBottomSheetState();
}

class _EditTicketBottomSheetState
    extends State<ManageVolunteerSlotBottomSheet> {
  late AllocateRolePlayersViewModel _allocateRolePlayersViewModel;

  late Future<List<Toastmaster>> _applicants;
  late Toastmaster _selectedApplicant;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _initMemberListAndStates();
  }

  void _initMemberListAndStates() async {
    _applicants = _allocateRolePlayersViewModel.getSlotApplicants(
        chapterMeetingId: widget.chapterMeetingId,
        slotUnqiueId: widget.slotDetails.slotUnqiueId!);
    _applicants.then((list) {
      _selectedApplicant = list[0];
      //we need to call it to update redrae the states/widgets after we got the results
      setState(
        () {},
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _allocateRolePlayersViewModel =
        Provider.of<AllocateRolePlayersViewModel>(context, listen: false);
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
                  "Volunteer Slot Details",
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
                    if (widget.slotDetails.slotStatus ==
                        VolunteerSlotStatus.PendingApplication.name) {
                      await _allocateRolePlayersViewModel
                          .acceptSlotApplicant(
                              chapterMeetingId: widget.chapterMeetingId,
                              slot: widget.slotDetails,
                              selectedApplicant: _selectedApplicant)
                          .then(
                        (_) {
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  content: Text(
                    widget.slotDetails.slotStatus ==
                            VolunteerSlotStatus.PendingApplication.name
                        ? "Accept"
                        : "Close",
                    style: const TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            getSlotStatusRespectiveView(widget.slotDetails.slotStatus),
          ],
        ),
      ),
    );
  }

  Widget getSlotStatusRespectiveView(String? status) {
    if (status == VolunteerSlotStatus.AcceptedApplication.name) {
      return Container(child: Text("applicants details"));
    } else if (status == VolunteerSlotStatus.PendingApplication.name) {
      return FutureBuilder(
        future: _applicants,
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
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return snapshot.data!.isEmpty
                  ? const Center(
                      child: Text(
                        "There are no applicants",
                        style: TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 19,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Applicants Names",
                          style: TextStyle(
                            fontFamily: CommonUIProperties.fontType,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Color(AppMainColors.p80),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              setState(() {
                                _selectedApplicant = snapshot.data![value];
                              });
                            },
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            controller:
                                FixedExtentScrollController(initialItem: 0),
                            physics: const FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: snapshot.data!.length,
                              builder: (context, index) {
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    snapshot.data![index].toastmasterName ??
                                        " ",
                                    style: const TextStyle(
                                      fontFamily: CommonUIProperties.fontType,
                                      fontSize: 17,
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
                    );
            } else {
              return const Text("Error: unable to fetch club members");
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
      );
    } else {
      return Center(
        child: Column(
          children: const [
            Text(
              "Opps...",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color(AppMainColors.p80),
              ),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              "It seems that there are not apllicants currently for this role. ",
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color(AppMainColors.p50),
              ),
            ),
          ],
        ),
      );
    }
  }
}
