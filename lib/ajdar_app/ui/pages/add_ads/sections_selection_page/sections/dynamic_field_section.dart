import 'package:ajder_project/ajdar_app/confirm/theme/shadow_theme.dart';
import 'package:ajder_project/ajdar_app/confirm/theme/sub_theme_data.dart';
import 'package:ajder_project/ajdar_app/data/model/dynamic_field_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/design/dimensions/app_dimensions.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/custom_button.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/my_text_field.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/small_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/subtitle_text.dart';
import 'package:ajder_project/ajdar_app/ui/widgets/custom_widgets/title_text.dart';
import 'package:ajder_project/conest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicField extends StatefulWidget {
  const DynamicField({super.key});

  @override
  State<DynamicField> createState() => _DynamicFieldState();
}

class _DynamicFieldState extends State<DynamicField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Column(
          children: [
            MyTextField(
                hint: 'ابحث عن الأقسام الفرعية',
                controller: TextEditingController(),
                label: ''),
            Container(
              height: getRes(context, 15),
            ),
            ListView.builder(
              itemCount: cubit.dynamicFileds.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final field = cubit.dynamicFileds[index];
                // print(field.name);
                // return Text('$index+1');
                // final options = field.options ?? [];
                return dynamicFieldItem(
                  context,
                  index: index,
                  ctrlText: cubit.dynamicTextCtrls[field.id] ?? null,
                  model: cubit.dynamicFileds[index],
                );
              },
            ),
            dynamicFieldItem(
              context,
              isField: true,
              ctrlText: cubit.addAdsCtrls[0],
              text: 'سعر الاعلان',
              description: 'ادخل السعر فقط رقم',
              model: DynamicFieldModel(
                id: HomeCubit.priceFieldId, // 🟢 ID ثابت
                title: 'سعر الإعلان',
                type: 'number',
              ),
            ),
            dynamicFieldItem(
              context,
              isField: true,
              ctrlText: cubit.addAdsCtrls[1],
              text: 'عنوان الاعلان',
              description: 'ادخل عنوان الاعلان',
              model: DynamicFieldModel(
                id: HomeCubit.titleFieldId,
                title: 'عنوان الإعلان',
                type: 'text',
              ),
            ),
            dynamicFieldItem(
              context,
              towField: true,
              text: 'الموقع',
              model: DynamicFieldModel(
                id: HomeCubit.locationFieldId,
                title: 'الموقع',
                type: 'text',
              ),
            ),
            dynamicFieldItem(
              context,
              line: 5,
              isField: true,
              ctrlText: cubit.addAdsCtrls[2],
              text: 'وصف الاعلان',
              description: 'ادخل الوصف هنا',
              model: DynamicFieldModel(
                id: HomeCubit.descFieldId,
                title: 'وصف الإعلان',
                type: 'text',
              ),
            ),
            SizedBox(
              height: getRes(context, 20),
            ),
            DefaultButton(
              onTap: () {
                print(cubit.dynamicFieldsFnish);
                //  final cubit = HomeCubit.get(context);
                if (cubit.validateDynamicFields(cubit.dynamicFileds)) {
                  cubit.nextPageAds();
                } else {
                  setState(() {}); // لإعادة بناء الواجهة مع الأخطاء
                }
              },
              text: 'متابعة',
            ),
            SizedBox(
              height: getRes(context, 30),
            ),
          ],
        );
      },
    );
  }

  Widget dynamicFieldItem(
    context, {
    DynamicFieldModel? model,
    int? index,
    bool isField = false,
    String text = '',
    String description = '',
    bool towField = false,
    int? line,
    TextEditingController? ctrlText,
  }) {
    // List<Map<String, dynamic>> governorates = originalGovernorates;
    List<String> neighborhoods = [];

    return Padding(
      padding: EdgeInsets.only(bottom: getRes(context, 15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getRes(context, 15), vertical: getRes(context, 20)),
            decoration: BoxDecoration(
              color: backgroundContainer,
              borderRadius: BorderRadius.circular(getRes(context, 10)),
              boxShadow: [ShadowTheme().switchThemeShadow],
              border: Border.all(
                color:
                    HomeCubit.get(context).fieldErrors[model?.id ?? -1] != null
                        ? Colors.red
                        : Colors.grey[200]!,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_box,
                        color: Colors.green, size: getRes(context, 25)),
                    SizedBox(width: getRes(context, 10)),
                    if (!isField && !towField)
                      TitleText('${model!.title}')
                    else
                      TitleText('$text')
                  ],
                ),
                Divider(),

                // الحالة العادية
                if (!isField && !towField && model!.type == 'radio')
                  Wrap(
                    spacing: getRes(context, 6),
                    runSpacing: getRes(context, 10),
                    children: model.options!.map((option) {
                      return optionItem(
                          option.value!, index!, HomeCubit.get(context),
                          id: model.id!);
                    }).toList(),
                  ),

                // حالة الخيارات الكثيرة
                if (!isField && !towField && model!.type == 'checkbox')
                  // buildDropdownOptions(model, index, context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getRes(context, 10)),
                      SubtitleText(
                        'اختر ${model.title!}',
                        fontSize: 14,
                      ),
                      SizedBox(height: getRes(context, 8)),
                      Container(
                        child: Wrap(
                          spacing: getRes(context, 6),
                          runSpacing: getRes(context, 10),

                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: model.options!.map((option) {
                            bool isSelected = HomeCubit.get(context)
                                    .multiSelectedValues[index]
                                    ?.contains(option.value) ??
                                false;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  final cubit = HomeCubit.get(context);
                                  cubit.toggleMultiSelect(
                                    index: index!,
                                    fieldId: model.id!,
                                    value: option.value!,
                                    isChecked: !isSelected,
                                  );
                                });
                              },
                              borderRadius: BorderRadius.circular(
                                getRes(context, 15),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(getRes(context, 8)),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    boxShadow: [
                                      ShadowTheme().switchThemeShadow,
                                    ],
                                    borderRadius: BorderRadius.circular(
                                      getRes(context, 15),
                                    ),
                                    border:
                                        Border.all(color: Colors.grey[200]!)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: getRes(context, 20),
                                      width: getRes(context, 20),
                                      child: Checkbox(
                                        // contentPadding: EdgeInsets.zero,
                                        // dense: true,
                                        value: isSelected,
                                        // title: Text(
                                        //   option.value ?? '',
                                        //   style: TextStyle(
                                        //     color: bodyTextThemeColor,
                                        //     fontFamily: 'Cairo',
                                        //     fontSize: 13,
                                        //   ),
                                        // ),
                                        activeColor: Colors.green[800],
                                        onChanged: (bool? checked) {
                                          setState(() {
                                            final cubit =
                                                HomeCubit.get(context);
                                            cubit.toggleMultiSelect(
                                              index: index!,
                                              fieldId: model.id!,
                                              value: option.value!,
                                              isChecked: checked ?? false,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: getRes(context, 5),
                                    ),
                                    SmallText(option.value!)
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                if (!isField && !towField && model!.type == 'select')
                  // buildDropdownOptions(model, index, context),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getRes(context, 10),
                      ),
                      SubtitleText(
                        'اختر ${model.title!}',
                        fontSize: 14,
                      ),
                      SizedBox(
                        height: getRes(context, 8),
                      ),
                      Container(
                        height: getRes(context, 50),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: backgroundContainer,
                            borderRadius:
                                BorderRadius.circular(getRes(context, 10)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 4),
                                color: shadowTextThemeColor,
                                blurRadius: 8,
                              )
                            ],
                            border: Border.all(
                              color: Colors.green[800]!,
                            )),
                        padding: EdgeInsets.symmetric(
                            horizontal: getRes(context, 15)),
                        child: Row(
                          children: [
                            SubtitleText(
                              HomeCubit.get(context).selectedValues[index!] !=
                                      null
                                  ? "${HomeCubit.get(context).selectedValues[index]}"
                                  : "اختر النوع",
                              fontSize: 13,
                            ),
                            Expanded(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                // value: HomeCubit.get(context).selectedValues[index],
                                borderRadius:
                                    BorderRadius.circular(getRes(context, 12)),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: titleTextThemeColor,
                                ),
                                style: TextStyle(
                                    color: bodyTextThemeColor,
                                    fontFamily: 'Cairo'),
                                underline: Container(
                                  height: 0,
                                  color: Colors.transparent,
                                ),
                                dropdownColor: backgroundContainer,
                                // value: selectedValue,

                                // hint: Text("اختر قيمة"),
                                items: model.options!.map((Options option) {
                                  return DropdownMenuItem<String>(
                                    value: option.value,
                                    child: Text(option.value ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    HomeCubit.get(context)
                                        .selectedValues[index] = newValue;
                                    HomeCubit.get(context)
                                        .updateDynamicFieldValue(
                                            dynamicFieldId: model.id!,
                                            newValue: newValue!);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                if (!isField && !towField && model!.type == 'text')
                  MyTextField(
                    hint: 'ادخل ${model.title}',
                    border: Border.all(color: Colors.green[800]!),
                    controller: ctrlText ?? TextEditingController(),
                    // onFieldSubmitted: (value) {
                    //   HomeCubit.get(context).updateDynamicFieldValue(
                    //       dynamicFieldId: model.id!, newValue: value);
                    // },
                    onChanged: (value) {
                      HomeCubit.get(context).updateDynamicFieldValue(
                          dynamicFieldId: model.id!, newValue: value);
                    },
                    label: '${model.title}',
                    type: TextInputType.text,
                  ),
                if (!isField && !towField && model!.type == 'number')
                  MyTextField(
                    hint: 'ادخل ${model.title}',
                    border: Border.all(color: Colors.green[800]!),
                    controller: ctrlText ?? TextEditingController(),
                    label: '${model.title}',
                    type: TextInputType.number,
                    onChanged: (value) {
                      HomeCubit.get(context).updateDynamicFieldValue(
                          dynamicFieldId: model.id!, newValue: value);
                    },
                  ),

                // حقل نصي
                if (isField && !towField)
                  MyTextField(
                    hint: '$description',
                    lines: line,
                    height: line != null ? 160 : 51,
                    border: Border.all(color: Colors.green[800]!),
                    controller: ctrlText ?? TextEditingController(),
                    label: '$text',
                  ),

                // الحالة الخاصة بالمحافظة والمنطقة مع بحث ذكي
                if (towField)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText('اختر المحافظة', fontSize: 14),
                      SizedBox(height: getRes(context, 8)),
                      GestureDetector(
                        onTap: () async {
                          // تحضير قائمة المحافظات

                          final govList = originalGovernorates
                              .map((g) => g['name'] as String)
                              .toList();
                          final result = await showSearchDialog(
                              context: context,
                              title: 'بحث عن المحافظة',
                              items: govList);

                          if (result != null) {
                            setState(() {
                              HomeCubit.get(context).selectedGovernorate =
                                  result;

                              HomeCubit.get(context).selectedNeighborhood =
                                  null;
                              box.write('go',
                                  HomeCubit.get(context).selectedGovernorate);
                            });
                          }
                        },
                        child: Container(
                          height: getRes(context, 50),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green[800]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerRight,
                          child: Text(
                              HomeCubit.get(context).selectedGovernorate ??
                                  "اختر المحافظة"),
                        ),
                      ),

                      SizedBox(height: getRes(context, 15)),

                      // عرض المنطقة فقط إذا اخترنا المحافظة
                      if (HomeCubit.get(context).selectedGovernorate !=
                          null) ...[
                        SubtitleText('اختر المنطقة', fontSize: 14),
                        SizedBox(height: getRes(context, 8)),
                        GestureDetector(
                          onTap: () async {
                            // أحضِر قائمة المناطق للمحافظة المختارة

                            final gov = originalGovernorates.firstWhere(
                              (g) =>
                                  g['name'] ==
                                  HomeCubit.get(context).selectedGovernorate,
                              orElse: () => {},
                            );
                            final neighborhoods = (gov.isEmpty)
                                ? <String>[]
                                : (gov['neighborhoods'] as List)
                                    .map((n) => n['name'] as String)
                                    .toList();

                            final result = await showSearchDialog(
                                context: context,
                                title: 'بحث عن المنطقة',
                                items: neighborhoods);

                            if (result != null) {
                              setState(() {
                                HomeCubit.get(context).selectedNeighborhood =
                                    result;
                                box.write(
                                    'ne',
                                    HomeCubit.get(context)
                                        .selectedNeighborhood);
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green[800]!),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.centerRight,
                            child: Text(
                                HomeCubit.get(context).selectedNeighborhood ??
                                    "اختر المنطقة"),
                          ),
                        ),
                      ]
                    ],
                  ),
              ],
            ),
          ),
          if (HomeCubit.get(context).fieldErrors[model?.id ?? -1] != null)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                HomeCubit.get(context).fieldErrors[model?.id ?? -1]!,
                style:
                    TextStyle(color: Colors.red, fontSize: getRes(context, 12)),
              ),
            ),
        ],
      ),
    );
  }

  Widget optionItem(String text, int index, HomeCubit cubit,
      {required int id}) {
    bool isSelected = cubit.selectedValues[index] == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          cubit.selectedValues[index] = text;
        });
        HomeCubit.get(context)
            .updateDynamicFieldValue(dynamicFieldId: id, newValue: text);
      },
      child: Container(
        padding: EdgeInsets.all(getRes(context, 8)),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              ShadowTheme().switchThemeShadow,
            ],
            borderRadius: BorderRadius.circular(
              getRes(context, 15),
            ),
            border: Border.all(color: Colors.grey[200]!)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: getRes(context, 20),
                width: getRes(context, 20),
                child: Checkbox(
                  value: isSelected,
                  onChanged: (v) {
                    setState(() {
                      cubit.selectedValues[index] = text;
                    });
                    HomeCubit.get(context).updateDynamicFieldValue(
                        dynamicFieldId: id, newValue: text);
                  },
                  activeColor: Colors.green,
                )),
            SizedBox(
              width: getRes(context, 5),
            ),
            SmallText(text)
          ],
        ),
      ),
    );
  }

  String normalizeArabic(String text) {
    return text
        .replaceAll(RegExp(r'[إأآا]'), 'ا')
        .replaceAll(RegExp(r'[يى]'), 'ي')
        .replaceAll(RegExp(r'ة'), 'ه')
        .replaceAll(RegExp(r'[ًٌٍَُُِّْ]'), '')
        .toLowerCase()
        .trim();
  }

// عنصر صندوق الاختيار

  Future<String?> showSearchDialog({
    required BuildContext context,
    required String title,
    required List<String> items,
  }) {
    final TextEditingController controller = TextEditingController();
    List<String> filteredItems = List.from(items);

    return showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(builder: (context, setState) {
          final double dialogHeight =
              MediaQuery.of(dialogContext).size.height * 0.6;
          return AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: double.maxFinite,
              height: dialogHeight,
              child: Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "ابحث...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      final query = normalizeArabic(value);
                      setState(() {
                        filteredItems = items.where((item) {
                          return normalizeArabic(item).contains(query);
                        }).toList();
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  // الآن ListView داخل Expanded لكن الحاوية لها ارتفاع محدد أعلاه
                  Expanded(
                    child: filteredItems.isEmpty
                        ? Center(child: Text('لا توجد نتائج'))
                        : ListView.builder(
                            itemCount: filteredItems.length,
                            itemBuilder: (ctx, i) {
                              final item = filteredItems[i];
                              return ListTile(
                                title: Text(item),
                                onTap: () {
                                  // نعيد العنصر المختار إلى ال await
                                  Navigator.pop(dialogContext, item);
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget buildDropdownptions(
      DynamicFieldModel model, int? index, BuildContext context) {
    return Container(
      height: getRes(context, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getRes(context, 10)),
        border: Border.all(color: Colors.green[800]!),
      ),
      padding: EdgeInsets.symmetric(horizontal: getRes(context, 15)),
      child: DropdownButton<String>(
        isExpanded: true,
        value: HomeCubit.get(context).selectedValues[index!],
        underline: SizedBox(),
        items: model.options!.map((Options option) {
          return DropdownMenuItem<String>(
            value: option.value,
            child: Text(option.value ?? ''),
          );
        }).toList(),
        onChanged: (String? newValue) {
          HomeCubit.get(context).selectedValues[index] = newValue;
        },
      ),
    );
  }

  // ate final List<Map<String, dynamic>> governorates;

  final List<Map<String, dynamic>> originalGovernorates = [
    {
      "name": 'دمشق',
      "neighborhoods": [
        {"name": 'دمشق'},
        {"name": 'المزة'},
        {"name": 'المالكي'},
        {"name": 'ركن الدين'},
        {"name": 'المهاجرين'},
        {"name": 'البرامكة'},
        {"name": 'الصالحية'},
        {"name": 'باب توما'},
        {"name": 'باب شرقي'},
        {"name": 'القصاع'},
        {"name": 'الشاغور'},
        {"name": 'الميدان'},
        {"name": 'الزاهرة'},
        {"name": 'القدم'},
        {"name": 'كفرسوسة'},
        {"name": 'جوبر'},
        {"name": 'القابون'},
        {"name": 'برزة'},
        {"name": 'دمر'},
        {"name": 'مشروع دمر'},
        {"name": 'اليرموك'},
        {"name": 'التجارة'},
        {"name": 'العدوي'},
        {"name": 'السبكي'},
        {"name": 'المجتهد'},
        {"name": 'العمارة'},
        {"name": 'ساروجة'},
        {"name": 'الدويلعة'},
        {"name": 'الزبلطاني'},
        {"name": 'الشيخ محي الدين'},
        {"name": 'المجتهد'},
        {"name": 'القصور'},
        {"name": 'المزرعة'},
        {"name": 'ركن الدين'},
        {"name": 'المهاجرين'},
        {"name": 'الصالحية'},
        {"name": 'باب توما'},
        {"name": 'باب شرقي'},
        {"name": 'القصاع'},
        {"name": 'الشاغور'},
        {"name": 'الميدان'},
        {"name": 'الزاهرة'},
        {"name": 'القدم'},
        {"name": 'كفرسوسة'},
        {"name": 'جوبر'},
        {"name": 'القابون'},
        {"name": 'برزة'},
        {"name": 'دمر'},
        {"name": 'مشروع دمر'},
        {"name": 'اليرموك'},
        {"name": 'التجارة'},
        {"name": 'العدوي'},
        {"name": 'السبكي'},
        {"name": 'المجتهد'},
        {"name": 'العمارة'},
        {"name": 'ساروجة'},
        {"name": 'الدويلعة'},
        {"name": 'الزبلطاني'},
        {"name": 'الشيخ محي الدين'},
        {"name": 'ريف دمشق'}
      ]
    },
    {
      "name": 'ريف دمشق',
      "neighborhoods": [
        {"name": 'ريف دمشق'},
        {"name": 'جرمانا'},
        {"name": 'صحنايا'},
        {"name": 'قدسيا'},
        {"name": 'التل'},
        {"name": 'دوما'},
        {"name": 'حرستا'},
        {"name": 'داريا'},
        {"name": 'معضمية الشام'},
        {"name": 'يبرود'},
        {"name": 'النبك'},
        {"name": 'الكسوة'},
        {"name": 'قطنا'},
        {"name": 'الزبداني'},
        {"name": 'بلودان'},
        {"name": 'عين ترما'},
        {"name": 'سقبا'},
        {"name": 'حمورية'},
        {"name": 'كفربطنا'},
        {"name": 'عربين'},
        {"name": 'حران العواميد'},
        {"name": 'حفير الفوقا'},
        {"name": 'حفير التحتا'},
        {"name": 'دير عطية'},
        {"name": 'رنكوس'},
        {"name": 'صيدنايا'},
        {"name": 'عين الفيجة'},
        {"name": 'وادي بردى'},
        {"name": 'دير قانون'},
        {"name": 'دير مقرن'},
        {"name": 'بسيمة'},
        {"name": 'أشرفية الوادي'},
        {"name": 'جديدة عرطوز'},
        {"name": 'جديدة الفضل'},
        {"name": 'عرطوز'},
        {"name": 'سبينة'},
        {"name": 'حجيرة'},
        {"name": 'ببيلا'},
        {"name": 'بيت سحم'},
        {"name": 'يلدا'},
        {"name": 'حتيتة التركمان'},
        {"name": 'حتيتة الجرش'},
        {"name": 'حوش عرب'},
        {"name": 'حوش بلاس'},
        {"name": 'حوش نصري'},
        {"name": 'حوش الفارة'},
        {"name": 'حوش الضواهرة'},
        {"name": 'حوش القبيات'},
        {"name": 'حوش المشرف'},
        {"name": 'حوش الريحانية'},
        {"name": 'حوش صهيا'},
        {"name": 'حوش حماد'},
        {"name": 'حوش خياط'},
        {"name": 'حوش عابدين'},
        {"name": 'حوش عيسى'},
        {"name": 'حوش عمار'},
        {"name": 'حوش عمر'},
        {"name": 'حوش علي'},
        {"name": 'حوش فارة'},
        {"name": 'حوش مباركة'},
        {"name": 'حوش نصري'},
        {"name": 'حوش نصير'},
        {"name": 'حوش يونس'},
        {"name": 'حوش الريف'},
        {"name": 'ريف ريف دمشق'}
      ]
    },

    {
      "name": 'حمص',
      "neighborhoods": [
        {"name": 'حمص'},
        {"name": 'الوعر'},
        {"name": 'الحميدية'},
        {"name": 'بابا عمرو'},
        {"name": 'الخالدية'},
        {"name": 'الإنشاءات'},
        {"name": 'كرم الشامي'},
        {"name": 'باب تدمر'},
        {"name": 'باب هود'},
        {"name": 'عكرمة'},
        {"name": 'دير بعلبة'},
        {"name": 'ريف حمص'}
      ]
    },
    {
      "name": 'اللاذقية',
      "neighborhoods": [
        {"name": 'اللاذقية'},
        {"name": 'الرمل الجنوبي'},
        {"name": 'مشروع الصليبة'},
        {"name": 'الدعتور'},
        {"name": 'الزراعة'},
        {"name": 'الصليبة'},
        {"name": 'الشيخ ضاهر'},
        {"name": 'الطابيات'},
        {"name": 'الكورنيش الجنوبي'},
        {"name": 'الكورنيش الشمالي'},
        {"name": 'سقوبين'},
        {"name": 'جبلة'},
        {"name": 'القرداحة'},
        {"name": 'الحفة'},
        {"name": 'رأس البسيط'},
        {"name": 'كسب'},
        {"name": 'صلنفة'},
        {"name": 'المزيرعة'},
        {"name": 'بيت ياشوط'},
        {"name": 'عين الشرقية'},
        {"name": 'البسيط'},
        {"name": 'ديروتان'},
        {"name": 'رويسة عازار'},
        {"name": 'ريف اللاذقية'}
      ]
    },
    {
      "name": 'ديرالزور',
      "neighborhoods": [
        {"name": 'دير الزور'},
        {"name": 'القصور'},
        {"name": 'الجورة'},
        {"name": 'الحميدية'},
        {"name": 'العرضي'},
        {"name": 'المطار القديم'},
        {"name": 'الحويقة'},
        {"name": 'العمال'},
        {"name": 'الموظفين'},
        {"name": 'الجبيلة'},
        {"name": 'الشيخ ياسين'},
        {"name": 'الشحيل'},
        {"name": 'الميادين'},
        {"name": 'البوكمال'},
        {"name": 'موحسن'},
        {"name": 'العشارة'},
        {"name": 'خشام'},
        {"name": 'الطيانة'},
        {"name": 'البصيرة'},
        {"name": 'الصالحية'},
        {"name": 'حطلة'},
        {"name": 'مراط'},
        {"name": 'ذيبان'},
        {"name": 'الصور'},
        {"name": 'الكسرة'},
        {"name": 'الهرموشية'},
        {"name": 'الطابية'},
        {"name": 'الزباري'},
        {"name": 'الدوير'},
        {"name": 'الخشام'},
        {"name": 'الحسينية'},
        {"name": 'ريف ديرالزور'}
      ]
    },
    {
      "name": 'الرقة',
      "neighborhoods": [
        {"name": 'الرقة'},
        {"name": 'المشلب'},
        {"name": 'الدرعية'},
        {"name": 'الرميلة'},
        {"name": 'البدو'},
        {"name": 'القطار'},
        {"name": 'النهضة'},
        {"name": 'الدوار'},
        {"name": 'الدرعية'},
        {"name": 'الجزرة'},
        {"name": 'حطين'},
        {"name": 'ريف الرقة'}
      ]
    },
    {
      "name": 'طرطوس',
      "neighborhoods": [
        {"name": 'طرطوس'},
        {"name": 'الإنشاءات'},
        {"name": 'الرمل الجنوبي'},
        {"name": 'الطليعة'},
        {"name": 'المنطقة الصناعية'},
        {"name": 'العباسية'},
        {"name": 'الدوير'},
        {"name": 'الكرامة'},
        {"name": 'الحميدية'},
        {"name": 'الشيخ سعد'},
        {"name": 'بانياس'},
        {"name": 'صافيتا'},
        {"name": 'الدريكيش'},
        {"name": 'الشيخ بدر'},
        {"name": 'القدموس'},
        {"name": 'مشتى الحلو'},
        {"name": 'برمانة المشايخ'},
        {"name": 'حصين البحر'},
        {"name": 'يحمور'},
        {"name": 'دوير رسلان'},
        {"name": 'رويسة البساتنة'},
        {"name": 'الصفصافة'},
        {"name": 'حمام واصل'},
        {"name": 'ريف طرطوس'}
      ]
    },
    {
      "name": 'حلب',
      "neighborhoods": [
        {"name": 'حلب'},
        {"name": 'السليمانية'},
        {"name": 'الأعظمية'},
        {"name": 'الجميلية'},
        {"name": 'الموكامبو'},
        {"name": 'الفرقان'},
        {"name": 'حلب الجديدة'},
        {"name": 'الشيخ مقصود'},
        {"name": 'الشيخ طه'},
        {"name": 'الأنصاري'},
        {"name": 'باب النيرب'},
        {"name": 'إعزاز'},
        {"name": 'الباب'},
        {"name": 'منبج'},
        {"name": 'السفيرة'},
        {"name": 'الأتارب'},
        {"name": 'دير حافر'},
        {"name": 'تل رفعت'},
        {"name": 'مسكنة'},
        {"name": 'عندان'},
        {"name": 'عفرين'},
        {"name": 'جرابلس'},
        {"name": 'مارع'},
        {"name": 'صوران'},
        {"name": 'تل الضمان'},
        {"name": 'تل عرن'},
        {"name": 'تل حاصل'},
        {"name": 'تل شغيب'},
        {"name": 'تل جبين'},
        {"name": 'تل مصيبين'},
        {"name": 'تل قراح'},
        {"name": 'تل قراح'},
        {"name": 'تل قراح'},
        {"name": 'ريف حلب'}
      ]
    },
    {
      "name": 'ادلب',
      "neighborhoods": [
        {"name": 'ادلب'},
        {"name": 'الضبيط'},
        {"name": 'القصور'},
        {"name": 'الشيخ ثلث'},
        {"name": 'الجامعة'},
        {"name": 'الضاحية'},
        {"name": 'الزهراء'},
        {"name": 'المدينة الصناعية'},
        {"name": 'الوسطى'},
        {"name": 'الشرقية'},
        {"name": 'الغربية'},
        {"name": 'معرة النعمان'},
        {"name": 'أريحا'},
        {"name": 'سراقب'},
        {"name": 'جسر الشغور'},
        {"name": 'خان شيخون'},
        {"name": 'كفرنبل'},
        {"name": 'الدانا'},
        {"name": 'حارم'},
        {"name": 'سلقين'},
        {"name": 'تفتناز'},
        {"name": 'بنش'},
        {"name": 'سرمين'},
        {"name": 'كفرتخاريم'},
        {"name": 'كللي'},
        {"name": 'معرة مصرين'},
        {"name": 'محمبل'},
        {"name": 'كفرومة'},
        {"name": 'كفرسجنة'},
        {"name": 'الهبيط'},
        {"name": 'ريف ادلب'}
      ]
    },
    {
      "name": 'الحسكة',
      "neighborhoods": [
        {"name": 'الحسكة'},
        {"name": 'الصالحية'},
        {"name": 'تل حجر'},
        {"name": 'المساكن'},
        {"name": 'المحطة'},
        {"name": 'العزيزية'},
        {"name": 'النشوة'},
        {"name": 'الكلاسة'},
        {"name": 'الناصرة'},
        {"name": 'الليلية'},
        {"name": 'غويران'},
        {"name": 'ريف الحسكة'}
      ]
    },
    {
      "name": 'درعا',
      "neighborhoods": [
        {"name": 'درعا'},
        {"name": 'درعا البلد'},
        {"name": 'درعا المحطة'},
        {"name": 'القصور'},
        {"name": 'السبيل'},
        {"name": 'المطار'},
        {"name": 'الضاحية'},
        {"name": 'النعيمة'},
        {"name": 'اليادودة'},
        {"name": 'الصناعة'},
        {"name": 'الشيخ مسكين'},
        {"name": 'نوى'},
        {"name": 'طفس'},
        {"name": 'جاسم'},
        {"name": 'الصنمين'},
        {"name": 'إزرع'},
        {"name": 'الحراك'},
        {"name": 'بصرى الشام'},
        {"name": 'داعل'},
        {"name": 'إنخل'},
        {"name": 'خربة غزالة'},
        {"name": 'المزيريب'},
        {"name": 'تسيل'},
        {"name": 'سحم الجولان'},
        {"name": 'الشجرة'},
        {"name": 'تسيل'},
        {"name": 'عدوان'},
        {"name": 'الجيزة'},
        {"name": 'المسيفرة'},
        {"name": 'الكرك الشرقي'},
        {"name": 'الحارة'},
        {"name": 'ابطع'},
        {"name": 'محجة'},
        {"name": 'علما'},
        {"name": 'الطيبة'},
        {"name": 'الغارية الشرقية'},
        {"name": 'الغارية الغربية'},
        {"name": 'ريف درعا'}
      ]
    },
    // ... أكمل بقية المحافظات السورية مع الأحياء حسب الحاجة ...
  ];
}
