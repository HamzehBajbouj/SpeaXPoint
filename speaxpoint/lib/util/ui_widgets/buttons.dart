import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

SizedBox outlinedButton({
  required VoidCallback callBack,
  required String content,
  double fontSize = 17,
  double buttonWidth = CommonUIProperties.buttonWidth,
  double buttonHeight = CommonUIProperties.buttonHeight,
  Color buttonColor = const Color(AppMainColors.p50),
  bool enableButtonAction = true,
}) {
  return SizedBox(
    width: buttonWidth,
    height: buttonHeight,
    child: Expanded(
      child: OutlinedButton(
        onPressed: enableButtonAction ? callBack : null,
        style: OutlinedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Colors.transparent,
            side: BorderSide(
                width: CommonUIProperties.buttonRoundedEdgesWidth,
                color: buttonColor),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(CommonUIProperties.buttonRoundedEdges)),
            )),
        child: Text(
          content,
          style: TextStyle(
              fontFamily: CommonUIProperties.fontType,
              color: buttonColor,
              fontWeight: FontWeight.normal,
              fontSize: fontSize),
        ),
      ),
    ),
  );
}

SizedBox filledTextButton({
  required VoidCallback callBack,
  required String content,
  double buttonWidth = CommonUIProperties.buttonWidth,
  double buttonHeight = CommonUIProperties.buttonHeight,
  Color backgroundColor = const Color(AppMainColors.p100),
  Color contentColor = const Color(AppMainColors.backgroundAndContent),
  Color borderColor = const Color(AppMainColors.p50),
}) {
  return SizedBox(
    width: buttonWidth,
    height: buttonHeight,
    child: Expanded(
      child: TextButton(
        onPressed: callBack,
        style: TextButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            backgroundColor: backgroundColor,
            foregroundColor: Colors.transparent,
            side: BorderSide(
                width: CommonUIProperties.buttonRoundedEdgesWidth,
                color: borderColor),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(CommonUIProperties.buttonRoundedEdges)),
            )),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            content,
            style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                color: contentColor,
                fontWeight: FontWeight.normal,
                fontSize: 17),
          ),
        ),
      ),
    ),
  );
}

SizedBox textButton(
    {required VoidCallback callBack,
    required Text content,
    double buttonWidth = CommonUIProperties.buttonWidth,
    double buttonHeight = CommonUIProperties.buttonHeight}) {
  return SizedBox(
    height: buttonHeight,
    child: TextButton(
        onPressed: callBack,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0),
          splashFactory: NoSplash.splashFactory,
        ),
        child: content),
  );
}

Widget textButtonWithTrailingIcon({
  required VoidCallback callBack,
  required Text content,
  Icon? trailingIcon,
  double paddingBetweenIconAndContent = 40,
}) {
  return TextButton(
    onPressed: callBack,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.only(left: 0),
      splashFactory: NoSplash.splashFactory,
    ),
    child: Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          content,
          SizedBox(
            width: paddingBetweenIconAndContent,
          ),
          if (trailingIcon != null) trailingIcon,
        ],
      ),
    ),
  );
}

SizedBox outlinedIconTextButton({
  required VoidCallback callBack,
  required String content,
  required IconData icon,
  double buttonHeight = CommonUIProperties.buttonHeight,
  double buttonWidth = CommonUIProperties.buttonWidth,
}) {
  return SizedBox(
    width: buttonWidth,
    height: buttonHeight,
    child: Expanded(
      child: OutlinedButton.icon(
        onPressed: callBack,
        style: OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: Colors.transparent,
          side: const BorderSide(
            width: CommonUIProperties.buttonRoundedEdgesWidth,
            color: Color(AppMainColors.p50),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(CommonUIProperties.buttonRoundedEdges)),
          ),
        ),
        icon: Icon(
          icon,
          color: const Color(AppMainColors.p50),
        ),
        label: Text(
          content,
          style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              color: Color(AppMainColors.p50),
              fontWeight: FontWeight.normal,
              fontSize: 17),
        ),
      ),
    ),
  );
}
