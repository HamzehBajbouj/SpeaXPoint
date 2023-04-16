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
Widget availableVolunteersSlots({
  required String role,
  required int? rolePlace,
  required void Function() deleteAction,
  required String slotStatus,
}) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 30,
      maxHeight: 40,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        color: slotStatus == AppVolunteerSlotStatus.Announced.name
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
                    "$role ${rolePlace ?? " "} ${slotStatus == AppVolunteerSlotStatus.Announced.name ? '*Announced' : ''}"
                    "${slotStatus == AppVolunteerSlotStatus.UnAnnounced.name ? '*Un-Announced' : ''}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: CommonUIProperties.fontType,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: slotStatus == AppVolunteerSlotStatus.Announced.name
                          ? const Color(AppMainColors.announcedVolunteerSlot)
                          : const Color(AppMainColors.p30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: deleteAction,
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: slotStatus == AppVolunteerSlotStatus.Announced.name
                        ? const Color(AppMainColors.announcedVolunteerSlot)
                        : const Color(AppMainColors.p30),
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
