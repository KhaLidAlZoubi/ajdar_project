import 'dart:io';

import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/pages/add_ads/sections_selection_page/sections/idea_section.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/messages/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../../../../conest.dart';
import '../../../../../domain/home_cubit/home_state.dart';

class PhotoGridSection extends StatefulWidget {
  @override
  _PhotoGridSectionState createState() => _PhotoGridSectionState();
}

class _PhotoGridSectionState extends State<PhotoGridSection> {
  final ImagePicker _picker = ImagePicker();
  final int maxPhotos = 10;

  List<XFile?> photos = List.filled(10, null);

  // أول خانة فارغة متاحة
  int get firstEmptyIndex => photos.indexWhere((element) => element == null);

  Future<void> pickImage() async {
    if (firstEmptyIndex == -1) return; // ممتلئة

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        photos[firstEmptyIndex] = image;
      });
    }
  }

  void saveImages() {
    HomeCubit cubit = HomeCubit.get(context);
    List<XFile> filledPhotos = photos.whereType<XFile>().toList();
    if (filledPhotos.isNotEmpty && filledPhotos.length >= 3) {
      if (!cubit.addAdsLoading) {
        print('nextt');
        List<File> files =
            filledPhotos.map((xfile) => File(xfile.path)).toList();
        cubit.addAdsConnect(
            images: files, location: '${box.read('go')} ${box.read('ne')}');
      }
    } else {
      CustomSnackbar.show(
          context: context,
          message: 'يرجى اختيار خمس صور على الاقل لاعلانك',
          type: SnackbarType.warning,
          topPosition: true);
    }
    // يمكنك هنا تخزينها أو طباعتها
    // print("عدد الصور المحفوظة: ${filledPhotos[0].path}");
  }

  Widget photoItem(BuildContext context, int index) {
    bool isEmpty = photos[index] == null;
    bool isNextToFill = index == firstEmptyIndex;

    return DottedBorder(
      color: isNextToFill ? Colors.orange : Colors.grey,
      child: Stack(
        children: [
          InkWell(
            onTap: isNextToFill ? pickImage : null,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isNextToFill ? Colors.orange[50] : Colors.grey[50],
              ),
              child: isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: isNextToFill
                              ? Colors.orange[100]
                              : Colors.grey[100],
                          child: Icon(
                            Icons.add,
                            color: isNextToFill ? Colors.orange : Colors.grey,
                          ),
                        ),
                        SizedBox(height: getRes(context, 8)),
                        Text(
                          'اضغط لاختيار ملف',
                          style: TextStyle(
                            fontSize: getRes(context, 12),
                            color: isNextToFill ? Colors.brown : Colors.grey,
                          ),
                        )
                      ],
                    )
                  : Image.file(
                      File(photos[index]!.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            ),
          ),
          if (!isEmpty)
            Positioned(
              top: getRes(context, 3),
              right: getRes(context, 3),
              child: InkWell(
                onTap: () {
                  setState(() {
                    photos[index] = null;

                    // إعادة ترتيب القائمة: الصور أولاً ثم nulls
                    photos.sort((a, b) {
                      if (a == null && b != null) return 1; // null يروح لآخر
                      if (a != null && b == null) return -1; // الصورة تبقى قدام
                      return 0;
                    });
                  });
                },
                borderRadius: BorderRadius.circular(getRes(context, 12.5)),
                child: CircleAvatar(
                  radius: 12.5,
                  backgroundColor: Colors.red[100],
                  child: Icon(
                    Icons.close,
                    size: getRes(context, 15),
                    color: Colors.red,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit cubit = HomeCubit.get(context);
      return Container(
        child: Column(
          children: [
            GridView.builder(
              // padding: EdgeInsets.all(12),
              itemCount: maxPhotos,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 150,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1),
              itemBuilder: (context, index) => photoItem(context, index),
            ),
            SizedBox(height: getRes(context, 25)),
            IdeaSection(),
            SizedBox(height: getRes(context, 20)),
            cubit.addAdsLoading
                ? LinearProgressIndicator(
                    value: cubit.uploadProgress, // 0.0 -> 1.0
                    backgroundColor: Colors.grey[200],
                    color: Colors.teal,
                  )
                : ElevatedButton.icon(
                    icon: cubit.addAdsLoading
                        ? SizedBox.shrink()
                        : Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          photos.isEmpty || photos.length < 5
                              ? Colors.teal[200]
                              : Colors.teal),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                    onPressed: saveImages,
                    label: cubit.addAdsLoading
                        ? Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text("حفظ الصور"),
                  ),
            SizedBox(height: getRes(context, 40)),
          ],
        ),
      );
    });
  }
}
