import 'package:ajder_project/ajdar_app/data/model/home/sub_section_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/home/section_model.dart';

Future<void> showAdvancedSearchDialog({
  required BuildContext context,
}) async {
  final searchController = TextEditingController();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  SectionModel? selectedSection;
  SubSectionModel? selectedSubSection;

  await showDialog(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              HomeCubit cubit = HomeCubit.get(context);
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: const Text("بحث متقدم"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // مربع البحث

                      TitleText(
                        'اكتب هنا',
                        fontSize: 13,
                      ),
                      SizedBox(
                        height: getRes(context, 6),
                      ),
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: "كلمة البحث",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(getRes(context, 15)),
                          ),
                        ),
                      ),
                      SizedBox(height: getRes(context, 18)),
                      if (cubit.isAdsHome) ...[
                        TitleText(
                          'الاقسام',
                          fontSize: 13,
                        ),
                        SizedBox(
                          height: getRes(context, 6),
                        ),
                        // اختيار القسم
                        DropdownButtonFormField<SectionModel>(
                          decoration: InputDecoration(
                            labelText: "اختر القسم",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(getRes(context, 15)),
                            ),
                          ),
                          value: selectedSection,
                          items: cubit.sections.map((section) {
                            return DropdownMenuItem<SectionModel>(
                              value: section,
                              child: Row(
                                children: [
                                  Image.network(
                                    section.image!,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(section.title!),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedSection = val;
                              selectedSubSection = null;
                            });
                            // cubit.selectSection(index);
                            cubit.subSectionConnect(selectedSection!.id);
                          },
                        ),

                        SizedBox(height: getRes(context, 18)),
                      ],

                      // اختيار القسم الفرعي (يظهر فقط إذا تم اختيار قسم)
                      if (selectedSection != null || !cubit.isAdsHome) ...[
                        TitleText(
                          'الاقسام الفرعية',
                          fontSize: 13,
                        ),
                        SizedBox(
                          height: getRes(context, 6),
                        ),
                        DropdownButtonFormField<SubSectionModel>(
                          decoration: InputDecoration(
                            labelText: "اختر القسم الفرعي",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(getRes(context, 15)),
                            ),
                          ),
                          value: selectedSubSection,
                          items: cubit.subSections.map((sub) {
                            return DropdownMenuItem<SubSectionModel>(
                              value: sub,
                              child: Text(sub.title!),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedSubSection = val;
                            });
                            cubit.trueAdvanced();
                          },
                        ),
                      ],
                      if (selectedSection != null)
                        SizedBox(height: getRes(context, 18)),
                      TitleText(
                        'السعر',
                        fontSize: 13,
                      ),
                      SizedBox(
                        height: getRes(context, 6),
                      ),
                      // السعر (من – إلى)
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: minPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "أدنى سعر",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getRes(context, 15)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: getRes(context, 10)),
                          Expanded(
                            child: TextField(
                              controller: maxPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "أعلى سعر",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      getRes(context, 15)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      cubit.falseAdvanced();
                      Navigator.pop(ctx); // إغلاق بدون نتيجة
                    },
                    child: const Text("تراجع"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // ترجع النتيجة عند الإغلاق
                      Navigator.pop(
                        ctx,
                      );
                      cubit.falseAdvanced();
                      if (cubit.isAdsHome) {
                        cubit.getAllAds(
                          isRefresh: true,
                          sectionName: selectedSection!.id!,
                          subSection: selectedSubSection!.id,
                          search: searchController.text,
                          min: minPriceController.text,
                          max: maxPriceController.text,
                        );
                      } else {
                        print('here');
                        cubit.getAds(
                          isRefresh: true,
                          sectionName: cubit.sections[cubit.sectionIndex!].id,
                          subSection: selectedSubSection!.id,
                          search: searchController.text,
                          min: minPriceController.text,
                          max: maxPriceController.text,
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.teal),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)),
                    child: const Text("موافق"),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}
