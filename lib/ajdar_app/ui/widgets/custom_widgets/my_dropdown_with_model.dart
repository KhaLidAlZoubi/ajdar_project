import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../design/dimensions/app_dimensions.dart';

class MyDropdownWithModel extends StatefulWidget {
  MyDropdownWithModel({
    super.key,
    required this.label,
    required this.selectValue,
    required this.values,
    this.hint = 'Visit',
    this.padding = 5,
  });
  String label;
  String selectValue;
  List<String> values;
  String hint;
  double padding;

  @override
  State<MyDropdownWithModel> createState() => _MyDropdownWithModelState();
}

class _MyDropdownWithModelState extends State<MyDropdownWithModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getRes(context, widget.padding)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleText(
            widget.label,
            fontSize: 12,
          ),
          SizedBox(
            height: getRes(context, 6),
          ),
          Container(
            height: getRes(context, 50),
            width: double.infinity, // العرض بملء الشاشة
            decoration: BoxDecoration(
              color: backgroundContainer,
              borderRadius: BorderRadius.circular(
                getRes(context, 10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 4),
                  color: shadowTextThemeColor,
                  blurRadius: 8,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: getRes(context, 15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubtitleText(
                  "${widget.selectValue} ${widget.hint}",
                  fontSize: 13,
                ),
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(getRes(context, 12)),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: titleTextThemeColor,
                    ),
                    dropdownColor: backgroundContainer,
                    style: TextStyle(
                        color: bodyTextThemeColor, fontFamily: 'Cairo'),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.selectValue = newValue!;
                      });
                    },
                    items:
                        widget.values.map<DropdownMenuItem<String>>((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        // alignment: Alignment.c,
                        child: Text(
                          "$e ${widget.hint}",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getRes(context, 14),
                            fontWeight: FontWeight.w500,
                            color: titleTextThemeColor,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
