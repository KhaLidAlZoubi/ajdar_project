import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';

class IdeaSection extends StatelessWidget {
  const IdeaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getRes(context, 15)),
      padding: EdgeInsets.symmetric(
          horizontal: getRes(context, 15), vertical: getRes(context, 10)),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 188, 240, 234),
        border: Border.all(
          color: Colors.teal,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(getRes(context, 10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.blue,
            // size: getRes(context, 28),
          ),
          SizedBox(
            width: getRes(context, 10),
          ),
          Expanded(
            child: Column(
              spacing: getRes(context, 8),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubtitleText(
                  'نصائح حول رفع الصور',
                  color: Colors.blue,
                  fontSize: 15,
                ),
                SizedBox(
                  height: getRes(context, 4),
                ),
                TitleText(
                  '. الصورة الاولى ستكون الصورة المصغرة للاعلان',
                  fontSize: 12,
                  color: Colors.blue,
                ),
                SubtitleText(
                  '. استخدم صور عالية الجودة وواضحة',
                  fontSize: 12,
                  color: Colors.blue,
                ),
                SubtitleText(
                  '. الحد الاقصى لحجم كل صورة: 5 ميغا بايت',
                  fontSize: 12,
                  color: Colors.blue,
                ),
                SubtitleText(
                  '. الصيغ المدعومة: JPG, PNG, WebP',
                  fontSize: 12,
                  color: Colors.blue,
                ),
                SubtitleText(
                  '. ارفع الصورةالرئيسية اولا لتكون الصور المصغرة',
                  fontSize: 12,
                  color: Colors.blue,
                ),
                SubtitleText(
                  '. تأكد ان الصور تعرض المنتج بوضوح',
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
