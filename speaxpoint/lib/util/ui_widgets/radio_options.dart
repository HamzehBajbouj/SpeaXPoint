import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_enums.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

Flexible genderRadioOption(
    {required ValueChanged<bool> onChanged,
    required bool selected,
    required Text text}) {
  return Flexible(
    child: GestureDetector(
      onTap: () {
        onChanged(!selected);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: selected
                  ? Color(AppMainColors.p80)
                  : Color(AppMainColors.p30)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selected
                        ? Color(AppMainColors.p80)
                        : Color(AppMainColors.p30),
                    width: CommonUIProperties.textfiledRoundedEdgesWidth,
                  ),
                  shape: BoxShape.circle,
                  color: selected
                      ? Color(AppMainColors.p50)
                      : Color(AppMainColors.backgroundAndContent),
                ),
              ),
              SizedBox(width: 10),
              text,
            ],
          ),
        ),
      ),
    ),
  );
}
