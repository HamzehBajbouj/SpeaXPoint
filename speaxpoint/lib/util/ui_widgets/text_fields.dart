import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

TextFormField outlineTextField(
    {required TextEditingController controller,
    required String hintText,
    required VoidCallback onChangeCallBack,
    required bool isRequired,
    List<String?>? validators,
    bool? autoFoucs,
    bool? obscured}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(
        fontSize: 17,
        color: Color(AppMainColors.p30),
        fontFamily: CommonUIProperties.fontType,
        fontWeight: FontWeight.normal),
    autofocus: autoFoucs ?? false,
    validator: (value) {
      //check for empty input
      if (isRequired && (value == null || value == '')) {
        return 'Field should not be empty.';
      }
      if (isRequired && validators != null) {
        for (int i = 0; i < validators.length; i++) {
          return validators[i];
        }
      }

      return null;
    },
    onChanged: (data) {
      onChangeCallBack();
    },
    obscureText: obscured ?? false,
    decoration: InputDecoration(
      errorStyle: const TextStyle(fontFamily: CommonUIProperties.fontType),
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(15, 13, 0, 13),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: AppMainColors.warningError,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: AppMainColors.warningError,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.p30),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.p80),
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 17,
        fontFamily: CommonUIProperties.fontType,
        fontWeight: FontWeight.normal,
        color: Color(AppMainColors.p30),
      ),
    ),
  );
}
