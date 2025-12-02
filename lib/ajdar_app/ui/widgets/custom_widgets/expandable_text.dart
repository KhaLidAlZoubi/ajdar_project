import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText({super.key, required this.text, this.height = 1.6});
  final String text;
  double height;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstText;
  late String secondText;
  bool hiddenText = true;
  double textHeight = 100;
  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstText = widget.text.substring(0, textHeight.toInt());
      secondText =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstText = widget.text;
      secondText = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: textHeight,
      child: secondText.isEmpty
          ? DescriptionText(
              firstText,
              fontSize: 12,
              height: widget.height,
              overflow: TextOverflow.clip,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DescriptionText(
                  hiddenText == true
                      ? (firstText + ' ... ')
                      : (firstText + secondText),
                  overflow: TextOverflow.clip,
                  height: widget.height,
                  fontSize: 12,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SubtitleText(
                        hiddenText == true ? 'See more' : 'See less',
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 13,
                        weight: FontWeight.w500,
                      ),
                      Icon(
                        hiddenText == true
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        size: getRes(context, 20),
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
