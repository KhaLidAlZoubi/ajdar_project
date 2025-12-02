import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/generated/l10n.dart';
import 'package:flutter/material.dart';

class Discount extends StatelessWidget {
  Discount({
    super.key,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
  });
  int price;
  int discount;
  int priceAfterDiscount;
  @override
  Widget build(BuildContext context) {
    return discount == 0 || discount == null
        ? SubtitleText(
            '$price ${S.of(context).sar}',
            fontSize: 12,
            weight: FontWeight.bold,
          )
        : Row(
            children: [
              SubtitleText(
                '$price',
                decoration: TextDecoration.lineThrough,
                color: Colors.grey[500],
                fontSize: 12,
              ),
              SizedBox(
                width: getRes(context, 5),
              ),
              SubtitleText(
                '$priceAfterDiscount ${S.of(context).sar}',
                fontSize: 12,
              )
            ],
          );
  }
}
