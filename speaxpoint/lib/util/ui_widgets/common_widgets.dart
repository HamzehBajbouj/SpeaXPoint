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
                    "$role ${rolePlace ?? " "}",
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
