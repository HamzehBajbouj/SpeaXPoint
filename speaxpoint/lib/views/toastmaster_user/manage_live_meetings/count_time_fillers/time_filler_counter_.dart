import 'package:flutter/material.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';
import 'package:speaxpoint/util/ui_widgets/buttons.dart';

class TimeFillerCounter extends StatelessWidget {
  const TimeFillerCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(AppMainColors.p50),
          width: 1.3,
        ),
        borderRadius:
            BorderRadius.circular(CommonUIProperties.cardRoundedEdges),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Hamzeh',
                style: const TextStyle(
                  fontFamily: CommonUIProperties.fontType,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(AppMainColors.p50),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1.3,
            color: Color(AppMainColors.p50),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '13',
                  style: const TextStyle(
                    fontFamily: CommonUIProperties.fontType,
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                    color: Color(AppMainColors.p80),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1.3,
            color: Color(AppMainColors.p50),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: roundedIconButton(callBack: () {}, icon: Icons.remove),
                ),
                Expanded(
                  child: roundedIconButton(callBack: () {}, icon: Icons.add),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
