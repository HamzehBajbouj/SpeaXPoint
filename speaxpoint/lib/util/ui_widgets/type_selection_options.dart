import 'package:flutter/cupertino.dart';
import 'package:speaxpoint/util/constants/app_main_colors.dart';
import 'package:speaxpoint/util/constants/common_ui_properties.dart';

class TypeSelectionOptions extends StatefulWidget {
  const TypeSelectionOptions(this.selectItem,
      {super.key,
      required this.displayOptions,
      required this.index,
      required this.isSelected});

  final String displayOptions;
  final int index;
  final bool isSelected;
  final Function(int) selectItem;

  @override
  State<TypeSelectionOptions> createState() => _UserTypeOptionsState();
}

class _UserTypeOptionsState extends State<TypeSelectionOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: GestureDetector(
        onTap: () => {widget.selectItem(widget.index)},
        child: Container(
          height: CommonUIProperties.buttonHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color(AppMainColors.p100)
                : const Color(AppMainColors.p5),
            borderRadius:
                BorderRadius.circular(CommonUIProperties.buttonRoundedEdges),
            border: Border.all(
              width: CommonUIProperties.buttonRoundedEdgesWidth,
              color: const Color(AppMainColors.p20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 12.5),
            child: Text(
              widget.displayOptions,
              style: TextStyle(
                fontFamily: CommonUIProperties.fontType,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: widget.isSelected
                    ? const Color(AppMainColors.backgroundAndContent)
                    : const Color(AppMainColors.p20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
