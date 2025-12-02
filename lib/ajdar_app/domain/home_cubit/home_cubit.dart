import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ajder_project/ajdar_app/data/api_call/http_helper.dart';
import 'package:ajder_project/ajdar_app/data/model/dynamic_field_model.dart';
import 'package:ajder_project/ajdar_app/data/model/home/ads_home_model.dart';
import 'package:ajder_project/ajdar_app/data/model/home/wishlist_model.dart';
import 'package:ajder_project/ajdar_app/data/model/me_model.dart';
import 'package:ajder_project/ajdar_app/domain/home_cubit/home_state.dart';
import 'package:ajder_project/ajdar_app/ui/pages/add_ads/add_ads_page/add_ads_page.dart';
// import 'package:ajder_project/ajdar_app/domain/home_cubit/section_controller.dart';
// import 'package:ajder_project/ajdar_app/ui/pages/add_ads/sections_selection_page/sections_selections_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/ads_page/ads_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/profile_page/profile_page.dart';
import 'package:ajder_project/ajdar_app/ui/pages/wishlist_page/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../../conest.dart';
import '../../data/model/home/section_model.dart';
import '../../data/model/home/sub_section_model.dart';
import '../../data/url/home_url/home_url.dart';
import '../../ui/pages/home_page/home_page.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  // var
  int selectIndex = 0;
  int current = -1;
  List<dynamic> items = [];
  PageController controller = PageController();
  bool isAdvanced = false;
  trueAdvanced() {
    isAdvanced = true;
    emit(SelectIndex());
  }

  falseAdvanced() {
    isAdvanced = false;
    emit(SelectIndex());
  }

  goToAds() {
    selectIndex = 1;
    emit(SelectIndex());
  }

  goToMyAds() {
    selectIndex = 4;
    emit(SelectIndex());
  }

  goToHome() {
    selectIndex = 0;
    emit(SelectIndex());
  }

  void selectTab(int index) {
    current = index;
    emit(HomeSelectTabState());
  }

  List<Widget> pages = [
    HomePage(),
    AdsPage(),
    AddAdsPage(),
    // SectionsSelectionsPage(),
    WishlistPage(),
    ProfilePage(),
  ];
  void selectPage(int index) {
    selectIndex = index;
    emit(HomeSelectPageState());
  }

  bool isLight = box.read('isDark') ?? false;
  void switchTheme(bool value) {
    isLight = value;
    box.write('isDark', isLight);
    emit(SwitchThemeHomeState());
  }

  logoutConnect() async {
    emit(LogoutLoadingState());
    HttpHelper.postData(url: 'auth/logout', body: {})
        .then((value) {
          if (value.statusCode == 200) {
            emit(LogoutSuccessState());
          } else {
            emit(LogoutErrorState());
          }
        })
        .catchError((e) {
          emit(LogoutErrorConnectState(error: e.toString()));
        });
  }

  // import 'dart:async';

  List<SectionModel> sections = [];
  List<SectionModel> originalSections = [];
  String sectionStatus = '';
  bool sectionLoading = true;
  bool searching = false; // لمعرفة إذا البحث جاري

  Timer? _searchDebounce;

  sectionConnect() {
    emit(SectionLoading());
    HttpHelper.getData(url: HomeUrl().sectionUrl)
        .then((value) {
          if (value.statusCode == 200) {
            sections.clear();
            originalSections.clear();

            List data = jsonDecode(value.body);
            if (data.isNotEmpty) {
              for (var element in data) {
                SectionModel section = SectionModel.fromJson(element);
                sections.add(section);
                originalSections.add(section);
              }
              sectionStatus = 'Data';
            } else {
              sectionStatus = 'No Data';
            }
            sectionLoading = false;
            emit(SectionSuccess());
          } else {
            sectionStatus = 'Error';
            sectionLoading = false;
            emit(SectionError());
          }
        })
        .catchError((e) {
          sectionStatus = 'Error Connect';
          sectionLoading = false;
          emit(SectionErrorConnect());
          print(e);
        });
  }

  void searchSections(String query) {
    _searchDebounce?.cancel();

    searching = true;
    emit(SectionLoading()); // لتحديث الواجهة وإظهار المؤشر

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        sections = List.from(originalSections);
      } else {
        sections = originalSections.where((section) {
          final title = section.title?.toLowerCase() ?? '';
          return title.contains(query.toLowerCase());
        }).toList();
      }

      if (sections.isEmpty) {
        sectionStatus = 'No Search Results';
      } else {
        sectionStatus = 'Data';
      }

      searching = false;
      emit(SectionSuccess()); // تحديث الواجهة بعد البحث
    });
  }

  List<SubSectionModel> subSections = [];
  String subSectionStatus = '';
  bool subSectionLoading = true;
  subSectionConnect(var id) {
    subSectionLoading = true;
    subSections.clear();
    // String subSectionStatus = '';

    emit(SectionLoading());
    HttpHelper.getData(url: "${HomeUrl().subSectionURL}$id")
        .then((value) {
          print(value.body);
          if (value.statusCode == 200) {
            if (subSections.isEmpty) {
              List data = jsonDecode(value.body);
              if (data.isNotEmpty) {
                for (var element in data) {
                  subSections.add(SubSectionModel.fromJson(element));
                }
                subSectionStatus = 'Data';
                print(value.body);
                subSectionLoading = false;
                emit(SectionSuccess());
              } else {
                subSectionStatus = 'No Data';
                subSectionLoading = false;

                emit(SectionNoData());
              }
            }
            print(subSectionStatus);
          } else {
            subSectionStatus = 'Error';
            subSectionLoading = false;
            emit(SectionError());
            print(subSectionStatus);
          }
        })
        .catchError((e) {
          subSectionStatus = 'Error Connect';
          subSectionLoading = false;
          emit(SectionErrorConnect());
          print(subSectionStatus);
          print(e);
        });
  }

  List<AdsHomeModel> ads = [];
  List<bool> isWishlist = [];

  int adsPage = 1;
  bool adsHasMore = true;
  bool adsLoading = false;
  final int adsPageSize = 10;

  Future getAds({
    bool isRefresh = false,
    int? sectionName,
    int? subSection,
    String search = '',
    bool isUser = false,
    String? min,
    String? max,
  }) async {
    print('loading');
    if (adsLoading || (!adsHasMore && !isRefresh)) return;

    emit(AdsLoadingState());

    if (isRefresh) {
      adsPage = 1;
      ads.clear();
      isWishlist.clear();
      adsHasMore = true;
    }
    // String url = sectionName=null?"":'';

    String homeUrl = 'AdHome/search';
    String userUrl = 'Ad/my-ads';

    adsLoading = true;

    try {
      final response =
          // isUser?  await HttpHelper.getData(
          //   url:userUrl ,
          // ):
          await HttpHelper.postMultiData(
            url: homeUrl,
            body: {
              search == '' ? "" : "searchTerm": "$search",
              sectionName == null ? "" : "categoryId": "${sectionName}",
              subSection == null ? "" : "subCategoryId": "${subSection}",
              // max == null ? "" : "maxPrice": "${max}",
              // min == null ? "" : "minPrice": "${min}",
              "pageNumber": "$allAdsPage",
              "pageSize": "$allAdsPageSize",
              // "minPrice": "${min ?? ""}",
              areaName == '' && area == '' ? "" : "location":
                  "${areaName + (area == ' - كل المدن' ? "" : area)}",
            },
          );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        final List newAds = jsonData['items'];

        // إضافة الإعلانات الجديدة
        ads.addAll(newAds.map((e) => AdsHomeModel.fromJson(e)).toList());

        // توسيع قائمة المفضلة بنفس طول الإعلانات
        while (isWishlist.length < ads.length) {
          isWishlist.add(false);
        }

        // فحص المفضلة للعناصر الجديدة فقط
        for (var i = ads.length - newAds.length; i < ads.length; i++) {
          checkWishList(ads[i].id!, i);
        }

        adsPage++;
        adsHasMore = newAds.length == adsPageSize;

        print("ads.length: ${ads.length}");
        emit(AdsSuccessState());
      } else {
        emit(AdsErrorState());
      }
    } catch (e) {
      print("eee: $e");
      emit(AdsErrorConnectState(error: e.toString()));
    }

    adsLoading = false;
  }

  String areaName = '';
  void selectAreaName(String newArea) {
    areaName = newArea;
    print(areaName);
    emit(SelectArea());
  }

  String area = '';
  void selectArea(String newArea) {
    area = " - $newArea";
    emit(SelectArea());
  }

  int? sectionIndex;
  void selectSection(int index) {
    sectionIndex = index;
    emit(SelectSubSection());
  }

  int? subSectionIndex;
  selectSubSection(int index) {
    subSectionIndex = index;
    emit(SelectSubSection());
  }

  clearSelectSubSection() {
    subSectionIndex = null;
    emit(SelectSubSection());
  }

  List<AdsHomeModel> userAds = [];
  int userAdsPage = 1;
  bool userAdsHasMore = true;
  bool userAdsLoading = false;
  final int userAdsPageSize = 10;
  Future getUserAds({
    bool isRefresh = false,
    int? sectionName,
    int? subSection,
    String search = '',
    bool isUser = false,
  }) async {
    if (userAdsLoading || (!userAdsHasMore && !isRefresh)) return;
    // ads.clear();
    print('loading');
    emit(AdsLoadingState());

    if (isRefresh) {
      userAdsPage = 1;
      userAds.clear();
      // isWishlist.clear();
      userAdsHasMore = true;
    }
    String userUrl = 'Ad/my-ads';

    userAdsLoading = true;

    return HttpHelper.getData(url: '$userUrl')
        .then((response) {
          print('then');
          print("response: ${response.statusCode}");
          if (response.statusCode == 200) {
            final jsonData = jsonDecode(response.body);
            final List newAds = jsonData;
            print("ads.length: ${userAds.length}");
            userAds.addAll(
              newAds.map((e) => AdsHomeModel.fromJson(e)).toList(),
            );
            // while (isWishlist.length < userAds.length) {
            //   isWishlist.add(false);
            // }

            // // فحص المفضلة للعناصر الجديدة فقط
            // for (var i = userAds.length - newAds.length; i < userAds.length; i++) {
            //   checkWishList(userAds[i].id!, i);
            // }
            userAdsPage++;
            userAdsHasMore = newAds.length == adsPageSize;
            print("ads.length: ${userAds.length}");
            emit(AdsSuccessState());
          } else {
            emit(AdsErrorState());
          }
          userAdsLoading = false;
        })
        .catchError((e) {
          print("eee: $e");
          userAdsLoading = false;
          emit(AdsErrorConnectState(error: e.toString()));
        });
  }

  int pageAds = 0;
  void nextPageAds() {
    pageAds++;
    emit(NextPageAds());
    if (pageAds == 1) {
      subSectionConnect(sections[sectionIndex!].id);
    }
    if (pageAds == 2) {
      dynamicFiledConnect();
    }
  }

  void removePageAds() {
    pageAds--;
    emit(NextPageAds());
  }

  List<DynamicFieldModel> dynamicFileds = [];
  String dynamicFiledStatus = '';
  bool dynamicFiledLoading = true;
  dynamicFiledConnect() {
    dynamicFiledLoading = true;
    dynamicFileds.clear();
    int? id = sections[sectionIndex!].id;
    int? subId = subSections[subSectionIndex!].id;
    // String subSectionStatus = '';

    emit(SectionLoading());
    HttpHelper.getData(
          url:
              "${HomeUrl().dynamicFiledURL}?CategoryId=$id&SubCategoryId=$subId",
        )
        .then((value) {
          print(value.statusCode);
          if (value.statusCode == 200) {
            if (dynamicFileds.isEmpty) {
              // print(jsonDecode(value.body)[1]);
              List data = jsonDecode(value.body);
              print(data);
              // print(data[7]);
              if (data.isNotEmpty) {
                for (var element in data) {
                  dynamicFileds.add(DynamicFieldModel.fromJson(element));
                }
                dynamicFiledStatus = 'Data';
                print(value.body);
                dynamicFiledLoading = false;
                selectedValues = List.filled(dynamicFileds.length, null);
                initDynamicTextCtrls();
                emit(SectionSuccess());
              } else {
                dynamicFiledStatus = 'No Data';
                dynamicFiledLoading = false;

                emit(SectionNoData());
              }
            }
            // print(dynamicFiledStatus);
          } else {
            dynamicFiledStatus = 'Error';
            dynamicFiledLoading = false;
            emit(SectionError());
            // print(dynamicFiledStatus);
          }
        })
        .catchError((e) {
          dynamicFiledStatus = 'Error Connect';
          dynamicFiledLoading = false;
          emit(SectionErrorConnect());
          // print(dynamicFiledStatus);
          // print('error: $e');
        });
  }

  List<String?> selectedValues = [];
  bool addAdsLoading = false;
  double uploadProgress = 0.0;
  Future<void> addAdsConnect({
    required List<File> images,
    required String location,
  }) async {
    addAdsLoading = true;
    emit(AddAdsLoading());
    print("dynamicFieldsFnish: $dynamicFieldsFnish");
    print(meData!.id);
    print(sections[sectionIndex!].id!);
    print(subSections[subSectionIndex!].id!);

    try {
      final response = await HttpHelper.uploadWithImagesAndData(
        imageUrl: images,
        // fields: fields,
        url: 'Ad/create-ad',
        fields: {
          'title': "${addAdsCtrls[1].text}",
          "description": "${addAdsCtrls[2].text}",
          "price": "${addAdsCtrls[0].text}",
          "location": "$location",
          "CategoryId": sections[sectionIndex!].id!,
          "SubCategoryId": subSections[subSectionIndex!].id!,
          "UserId": meData!.id,
          "fieldValues": dynamicFieldsFnish,
        },
        onProgress: (progress) {
          uploadProgress = progress;
          print('Upload progress: ${(progress * 100).toStringAsFixed(0)}%');
          // هنا يمكن تخزين progress في Cubit لتحديث واجهة المستخدم
          emit(UploadProgressState(progress: progress));
        },
      );
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        addAdsLoading = false;
        nextPageAds();
        emit(AddAdsSuccess(''));
      } else {
        addAdsLoading = false;
        emit(AddAdsError('خطأ: ${response.statusCode} - ${response.body}'));
      }
    } catch (e) {
      print("e: $e");
      addAdsLoading = false;
      emit(AddAdsError('استثناء: $e'));
    }
  }

  Map<int, List<String>> multiSelectedValues = {};
  Map<int, String?> fieldErrors = {}; // dynamicFieldId → رسالة الخطأ

  void toggleMultiSelect({
    required int index,
    required int fieldId,
    required String value,
    required bool isChecked,
  }) {
    multiSelectedValues.putIfAbsent(index, () => []);

    if (isChecked) {
      multiSelectedValues[index]!.add(value);
    } else {
      multiSelectedValues[index]!.remove(value);
    }

    // لو عندك API أو تحديث لازم تعمله
    updateDynamicFieldValue(
      dynamicFieldId: fieldId,
      newValue: multiSelectedValues[index]!.join(','),
    );

    emit(HomeStateUpdated()); // غيرها حسب حالتك
  }

  List<Map<String, dynamic>> dynamicFieldsFnish = [];

  void updateDynamicFieldValue({
    required int dynamicFieldId,
    required String newValue,
  }) {
    final index = dynamicFieldsFnish.indexWhere(
      (field) => field['dynamicFieldId'] == dynamicFieldId,
    );

    if (index != -1) {
      dynamicFieldsFnish[index]['value'] = newValue;
    } else {
      dynamicFieldsFnish.add({
        'dynamicFieldId': dynamicFieldId,
        'value': newValue,
      });
    }

    // إزالة الخطأ لو المستخدم عبّى قيمة
    if (newValue.isNotEmpty) {
      fieldErrors[dynamicFieldId] = null;
    }

    emit(DynamicFieldsUpdated());
  }

  static const int priceFieldId = -1;
  static const int titleFieldId = -2;
  static const int descFieldId = -3;
  static const int locationFieldId = -4;

  bool validateDynamicFields(List<DynamicFieldModel> fields) {
    bool isValid = true;
    fieldErrors.clear();

    // التحقق من الحقول الديناميكية
    for (var field in fields) {
      final existing = dynamicFieldsFnish.firstWhere(
        (f) => f['dynamicFieldId'] == field.id,
        orElse: () => {},
      );
      final value = existing.isNotEmpty ? existing['value'] : '';
      if (value == null || value.isEmpty) {
        fieldErrors[field.id!] = 'يجب تعبئة ${field.title}';
        isValid = false;
      }
    }

    // التحقق من الحقول الثابتة
    void checkStatic(int id, String title, TextEditingController ctrl) {
      if (ctrl.text.trim().isEmpty) {
        fieldErrors[id] = 'يجب تعبئة $title';
        isValid = false;
      }
      if (id == titleFieldId && ctrl.text.trim().length < 6) {
        fieldErrors[id] = 'يجب ان يكون 6 احرف على الاقل';
        isValid = false;
        // updateDynamicFieldValue(dynamicFieldId: id, newValue: ctrl.text.trim());
      }
      if (id == descFieldId && ctrl.text.trim().length < 11) {
        fieldErrors[id] = 'يجب ان يكون 10 احرف على الاقل';
        isValid = false;
        // updateDynamicFieldValue(dynamicFieldId: id, newValue: ctrl.text.trim());
      }
    }

    checkStatic(priceFieldId, 'سعر الإعلان', addAdsCtrls[0]);
    checkStatic(titleFieldId, 'عنوان الإعلان', addAdsCtrls[1]);
    checkStatic(descFieldId, 'وصف الإعلان', addAdsCtrls[2]);

    if (selectedGovernorate == null || selectedNeighborhood == null) {
      fieldErrors[locationFieldId] = 'يجب اختيار الموقع';
      isValid = false;
    } else {
      // updateDynamicFieldValue(
      //   dynamicFieldId: locationFieldId,
      //   newValue: '$selectedGovernorate - $selectedNeighborhood',
      // );
    }

    emit(DynamicFieldsValidation());
    return isValid;
  }

  String? selectedGovernorate;

  String? selectedNeighborhood;
  // بدل List
  Map<int, TextEditingController> dynamicTextCtrls = {};

  void initDynamicTextCtrls() {
    dynamicTextCtrls.clear();

    for (var field in dynamicFileds) {
      if (field.type == 'text' || field.type == 'number') {
        dynamicTextCtrls[field.id!] = TextEditingController();
      }
    }

    // الحقول الثابتة كمان
  }

  List<TextEditingController> addAdsCtrls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool meLoading = true;
  MeModel? meData;
  String meStatus = '';
  getProfileConnect() {
    meLoading = true;
    emit(MeLoading());
    HttpHelper.getData(url: 'Auth/user-details')
        .then((value) {
          print(value.body);
          if (value.statusCode == 200) {
            meData = MeModel.fromJson(jsonDecode(value.body));
            token = box.read('token');
            meStatus = 'Data';
            meLoading = false;
            emit(MeSuccess());
            // print(value.body);
          } else {
            meStatus = 'Error';
            meLoading = false;
            emit(MeError());
          }
        })
        .catchError((e) {
          meStatus = 'Error Connect';
          meLoading = false;
          print("EEE: $e");
          emit(MeErrorConnect());
        });
  }

  // List<bool> isWishlist = [];
  bool actionWishlistLoading = false;
  int? addIndex;
  addToWishlist(int index, int id) {
    isWishlist[index] = !isWishlist[index];
    emit(AddToWishList());

    addIndex = index;
    actionWishlistLoading = true;
    emit(ActionWishlistLoading());
    HttpHelper.postMultiData(url: 'Wishlist/add', body: {"adId": "$id"})
        .then((value) async {
          print(await value.stream.bytesToString());
          if (value.statusCode == 200) {
            actionWishlistLoading = false;
            emit(ActionWishlistSuccess());
          } else {
            actionWishlistLoading = false;
            isWishlist[index] = !isWishlist[index];
            emit(ActionWishlistError());
          }
        })
        .catchError((e) {
          print(e);
          actionWishlistLoading = false;
          isWishlist[index] = !isWishlist[index];
          emit(ActionWishlistErrorConnect());
        });
  }

  int? wishlistIndex;
  selectedWishlist(int index) {
    wishlistIndex = index;
    emit(SelectSubSection());
  }

  // bool actionWishlistLoading = false;
  // int? addIndex;
  removeToWishlist(int index, int id, {bool fromWishlist = false}) {
    if (fromWishlist) {
      // isWishlist[index] = !isWishlist[index];
      // emit(AddToWishList());

      // addIndex = index;
      actionWishlistLoading = true;
      emit(RemoveWishlistLoading());
      HttpHelper.postMultiData(url: 'Wishlist/remove', body: {"adId": "$id"})
          .then((value) {
            print(id);
            if (value.statusCode == 200) {
              actionWishlistLoading = false;
              wishlistData.remove(wishlistData[index]);
              emit(RemoveWishlistSuccess());
            } else {
              actionWishlistLoading = false;
              // isWishlist[index] = !isWishlist[index];
              emit(RemoveWishlistError());
            }
          })
          .catchError((e) {
            print(e);
            actionWishlistLoading = false;
            // isWishlist[index] = !isWishlist[index];
            emit(RemoveWishlistErrorConnect());
          });
    } else {
      isWishlist[index] = !isWishlist[index];
      emit(AddToWishList());

      addIndex = index;
      actionWishlistLoading = true;
      emit(RemoveWishlistLoading());
      HttpHelper.postMultiData(url: 'Wishlist/remove', body: {"adId": "$id"})
          .then((value) {
            print(id);
            if (value.statusCode == 200) {
              actionWishlistLoading = false;
              emit(RemoveWishlistSuccess());
            } else {
              actionWishlistLoading = false;
              isWishlist[index] = !isWishlist[index];
              emit(RemoveWishlistError());
            }
          })
          .catchError((e) {
            print(e);
            actionWishlistLoading = false;
            isWishlist[index] = !isWishlist[index];
            emit(RemoveWishlistErrorConnect());
          });
    }
  }

  bool checkLoading = true;

  void checkWishList(int id, int index) {
    checkLoading = true;
    emit(CheckLoading());

    HttpHelper.getData(url: 'Wishlist/check/$id')
        .then((value) {
          bool inWishlist = false;

          if (value.statusCode == 200) {
            print(value.body);
            inWishlist = jsonDecode(value.body)['isInWishlist'] == true;
          }

          if (index < isWishlist.length) {
            isWishlist[index] = inWishlist;
          }

          checkLoading = false;
          emit(CheckSuccess());
        })
        .catchError((e) {
          if (index < isWishlist.length) {
            isWishlist[index] = false;
          }
          checkLoading = false;
          emit(CheckErrorConnect());
        });
  }

  List<AdsHomeModel> allAds = [];
  // List<bool> isWishlist = [];
  bool isAdsHome = false;
  adsHome() {
    isAdsHome = true;
  }

  adsSection() {
    isAdsHome = false;
  }

  int allAdsPage = 1;
  bool allAdsHasMore = true;
  bool allAdsLoading = false;
  final int allAdsPageSize = 10;

  Future getAllAds({
    bool isRefresh = false,
    int? sectionName,
    int? subSection,
    String search = '',
    bool isUser = false,
    String? min,
    String? max,
  }) async {
    print('loading');
    if (allAdsLoading || (!allAdsHasMore && !isRefresh)) return;

    emit(AdsLoadingState());

    if (isRefresh) {
      allAdsPage = 1;
      allAds.clear();
      isWishlist.clear();
      allAdsHasMore = true;
    }

    String homeUrl = 'AdHome/search';
    String userUrl = 'Ad/my-ads';

    allAdsLoading = true;

    try {
      final response =
          // isUser?  await HttpHelper.getData(
          //   url:userUrl ,
          // ):
          await HttpHelper.postMultiData(
            url: homeUrl,
            body: {
              search == '' ? "" : "searchTerm": "$search",
              sectionName == null ? "" : "categoryId": "${sectionName}",
              subSection == null ? "" : "subCategoryId": "${subSection}",
              // max == null ? "" : "maxPrice": "${max}",
              // min == null ? "" : "minPrice": "${min}",
              "pageNumber": "$allAdsPage",
              "pageSize": "$allAdsPageSize",
              // "minPrice": "${min ?? ""}",
              areaName == '' && area == '' ? "" : "location":
                  "${areaName + (area == ' - كل المدن' ? "" : area)}",
            },
          );

      // print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(await response.stream.bytesToString());
        final List newAds = jsonData['items'];

        // إضافة الإعلانات الجديدة
        allAds.addAll(newAds.map((e) => AdsHomeModel.fromJson(e)).toList());

        // توسيع قائمة المفضلة بنفس طول الإعلانات
        while (isWishlist.length < allAds.length) {
          isWishlist.add(false);
        }

        // فحص المفضلة للعناصر الجديدة فقط
        for (var i = allAds.length - newAds.length; i < allAds.length; i++) {
          checkWishList(allAds[i].id!, i);
        }

        allAdsPage++;
        allAdsHasMore = newAds.length == allAdsPageSize;

        print("ads.length: ${allAds.length}");
        emit(AdsSuccessState());
      } else {
        print('Error: ${await response.stream.bytesToString()}');
        emit(AdsErrorState());
      }
    } catch (e) {
      print("eee: $e");
      emit(AdsErrorConnectState(error: e.toString()));
    }

    allAdsLoading = false;
  }

  bool wishlistLoading = true;
  List<WishlistModel> wishlistData = [];
  String wishlistStatus = '';
  Future getWishList() async {
    wishlistLoading = true;
    wishlistData.clear();
    isWishlist.clear();
    emit(WishlistLoading());
    return await HttpHelper.getData(url: 'Wishlist')
        .then((value) {
          // print(value.body);
          if (value.statusCode == 200) {
            // print(value.body);
            if (wishlistData.isEmpty) {
              List data = jsonDecode(value.body)['items'] as List;
              // print(data.toString());
              if (data.isNotEmpty) {
                for (var element in data) {
                  wishlistData.add(WishlistModel.fromJson(element));
                  print('data');
                }
                // print(value.body);
                while (isWishlist.length < wishlistData.length) {
                  isWishlist.add(true);
                }
                wishlistStatus = 'Data';

                wishlistLoading = false;
                emit(WishlistSuccess());
              } else {
                wishlistStatus = 'No Data';
                wishlistLoading = false;

                emit(WishlistNoData());
              }
            }
            print(subSectionStatus);
            // emit(WishlistSuccess());
          } else {
            wishlistStatus = 'Error';
            wishlistLoading = false;
            emit(WishlistError());
          }
        })
        .catchError((e) {
          print('e: $e');
          wishlistStatus = 'Error Connect';
          wishlistLoading = false;
          emit(WishlistErrorConnect());
        });
  }

  bool isAuth = false;
  void isSuccessAut() {
    emit(IsAuthLoading());
    HttpHelper.getData(url: 'Auth/is-auth')
        .then((value) {
          print("isAuth: ${value.statusCode}");
          if (value.statusCode == 200) {
            isAuth = true;

            emit(IsAuthSuccess());
            refreshToken();
            // getProfileConnect();
          } else {
            isAuth = false;
            refreshToken();
            emit(IsAuthError());
          }
        })
        .catchError((e) {
          isAuth = false;
          emit(IsAuthError());
          print("e: $e");
        });
  }

  refreshToken() {
    HttpHelper.postMultiData(
          url: 'Auth/refresh-token-flutter',
          body: {"refreshToken": "${box.read('refreshToken')}", "day": 7},
        )
        .then((value) async {
          print(value.statusCode);

          // print(await value.stream.bytesToString());
          if (value.statusCode == 200) {
            box.write(
              'token',
              jsonDecode(await value.stream.bytesToString())['accessToken'],
            );
            token = box.read('token');
            getProfileConnect();
            emit(SelectArea());
          } else {
            box.remove('token');
            token = '';
          }
        })
        .catchError((e) {
          print("eee: $e");
        });
  }

  bool deleteWishlistLoading = false;
  deleteAllWishList() {
    deleteWishlistLoading = true;

    emit(DeleteWishlistLoading());
    HttpHelper.postMultiData(url: 'Wishlist/clear', body: {})
        .then((value) {
          // print(id);
          if (value.statusCode == 200) {
            deleteWishlistLoading = false;

            wishlistData.clear();
            emit(DeleteWishlistSuccess());
          } else {
            deleteWishlistLoading = false;
            // isWishlist[index] = !isWishlist[index];
            emit(DeleteWishlistError());
          }
        })
        .catchError((e) {
          print(e);
          deleteWishlistLoading = false;
          // isWishlist[index] = !isWishlist[index];
          emit(DeleteWishlistErrorConnect());
        });
  }

  late AdsHomeModel adsDetails;
  bool adsDetailsLoading = true;
  adsDetailsConnect(int id) {
    adsDetailsLoading = true;
    emit(AdsLoadingState());
    HttpHelper.getData(url: 'Ad/$id')
        .then((value) {
          print(value.body);
          if (value.statusCode == 200) {
            adsDetails = AdsHomeModel.fromJson(jsonDecode(value.body)['data']);
            adsDetailsLoading = false;
            emit(AdsSuccessState());
          } else {
            adsDetailsLoading = false;
            emit(AdsErrorState());
          }
        })
        .catchError((e) {
          adsDetailsLoading = false;
          emit(AdsErrorConnectState(error: e));
        });
  }

  bool updatePhoneLoading = false;
  updatePhone(String phone) {
    updatePhoneLoading = true;
    emit(UpdatePhoneLoading());
    HttpHelper.putMultiData(
          url: 'Auth/update-phone',
          body: {"newPhoneNumber": phone},
        )
        .then((value) {
          // print(value.body);
          if (value.statusCode == 200 || value.statusCode == 201) {
            updatePhoneLoading = false;
            emit(UpdatePhoneSuccess());
            getProfileConnect();
          } else {
            updatePhoneLoading = false;
            emit(UpdatePhoneError());
          }
        })
        .catchError((e) {
          updatePhoneLoading = false;
          emit(UpdatePhoneErrorConnect());
        });
  }

  bool updateUserNameLoading = false;
  updateUsername(String username) {
    updateUserNameLoading = true;
    emit(UpdateUserLoading());
    HttpHelper.putMultiData(
          url: 'Auth/update-username',
          body: {"newUsername": username},
        )
        .then((value) {
          // print(value.body);
          if (value.statusCode == 200 || value.statusCode == 201) {
            updateUserNameLoading = false;
            emit(UpdateUserSuccess());
            getProfileConnect();
          } else {
            updateUserNameLoading = false;
            emit(UpdateUserError());
          }
        })
        .catchError((e) {
          updateUserNameLoading = false;
          emit(UpdateUserErrorConnect());
        });
  }

  clearAdData() {
    addAdsCtrls[0].clear();
    addAdsCtrls[1].clear();
    addAdsCtrls[2].clear();
    dynamicFieldsFnish.clear();
  }

  String token = box.read('token') ?? '';
  clearToken() {
    box.remove('token');
    token = '';
    emit(LogoutSuccessState());
  }

  bool sliderLoading = true;
  List sliderData = [];
  String sliderStatus = '';
  sliderConnect() {
    print('loading');
    sliderLoading = true;
    emit(SliderLoading());
    HttpHelper.getData(url: 'Home/carousel')
        .then((value) {
          print(value.statusCode);
          if (value.statusCode == 200) {
            if (jsonDecode(value.body).isNotEmpty) {
              sliderData = jsonDecode(value.body);
              sliderStatus = 'Data';
              sliderLoading = false;
              emit(SliderSuccess());
            } else {
              sliderStatus = 'No Data';
              sliderLoading = false;
              emit(SliderNoData());
            }
          } else {
            sliderStatus = 'Error';
            sliderLoading = false;
            emit(SliderError());
          }
        })
        .catchError((e) {
          print(e.toString());
          sliderStatus = 'Error Connect';
          sliderLoading = false;
          emit(SliderError());
        });
  }

  bool deleteLoading = false;

  deleteAccount() {
    deleteLoading = true;
    emit(DeleteLoading());
    HttpHelper.deleteData(url: 'Auth/delete-account')
        .then((value) {
          if (value.statusCode == 200) {
            deleteLoading = false;
            box.remove('token');
            token = '';
            emit(DeleteSuccess());
          } else {
            deleteLoading = false;
            emit(DeleteError());
          }
        })
        .catchError((e) {
          deleteLoading = false;
          emit(DeleteErrorConnect());
        });
  }

  List<TextEditingController> deleteCtrls = [];
}
