import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/description_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import '../../../../conest.dart';
import '../../../confirm/theme/sub_theme_data.dart';
// import '../../../domain/app_cubit/app_cubit.dart';
import '../../design/dimensions/app_dimensions.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    Key? key,
    required this.hint,
    this.type,
    this.obscure = false,
    this.suffix,
    required this.controller,
    this.onFieldSubmitted,
    this.preIcon,
    this.height = 51,
    this.radius = 10,
    this.lines,
    this.prefix,
    this.validator,
    this.error,
    this.onChanged,
    this.border,
    required this.label,
    this.errorColor = Colors.redAccent,
    this.justTextField = false,
    this.text = '',
    this.padding = 10,
    this.textAlign = TextAlign.right,
    this.textDirection = TextDirection.rtl,
  }) : super(key: key);
  void Function(String value)? onChanged;
  final String hint;
  TextEditingController controller;
  TextInputType? type;

  bool obscure;
  Widget? preIcon;
  double height;
  double radius;
  Widget? suffix;
  int? lines;
  Widget? prefix;
  String? Function(String?)? validator;
  String? error;
  BoxBorder? border;
  String label;
  Color errorColor;
  bool justTextField;
  String text;
  double padding;
  TextAlign textAlign;
  void Function(String value)? onFieldSubmitted;
  TextDirection textDirection;
  // int? lines;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: getRes(context, 15),
        left: getRes(context, widget.padding),
        right: getRes(context, widget.padding),
      ),
      child: widget.justTextField
          ? Column(
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
                  padding: EdgeInsets.only(
                      left: getRes(context, 15), right: getRes(context, 15)),
                  height: getRes(context, widget.height),
                  decoration: BoxDecoration(
                    border: widget.border,
                    color: backgroundContainer,
                    borderRadius: BorderRadius.circular(
                      getRes(context, widget.radius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 4),
                        color: shadowTextThemeColor,
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.prefix ?? Container(),
                      Expanded(
                        child: SubtitleText(
                          widget.text,
                          fontSize: 13,
                          weight: FontWeight.w500,
                        ),
                      ),
                      widget.suffix ?? Container(),
                    ],
                  ),
                ),
                widget.error == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                            top: getRes(context, 1),
                            left: box.read('lang') == 'en'
                                ? getRes(context, 75)
                                : 0,
                            right: box.read('lang') == 'ar'
                                ? getRes(context, 75)
                                : 0),
                        child: DescriptionText(
                          widget.error!,
                          fontSize: 11,
                          color: widget.errorColor,
                        ),
                      )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.label == ''
                    ? Container()
                    : SubtitleText(
                        widget.label,
                        fontSize: 12,
                      ),
                SizedBox(
                  height: widget.justTextField ? 0 : getRes(context, 6),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: widget.suffix == null
                        ?
                        //  AppCubit.get(context).lang == 'en'?
                        getRes(context, 15)
                        : getRes(context, 5),
                    // : 0,
                    right:
                        // AppCubit.get(context).lang == 'ar'
                        // ?
                        getRes(context, 15),
                    // : 0,
                  ),
                  height: getRes(context, widget.height),
                  decoration: BoxDecoration(
                    border: widget.border,
                    color: backgroundContainer,
                    borderRadius: BorderRadius.circular(
                      getRes(context, widget.radius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 4),
                        color: shadowTextThemeColor,
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.prefix ?? Container(),
                      Expanded(
                        child: TextFormField(
                          // onFieldSubmitted: widget.onFieldSubmitted,
                          controller: widget.controller,
                          maxLines: widget.lines,
                          textAlign: widget.textAlign,
                          textDirection: isNumeric(widget.controller.text)
                              ? TextDirection.ltr
                              : widget.textDirection,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: widget.obscure,
                          keyboardType: widget.type,
                          onChanged: widget.onChanged,
                          style: TextStyle(
                            fontFamily: 'Cairo-Reg',
                            fontSize: getRes(context, 14),
                            color: bodyTextThemeColor,
                          ),
                          decoration: InputDecoration(
                            // errorText: error,
                            errorStyle: TextStyle(fontSize: 0),

                            hintStyle: TextStyle(
                              fontFamily: 'Cairo-Reg',
                              fontSize: getRes(context, 14),
                              color: bodyTextThemeColor,
                              // color: Theme.of(context).textTheme.titleMedium!.color,
                            ),
                            hintText: widget.hint,
                            suffixIcon: widget.suffix,
                            prefixIcon: widget.preIcon,
                            border: InputBorder.none,
                          ),
                          validator: widget.validator,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.error == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                            top: getRes(context, 2.5),
                            left: box.read('lang') == 'en'
                                ? getRes(context, 75)
                                : 0,
                            right: box.read('lang') == 'ar'
                                ? getRes(context, 12)
                                : 0),
                        child: DescriptionText(
                          widget.error!,
                          fontSize: 11,
                          color: widget.errorColor,
                        ),
                      )
              ],
            ),
    );
  }
}

bool isNumeric(String value) {
  return RegExp(r'^[0-9]+$').hasMatch(value);
}
