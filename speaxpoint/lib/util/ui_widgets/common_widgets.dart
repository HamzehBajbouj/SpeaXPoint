import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

SnackBar getSnackBar({required Text text, required Color color}) {
  return SnackBar(
    content: text,
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
}

Widget allocatedRoleCard({
  required String role,
  required int? rolePlace,
  required String playerName,
  required Future<void> Function() deleteAction,
}) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 30,
      maxHeight: 40,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(AppMainColors.p30),
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxWidth: 90),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                maxLines: 2,
                textAlign: TextAlign.center,
                "${role} ${rolePlace ?? ""}",
                style: const TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(AppMainColors.p30),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: 1,
          color: const Color(AppMainColors.p30),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    playerName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color(AppMainColors.p30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await deleteAction();
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Color(AppMainColors.p30),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget allocatedGuestRoleCard({
  required String role,
  required int? rolePlace,
  required String playerName,
  required String guestInvitationCode,
  required Future<void> Function() deleteAction,
}) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 40,
      maxHeight: 50,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(AppMainColors.p30),
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxWidth: 90),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                maxLines: 2,
                textAlign: TextAlign.center,
                "${role} ${rolePlace ?? ""}",
                style: const TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(AppMainColors.p30),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: 1,
          color: const Color(AppMainColors.p30),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        playerName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(AppMainColors.p30),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Invitation Code: $guestInvitationCode",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p30),
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    await deleteAction();
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Color(AppMainColors.p30),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//this is only used in the announce for voluntters
Widget announcedVolunteersSlots({
  required String role,
  required int? rolePlace,
  required void Function() deleteAction,
  required String announcementStatus,
  bool viewMode = true,
}) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 30,
      maxHeight: 40,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: announcementStatus == AppVolunteerSlotStatus.Announced.name
            ? const Color(AppMainColors.announcedVolunteerSlot)
            : const Color(AppMainColors.p30),
        width: 1.3,
      ),
      borderRadius: BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "$role ${rolePlace ?? " "} ${announcementStatus == AppVolunteerSlotStatus.Announced.name ? '*Announced' : ''}"
                    "${announcementStatus == AppVolunteerSlotStatus.UnAnnounced.name ? '*Un-Announced' : ''}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: announcementStatus ==
                              AppVolunteerSlotStatus.Announced.name
                          ? const Color(AppMainColors.announcedVolunteerSlot)
                          : const Color(AppMainColors.p30),
                    ),
                  ),
                ),
                Visibility(
                  visible: viewMode,
                  child: IconButton(
                    onPressed: deleteAction,
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: announcementStatus ==
                              AppVolunteerSlotStatus.Announced.name
                          ? const Color(AppMainColors.announcedVolunteerSlot)
                          : const Color(AppMainColors.p30),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//this widget is only used in view volunteers announcement details in the search for announcements
Widget volunteerViewDetailsSlotCard({
  required String roleName,
  required int rolePlace,
  required Future<void> Function() onTapCallBack,
}) {
  return Material(
    color: const Color(AppMainColors.cardBackground),
    child: InkWell(
      onTap: onTapCallBack,
      splashColor: const Color(AppMainColors.p20),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 40,
          maxHeight: 50,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(AppMainColors.p40),
            width: 1.3,
          ),
          borderRadius:
              BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "$roleName ${rolePlace == 0 ? "" : rolePlace}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: CommonUIProperties.fontType,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(AppMainColors.p50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//it's used in the allocate role players vlounteers tab view
Widget volunteerSlotCard({
  required String role,
  required int? rolePlace,
  required String slotStatus,
  required Future<void> Function() deleteAction,
  required void Function() onCardTap,
  Color cardColor = const Color(AppMainColors.volunteerNoApplicantStatus),
}) {
  return InkWell(
    onTap: onCardTap,
    child: Container(
      constraints: const BoxConstraints(
        minHeight: 30,
        maxHeight: 40,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: cardColor,
          width: 1.3,
        ),
        borderRadius:
            BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 90),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  "${role} ${rolePlace ?? ""}",
                  style: TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: cardColor,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: cardColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Status : $slotStatus",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: CommonUIProperties.fontType,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: cardColor,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: IconButton(
                      iconSize: 35,
                      onPressed: () async {
                        await deleteAction();
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: cardColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget announcementCard({
  required String title,
  required String description,
  required void Function() onCardTap,
  required Future<void> Function() onIconButtonTap,
}) {
  return InkWell(
    onTap: onCardTap,
    highlightColor: const Color(AppMainColors.selectedOption),
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(AppMainColors.p30),
          width: 1.3,
        ),
        borderRadius:
            BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(AppMainColors.p80),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(AppMainColors.p50),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onIconButtonTap,
            icon: const Icon(
              Icons.remove_circle_outline_rounded,
              size: 30,
              color: const Color(AppMainColors.p30),
            ),
          ),
        ],
      ),
    ),
  );
}
