import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

SizedBox outlinedButton(
    {required VoidCallback callBack, required String content}) {
  return SizedBox(
    width: CommonUIProperties.buttonWidth,
    height: CommonUIProperties.buttonHeight,
    child: Expanded(
      child: OutlinedButton(
        onPressed: callBack,
        style: OutlinedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Colors.transparent,
            side: const BorderSide(
                width: CommonUIProperties.buttonRoundedEdgesWidth,
                color: Color(AppMainColors.p50)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(CommonUIProperties.buttonRoundedEdges)),
            )),
        child: Text(
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

SizedBox filledTextButton(
    {required VoidCallback callBack, required String content}) {
  return SizedBox(
    width: CommonUIProperties.buttonWidth,
    height: CommonUIProperties.buttonHeight,
    child: Expanded(
      child: TextButton(
        onPressed: callBack,
        style: TextButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            backgroundColor: const Color(AppMainColors.p100),
            foregroundColor: Colors.transparent,
            side: const BorderSide(
                width: CommonUIProperties.buttonRoundedEdgesWidth,
                color: Color(AppMainColors.p50)),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(CommonUIProperties.buttonRoundedEdges)),
            )),
        child: Text(
          content,
          style: const TextStyle(
              fontFamily: CommonUIProperties.fontType,
              color: Color(AppMainColors.backgroundAndContent),
              fontWeight: FontWeight.normal,
              fontSize: 17),
        ),
      ),
    ),
  );
}

SizedBox textButton({required VoidCallback callBack, required Text content}) {
  return SizedBox(
    child: TextButton(
        onPressed: callBack,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0),
          splashFactory: NoSplash.splashFactory,
        ),
        child: content),
  );
}

SizedBox outlinedIconTextButton(
    {required VoidCallback callBack, required String content, required IconData icon}) {
  return SizedBox(
    width: CommonUIProperties.buttonWidth,
    height: CommonUIProperties.buttonHeight,
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
        icon:  Icon(
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
