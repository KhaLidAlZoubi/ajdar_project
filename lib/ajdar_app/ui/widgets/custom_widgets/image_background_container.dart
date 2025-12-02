import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../conest.dart';
import '../../../data/api_call/http_helper.dart';

class ImageBackgroundContainer extends StatelessWidget {
  final dynamic network; // يمكن أن تكون String أو List<Map>
  final String? assets;
  final bool isNetwork;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? radius;
  final Widget? child;
  IconData icon;
  bool isCircle;
  Color backgroundColor;
  Color iconColor;
  ImageBackgroundContainer({
    super.key,
    this.network,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.iconColor = Colors.grey,
    this.icon = Icons.image_not_supported_outlined,
    this.assets,
    required this.isNetwork,
    this.height,
    this.width,
    this.radius,
    this.child,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final String? imagePath = imageHandle(
      network: network,
      assets: assets,
      isNetwork: isNetwork,
    );
    // print('imagePath: $imagePath');

    return Container(
      height: height != null ? getRes(context, height!) : height,
      width: width != null
          ? (width == double.infinity
              ? double.infinity
              : getRes(context, width!))
          : width,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        color: backgroundColor,
        borderRadius: radius != null ? radius : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: imagePath != null && isNetwork
          ? CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.fill,
              // width: double.infinity,
              // height: double.infinity,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
              errorWidget: (context, url, error) =>
                  _buildPlaceholderIcon(context),
            )
          : imagePath != null && !isNetwork
              ? Container(
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: radius != null ? radius : null,
                  ),
                  child: child,
                )
              : _buildPlaceholderIcon(context),
    );
  }

  Widget _buildPlaceholderIcon(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: double.infinity,
      // color: Colors.grey[300],
      // alignment: Alignment.center,
      child: Icon(
        icon,
        size: getRes(context, 25),
        color: iconColor,
      ),
    );
  }
}
