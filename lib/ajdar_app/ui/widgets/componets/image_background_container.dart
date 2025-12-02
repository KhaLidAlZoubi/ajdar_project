import 'package:ajder_project/ajdar_app/data/api_call/http_helper.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:flutter/material.dart';

class ImageBackgroundContainer extends StatelessWidget {
  ImageBackgroundContainer({
    super.key,
    this.url,
    this.height = 10,
    this.width = 10,
    this.radius = 10,
    this.child,
  });
  String? url;
  double height;
  double width;
  Widget? child;
  double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getRes(context, height),
      width:
          width == double.infinity ? double.infinity : getRes(context, width),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(getRes(context, radius)),
        image: url != null
            ? DecorationImage(
                image: NetworkImage('$url'),
                fit: BoxFit.fill,
              )
            : null,
      ),
      child: child,
    );
  }
}
