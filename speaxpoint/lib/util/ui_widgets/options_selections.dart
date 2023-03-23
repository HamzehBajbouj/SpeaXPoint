import 'package:dropdown_button2/dropdown_button2.dart';
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

DropdownButtonFormField2<String> dropdownMenu({
  required String initialValue,
  required Icon icon,
  required List<String> items,
  required Function(String?) onChangeCallBack,
  required bool isRequired,
}) {
  return DropdownButtonFormField2<String>(
    validator: (value) {
      if (isRequired && (value == null || value == '')) {
        return 'Option should not be empty.';
      }
    },
    value: initialValue,
    iconStyleData: IconStyleData(icon: icon),
    dropdownStyleData: const DropdownStyleData(
      isOverButton: false,
      maxHeight: 200,
    ),
    items: items.map<DropdownMenuItem<String>>(
      (String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 17,
                color: Color(AppMainColors.p80),
                fontFamily: CommonUIProperties.fontType,
                fontWeight: FontWeight.normal),
          ),
        );
      },
    ).toList(),
    onChanged: onChangeCallBack,
    decoration: const InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(0, 13, 15, 13),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.p30),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.p80),
        ),
      ),
    ),
  );
}
