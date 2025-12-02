import 'package:ajder_project/ajdar_app/domain/home_cubit/home_cubit.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GovernoratesSearchPage extends StatefulWidget {
  const GovernoratesSearchPage({super.key});

  @override
  State<GovernoratesSearchPage> createState() => _GovernoratesSearchPageState();
}

class _GovernoratesSearchPageState extends State<GovernoratesSearchPage> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> originalGovernorates = [
    {
      "name": 'دمشق',
      "neighborhoods": [
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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
        {"name": 'كل المدن'},
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

  late List<Map<String, dynamic>> filteredGovernorates;

  // لتخزين نصوص البحث المحلي لكل محافظة
  Map<String, String> localSearchQueries = {};

  @override
  void initState() {
    super.initState();
    filteredGovernorates = List.from(originalGovernorates);
  }

  void _onGlobalSearch(String query) {
    query = query.trim().toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredGovernorates = List.from(originalGovernorates);
        localSearchQueries.clear();
      });
      return;
    }

    List<Map<String, dynamic>> result = [];

    for (var gov in originalGovernorates) {
      final name = gov['name'].toString();
      final neighborhoods = gov['neighborhoods'] as List;

      bool governorateMatches = name.toLowerCase().contains(query);
      List<dynamic> matchingNeighborhoods = neighborhoods
          .where((n) => n['name'].toString().toLowerCase().contains(query))
          .toList();

      if (governorateMatches) {
        result.add({
          "name": name,
          "neighborhoods": neighborhoods,
        });
      } else if (matchingNeighborhoods.isNotEmpty) {
        result.add({
          "name": name,
          "neighborhoods": matchingNeighborhoods,
        });
      }
    }

    setState(() {
      filteredGovernorates = result;
      localSearchQueries.clear();
    });
  }

  void _onLocalSearch(String governorateName, String query) {
    setState(() {
      localSearchQueries[governorateName] = query.toLowerCase().trim();
    });
  }

  List<Map<String, dynamic>> _applyLocalFilter(
      String governorateName, List<dynamic> neighborhoods) {
    final localQuery = localSearchQueries[governorateName] ?? '';
    if (localQuery.isEmpty) return neighborhoods.cast<Map<String, dynamic>>();

    return neighborhoods
        .where((n) => n['name'].toString().toLowerCase().contains(localQuery))
        .cast<Map<String, dynamic>>()
        .toList();
  }

  bool _shouldExpand(String governorateName, List<dynamic> shownNeighborhoods) {
    final original = originalGovernorates.firstWhere(
        (g) => g['name'] == governorateName)['neighborhoods'] as List;

    return shownNeighborhoods.length < original.length;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      HomeCubit cubit = HomeCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: const Text('المحافظات السورية'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: _onGlobalSearch,
                decoration: InputDecoration(
                  hintText: 'ابحث عن محافظة أو منطقة...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ),
        body: filteredGovernorates.isEmpty
            ? const Center(child: Text('لا توجد نتائج'))
            : ListView.builder(
                itemCount: filteredGovernorates.length,
                itemBuilder: (context, index) {
                  final governorate = filteredGovernorates[index];
                  final name = governorate['name'];
                  final originalNeighborhoods = originalGovernorates.firstWhere(
                      (g) => g['name'] == name)['neighborhoods'] as List;
                  final shownNeighborhoods =
                      _applyLocalFilter(name, governorate['neighborhoods']);

                  final shouldExpand =
                      _shouldExpand(name, governorate['neighborhoods']);

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        child: ExpansionTile(
                          key: ValueKey(name), // يساعد في إعادة البناء الصحيحة
                          initiallyExpanded: shouldExpand,
                          title: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: TextField(
                                onChanged: (val) => _onLocalSearch(name, val),
                                decoration: InputDecoration(
                                  hintText: 'ابحث ضمن $name...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                ),
                              ),
                            ),
                            ...shownNeighborhoods.map((n) {
                              return InkWell(
                                onTap: () {
                                  if (name == n['name']) {
                                    cubit.selectAreaName(name);
                                    cubit.area = '';
                                    if (cubit.isAdsHome == false) {
                                      cubit.getAds(
                                        isRefresh: true,
                                        sectionName: cubit
                                            .sections[cubit.sectionIndex!].id,
                                      );
                                    } else {
                                      cubit.getAllAds(
                                        isRefresh: true,
                                        sectionName: cubit.sectionIndex == null
                                            ? null
                                            : cubit
                                                .sections[cubit.sectionIndex!]
                                                .id,
                                      );
                                    }
                                    Navigator.pop(context);
                                  } else {
                                    cubit.selectAreaName(name);

                                    cubit.selectArea(n['name']);
                                    if (cubit.isAdsHome == false) {
                                      cubit.getAds(
                                        isRefresh: true,
                                        sectionName: cubit
                                            .sections[cubit.sectionIndex!].id,
                                      );
                                    } else {
                                      cubit.getAllAds(
                                        isRefresh: true,
                                        sectionName: cubit.sectionIndex == null
                                            ? null
                                            : cubit
                                                .sections[cubit.sectionIndex!]
                                                .id,
                                      );
                                    }

                                    Navigator.pop(context);
                                  }
                                },
                                child: ListTile(
                                  leading:
                                      const Icon(Icons.location_on_outlined),
                                  title: Text(n['name']),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
