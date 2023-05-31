import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

TextFormField outlineTextField(
    {required TextEditingController controller,
    required String hintText,
    Function(String)? onChangeCallBack,
    required bool isRequired,
    required TextInputType keyboardType,
    bool readOnly = false,
    int maxLines = 1,
    List<String?>? validators,
    bool? autoFoucs,
    bool? obscured}) {
  return TextFormField(
    maxLines: maxLines,
    keyboardType: keyboardType,
    readOnly: readOnly,
    controller: controller,
    style: const TextStyle(
        fontSize: 17,
        color: Color(AppMainColors.p80),
        fontFamily: CommonUIProperties.fontType,
        fontWeight: FontWeight.normal),
    autofocus: autoFoucs ?? false,
    validator: (value) {
      //check for empty input
      if (isRequired && (value == null || value == '')) {
        return 'This field should not be empty.';
      }
      if (isRequired && validators != null) {
        for (int i = 0; i < validators.length; i++) {
          return validators[i];
        }
      }

      return null;
    },
    onChanged: onChangeCallBack,
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
          color: Color(AppMainColors.warningError75),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.warningError75),
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

TextField outlineTextFiledWithLeadingIcon(
    {TextEditingController? controller,
    required String hintText,
    required Function(String value) onChangeCallBack,
    required Icon icon}) {
  return TextField(
    controller: controller,
    style: const TextStyle(
        fontSize: 17,
        color: Color(AppMainColors.p80),
        fontFamily: CommonUIProperties.fontType,
        fontWeight: FontWeight.normal),
    onChanged: (data) {
      onChangeCallBack(data);
    },
    decoration: InputDecoration(
      errorStyle: const TextStyle(fontFamily: CommonUIProperties.fontType),
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.p20),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.p50),
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 17,
        fontFamily: CommonUIProperties.fontType,
        fontWeight: FontWeight.normal,
        color: Color(AppMainColors.p20),
      ),
      prefixIcon: icon,
    ),
  );
}

TextFormField outlineTextFieldWithTrailingIcon(
    {required TextEditingController controller,
    required String hintText,
    required Function(String data) onChangeCallBack,
    required VoidCallback onTapCallBack,
    required bool isRequired,
    required Icon icon,
    bool readOnly = false,
    List<String?>? validators,
    bool? autoFoucs,
    bool? obscured}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(
        fontSize: 17,
        color: Color(AppMainColors.p80),
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
    readOnly: readOnly,
    onChanged: onChangeCallBack,
    onTap: onTapCallBack,
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
          color: Color(AppMainColors.warningError75),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(CommonUIProperties.textfieldRoundedEdges)),
        borderSide: BorderSide(
          width: CommonUIProperties.textfiledRoundedEdgesWidth,
          color: Color(AppMainColors.warningError75),
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
      suffixIcon: icon,
    ),
  );
}
