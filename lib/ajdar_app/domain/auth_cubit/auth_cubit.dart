import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ajder_project/ajdar_app/data/api_call/http_helper.dart';
import 'package:ajder_project/ajdar_app/data/url/user_url/info_url.dart';
import 'package:ajder_project/ajdar_app/data/url/user_url/user_url.dart';
import 'package:ajder_project/ajdar_app/domain/auth_cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../conest.dart';
// import 'package:geolocator/geolocator.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  // attribute

  int remainSeconds = 900;
  Timer? _timer;
  String time = '00:00';
  double lat = 0.0;
  double lon = 0.0;

  // List<Placemark> place = [];
  File? image;
  final _pickedFile = ImagePicker();
  // login
  TextEditingController phoneLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  // register

  TextEditingController nameValue = TextEditingController();
  TextEditingController phoneValue = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController identityNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  bool isEnablePhone = false;
  bool isErrorPhone = false;
  bool isEnablePhoneRegister = false;
  bool isErrorPhoneRegister = false;
  bool isEnableName = false;
  bool isErrorName = false;
  bool isEnableOtp = false;
  String code = '';
  // methods
  // register
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool obscure = true;
  void sw() {
    obscure = !obscure;
    emit(HiddenPassword());
  }

  bool obscureRe = true;
  void swRe() {
    obscureRe = !obscureRe;
    emit(HiddenPassword());
  }

  /// 📷 اختيار الصورة من الكاميرا أو المعرض مع التحقق من الأذونات
  Future<void> getImage({required ImageSource source}) async {
    try {
      // ✅ التحقق من الإذن قبل فتح الكاميرا أو المعرض
      // bool permissionGranted = await _requestPermission(source);
      // if (!permissionGranted) {
      //   // errorMessage(
      //   //   title: 'صلاحية مفقودة',
      //   //   message: source == ImageSource.camera
      //   //       ? 'يرجى السماح بالوصول للكاميرا من إعدادات الجهاز.'
      //   //       : 'يرجى السماح بالوصول إلى الصور من إعدادات الجهاز.',
      //   // );
      //   return;
      // }

      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        await _cropImage(File(pickedFile.path));
      }
    } catch (e) {
      print("❌ خطأ أثناء اختيار الصورة: $e");
      // errorMessage(title: 'حدث خطأ', message: 'تعذر اختيار الصورة.');
    }
  }

  /// ✂️ قص الصورة بعد الالتقاط
  Future<void> _cropImage(File selectedFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: selectedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1), // ✅ مربعة
        compressQuality: 96,
        maxWidth: 150,
        maxHeight: 150,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "قص الصورة",
            lockAspectRatio: true,
            initAspectRatio: CropAspectRatioPreset.square,
          ),
          IOSUiSettings(title: "قص الصورة", aspectRatioLockEnabled: true),
        ],
      );

      if (croppedFile != null) {
        imageFile = File(croppedFile.path);
        box.write('image', imageFile!.path);
        emit(SelectImageSuccess()); // إذا كنت تستخدم Bloc
      }
    } catch (e) {
      print("❌ خطأ أثناء قص الصورة: $e");
    }
  }

  /// ✅ طلب إذن الكاميرا أو الصور حسب المصدر
  // Future<bool> _requestPermission(ImageSource source) async {
  //   Permission permission;

  //   if (source == ImageSource.camera) {
  //     permission = Permission.camera;
  //   } else {
  //     if (Platform.isIOS) {
  //       permission = Permission.photos;
  //     } else if (Platform.isAndroid && Platform.version.contains('13')) {
  //       permission = Permission.photos;
  //     } else {
  //       permission = Permission.storage;
  //     }
  //   }

  //   var status = await permission.request();

  //   if (status.isGranted) return true;

  //   if (status.isPermanentlyDenied) {
  //     await openAppSettings(); // توجيه المستخدم للإعدادات
  //   }

  //   return false;
  // }

  void registerConnect() {
    if (imageFile == null) {
      emit(ValidationImage());
    } else {
      print(phoneValue.text);
      emit(AuthRegisterLoadingState());
      HttpHelper.postDataWithImage(
            url: UserUrl().registerURL,
            body: {
              'UserName': nameValue.text,
              'Email': '${emailCtrl.text}',
              'PhoneNumber': '+963${phoneValue.text}',
              "Password": "${passwordCtrl.text}",
            },
            fileKey: 'image',
            filePath: imageFile != null ? imageFile!.path : '',
          )
          .then((value) async {
            Map<String, dynamic> message = jsonDecode(
              await value.stream.bytesToString(),
            );
            print(message);
            if (value.statusCode == 200) {
              // startCountdown(900);
              box.write('email', emailCtrl.text);
              emit(AuthRegisterSuccessState(registerData: message));
            } else {
              if (message['message'] ==
                  'OTP sent successfully. Please check your email') {
                emit(
                  AuthRegisterAccountFoundConnectState(
                    registerConnectData: message,
                  ),
                );
              } else {
                emit(
                  AuthRegisterErrorConnectState(
                    registerConnectErrorData: message,
                  ),
                );
              }
            }
          })
          .catchError((e) {
            print(e);
            emit(AuthRegisterErrorState(error: e.toString()));
          });
    }
  }

  // enable

  enablePhoneLoginValue(String value) {
    if (value.isNotEmpty) {
      if (value.length > 9) {
        isEnablePhone = false;
        isErrorPhone = true;
        emit(DisableButton());
      } else if (value.startsWith('5') && value.length < 9) {
        isEnablePhone = false;
        isErrorPhone = false;
        emit(DisableButton());
      } else if (value.startsWith('5') && value.length > 9) {
        isEnablePhone = false;
        isErrorPhone = true;
        emit(DisableButton());
      } else if (value.startsWith('5') && value.length == 9) {
        isEnablePhone = true;
        isErrorPhone = false;
        emit(EnableButton());
      } else {
        isEnablePhone = false;
        isErrorPhone = true;
        emit(DisableButton());
      }
    } else {
      isEnablePhone = false;
      isErrorPhone = false;
      emit(DisableButton());
    }
  }

  enablePhoneRegisterValue(String value) {
    if (value.isNotEmpty) {
      if (value.length > 9) {
        isEnablePhoneRegister = false;
        isErrorPhoneRegister = true;
        emit(DisableButton());
      } else if (value.startsWith('9') && value.length < 9) {
        isEnablePhoneRegister = false;
        isErrorPhoneRegister = false;
        emit(DisableButton());
      } else if (value.startsWith('9') && value.length > 9) {
        isEnablePhoneRegister = false;
        isErrorPhoneRegister = true;
        emit(DisableButton());
      } else if (value.startsWith('9') && value.length == 9) {
        isEnablePhoneRegister = true;
        isErrorPhoneRegister = false;
        emit(EnableButton());
      } else {
        isEnablePhoneRegister = false;
        isErrorPhoneRegister = true;
        emit(DisableButton());
      }
    } else {
      isEnablePhoneRegister = false;
      isErrorPhoneRegister = false;
      emit(DisableButton());
    }
  }

  enableNameValue(String value) {
    if (value.isNotEmpty) {
      if (RegExp(r'^[\u0621-\u064Aa-zA-Z\s]+$').hasMatch(value) &&
          value.length < 3) {
        isEnableName = false;
        isErrorName = false;
        emit(DisableButton());
      } else if (RegExp(r'^[\u0621-\u064Aa-zA-Z\s]+$').hasMatch(value) &&
          (value.length >= 3)) {
        isEnableName = true;
        isErrorName = false;
        emit(EnableButton());
      } else {
        isEnableName = false;
        isErrorName = true;
        emit(DisableButton());
      }
    } else {
      isEnableName = false;
      isErrorName = false;
      emit(DisableButton());
    }
  }

  bool isEnableEmail = false;
  bool isErrorEmail = false;
  enableEmailValue(String value) {
    if (value.isNotEmpty) {
      String emailSource = r'^[a-zA-Z0-9._%]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$';
      RegExp regExp = RegExp(emailSource);
      if (regExp.hasMatch(value)) {
        isEnableEmail = true;
        isErrorEmail = false;
        emit(EnableButton());
        // update();
      } else {
        isEnableEmail = false;
        isErrorEmail = true;
        emit(EnableButton());
        // update();
      }
    } else {
      //
      isEnableEmail = false;
      isErrorEmail = false;
      emit(EnableButton());
      // update();
    }
  }

  bool isEnablePassword = false;
  bool isErrorPassword = false;

  enablePasswordValue(String value) {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~^%]).{8,}$',
    );

    if (value.isNotEmpty) {
      if (passwordRegex.hasMatch(value)) {
        // password is valid
        isEnablePassword = true;
        isErrorPassword = false;
      } else {
        // password is not valid
        isEnablePassword = false;
        isErrorPassword = true;
      }
    } else {
      // empty
      isEnablePassword = false;
      isErrorPassword = false;
    }

    emit(EnableButton());
  }

  // login
  void loginConnect() async {
    emit(AuthLoginLoadingState());
    HttpHelper.postMultiData(
          url: UserUrl().loginURL,
          body: {
            // 'phone': '00966${phoneLogin.text}',
            'email': '${phoneLogin.text}',
            "password": "${passwordLogin.text}",
          },
        )
        .then((value) async {
          print("email: ${phoneLogin.text} password: ${passwordLogin.text}");
          String data = await value.stream.bytesToString();
          print(data);
          if (value.statusCode == 200) {
            // box.write('phone', phoneLogin.text);
            emit(AuthLoginSuccessState(loginData: jsonDecode(data)));
          } else {
            if (jsonDecode(data)['message'] ==
                'Email not confirmed. Verification email has been sent.') {
              emit(OtpAccount());
            } else {
              emit(
                AuthLoginErrorConnectState(
                  loginConnectErrorData: jsonDecode(data),
                ),
              );
            }
          }
        })
        .catchError((e) {
          print(e);
          emit(AuthLoginErrorState(error: e.toString()));
        });
  }

  enableOtp(String value) {
    if (value.isNotEmpty && value.length == 6) {
      isEnableOtp = true;
      emit(EnableButton());
    } else {
      isEnableOtp = false;
      emit(DisableButton());
    }
  }

  // verify
  void verifyCodeConnect() async {
    // loading
    emit(AuthVerifyLoadingState());
    print(phoneValue.text);
    print(code);
    HttpHelper.postMultiData(
          url: UserUrl().verifyURL,
          body: {'email': '${box.read('email')}', 'otp': code},
        )
        .then((value) async {
          // print(await value.stream.bytesToString());
          print(value.statusCode);
          if (value.statusCode == 200) {
            // verify success

            _timer!.cancel();
            box.remove('timerSecond');
            emit(
              AuthVerifySuccessState(
                verifyData: jsonDecode(await value.stream.bytesToString()),
              ),
            );
          } else {
            // verify error
            emit(
              AuthVerifyErrorConnectState(
                verifyConnectErrorData: jsonDecode(
                  await value.stream.bytesToString(),
                ),
              ),
            );
          }
          // print(value.body);
        })
        .catchError((e) {
          // error connect
          emit(AuthVerifyErrorState(error: e.toString()));
        });
  }

  // recent
  void recentCode() async {
    emit(AuthRecentLoadingState());
    print(box.read('email'));
    HttpHelper.postMultiData(
          url: UserUrl().recentURL,
          body: {'email': '${box.read('email')}'},
        )
        .then((value) async {
          // print(value.body);
          // startCountdown(900);
          if (value.statusCode == 200) {
            startCountdown(120);
            emit(
              AuthRecentSuccessState(
                recentData: jsonDecode(await value.stream.bytesToString()),
              ),
            );
          } else {
            emit(
              AuthRecentErrorConnectState(
                errorData: jsonDecode(await value.stream.bytesToString()),
              ),
            );
          }
        })
        .catchError((e) {
          print(e.toString());
          emit(AuthRecentErrorState(error: e.toString()));
        });
  }

  // timer
  void startCountdown(int second) {
    const oneSec = const Duration(seconds: 1);
    remainSeconds = second;
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (remainSeconds == 0) {
        box.write('timerSecond', 0);

        timer.cancel();
        emit(AuthVerifyEndTimeState());
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time =
            minutes.toString().padLeft(2, '0') +
            ':' +
            seconds.toString().padLeft(2, '0');
        remainSeconds--;
        box.write('timerSecond', remainSeconds);

        emit(AuthVerifyStartTimeState());
      }
    });
  }

  // location
  Future getLocation() async {
    // emit(LocationLoadingState());
    // bool serviceLocation;
    // LocationPermission permission;
    // serviceLocation = await Geolocator.isLocationServiceEnabled();
    // if (serviceLocation == false) {
    //   emit(LocationDisableState());
    //   // Get.defaultDialog(title: 'Location Service is Disabled');
    // }
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Container();
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   return Container();
    // }
    // // emit(LocationLoadingState());
    // return await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.high,
    // ).then((value) {
    //   lat = value.latitude;
    //   lon = value.longitude;
    //   // checkLoading.value = false;
    //   emit(LocationSuccessState());
    //   print(lat);
    //   print(lon);
    // });
  }

  // address
  Future getAddress() async {
    // loading
    // emit(AddressLoadingState());
    // emit(AddressSuccessState());
    // try {
    //   await setLocaleIdentifier('ar');
    //   place = await placemarkFromCoordinates(
    //     lat,
    //     lon,
    //   );

    //   // success
    //   emit(AddressSuccessState());
    //   print(place[0]);
    // } catch (e) {
    //   print(e);
    //   // false
    //   emit(AddressErrorState());
    // }
  }

  bool isCompleteIdNumber = false;
  bool isCompleteShowError = false;
  idNumberValidate(String value) {
    if (value.isNotEmpty) {
      if (value.length > 12) {
        isCompleteIdNumber = false;
        isCompleteShowError = true;
        emit(DisableButton());
      } else if (value.length < 12) {
        isCompleteIdNumber = false;
        isCompleteShowError = false;
        emit(DisableButton());
      } else {
        isCompleteIdNumber = true;
        isCompleteShowError = false;
        emit(EnableButton());
      }
    } else {
      isCompleteIdNumber = false;
      isCompleteShowError = false;
      emit(DisableButton());
    }
  }

  bool isCompleteHouseNumber = true;
  bool isHouseNumberShowError = false;
  houseNumberValidate(String value) {
    if (value.isNotEmpty) {
      isHouseNumberShowError = true;
      isHouseNumberShowError = false;
      emit(EnableButton());
    } else {
      isCompleteHouseNumber = true;
      isHouseNumberShowError = false;
      emit(EnableButton());
    }
  }

  // complete info
  void completeInfo(String city) {
    // emit(CompleteLoadingState());
    // if (place.isNotEmpty) {
    //   HttpHelper.postDataWithImage(
    //           url: InfoURL().completeInfoURL,
    //           body: {
    //             'city': city,
    //             'lon': '$lon',
    //             'lat': '$lat',
    //             'identity_number': identityNumber.text,
    //             'house_number': houseNumber.text,
    //             'street': place[0].street ?? street.text,
    //             'area': 'المدينة المنورة',
    //             'country': 'المملكة العربية السعودية',
    //             'neighborhood': place[0].subLocality!.isNotEmpty
    //                 ? '${place[0].subLocality}'
    //                 : neighborhood.text,
    //           },
    //           fileKey: 'images[]',
    //           filePath: image!.path)
    //       .then(
    //     (value) async {
    //       if (value.statusCode == 200) {
    //         print(jsonDecode(await value.stream.bytesToString()));
    //         // success
    //         emit(CompleteSuccessState());
    //       } else {
    //         print(value.statusCode);
    //         // error
    //         emit(CompleteErrorState(error: value.reasonPhrase!));
    //         // print(value.reasonPhrase);
    //         print(jsonDecode(await value.stream.bytesToString()));
    //       }
    //     },
    //   ).catchError((e) {
    //     // error
    //     emit(CompleteErrorConnectState(error: e.toString()));
    //   });
    // } else {
    //   emit(CompleteLoadingState());
    //   if (place.isEmpty) {
    //     HttpHelper.postDataWithImage(
    //             url: InfoURL().completeInfoURL,
    //             body: {
    //               'city': city,
    //               'lon': '$lon',
    //               'lat': '$lat',
    //               'identity_number': identityNumber.text,
    //               'house_number': houseNumber.text,
    //               'street': street.text,
    //               'area': 'المدينة المنورة',
    //               'country': 'المملكة العربية السعودية',
    //               'neighborhood': neighborhood.text,
    //             },
    //             fileKey: 'images[]',
    //             filePath: image!.path)
    //         .then(
    //       (value) async {
    //         if (value.statusCode == 200) {
    //           print(jsonDecode(await value.stream.bytesToString()));
    //           // success
    //           emit(CompleteSuccessState());
    //         } else {
    //           print(value.statusCode);
    //           // error
    //           emit(CompleteErrorState(error: value.reasonPhrase!));
    //           // print(value.reasonPhrase);
    //           print(jsonDecode(await value.stream.bytesToString()));
    //         }
    //       },
    //     ).catchError((e) {
    //       // error
    //       emit(CompleteErrorConnectState(error: e.toString()));
    //     });
    //   }
    // }
  }

  Future imageFromGallery(BuildContext context) async {
    var pickedImage = await _pickedFile.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(ChosePhotoSuccess());
    } else {}
    Navigator.pop(context);
  }

  Future imageFromCamera(BuildContext context) async {
    var pickedImage = await _pickedFile.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(ChosePhotoSuccess());
    } else {}
    Navigator.pop(context);
  }

  Map<String, dynamic> profileData = {};
  bool profileLoading = true;
  void profileConnect() {
    emit(ProfileLoadingState());
    HttpHelper.getData(url: InfoURL().profileURL)
        .then((value) {
          if (value.statusCode == 200) {
            print(jsonDecode(value.body));
            profileData = jsonDecode(value.body);
            profileLoading = false;
            emit(ProfileSuccessState());
          } else {
            profileLoading = false;
            emit(ProfileErrorState(error: jsonDecode(value.body)));
          }
        })
        .catchError((e) {
          profileLoading = false;
          emit(ProfileErrorConnectState(error: e.toString()));
        });
  }

  String selectDate = 'Yearly';
  List<String> d = ['Yearly', '6 Month'];
  bool createLoading = false;
  createContract() {
    createLoading = true;
    print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    emit(ContractLoading());
    HttpHelper.postData(
          url: 'users/contracts',
          body: {
            'type': selectDate == 'Yearly' ? 'annual' : 'monthly',
            'start_date':
                '${DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())}',
            'end_date':
                '${DateFormat('yyyy-MM-dd', 'en').format(DateTime.parse('2025-01-12'))}',
          },
        )
        .then((value) {
          print(value.body);
          if (value.statusCode == 200) {
            createLoading = false;
            emit(ContractSuccess());
          } else {
            createLoading = false;
            emit(ContractError());
          }
        })
        .catchError((e) {
          createLoading = false;
          emit(ContractErrorConnect());
        });
  }

  TextEditingController emailForgetCtrl = TextEditingController();
  bool forgetPasswordLoading = false;
  forgetPassword() {
    forgetPasswordLoading = true;
    emit(ForgetPasswordLoading());
    HttpHelper.postMultiData(
          url: 'Auth/forgot-password',
          body: {"email": "${emailForgetCtrl.text}"},
        )
        .then((value) async {
          print(value.statusCode);
          if (value.statusCode == 200 || value.statusCode == 201) {
            forgetPasswordLoading = false;
            emit(ForgetPasswordSuccess());
          } else {
            forgetPasswordLoading = false;
            emit(ForgetPasswordError());
          }
        })
        .catchError((e) {
          forgetPasswordLoading = false;
          emit(ForgetPasswordErrorConnect());
        });
  }

  List<TextEditingController> updatePasswordCtrls = [
    TextEditingController(),
    TextEditingController(),
  ];
  bool updatePasswordLoading = false;
  updatePassword() {
    updatePasswordLoading = true;
    emit(UpdatePasswordLoading());
    HttpHelper.postMultiData(
          url: 'Auth/reset-password',
          body: {
            "token": "${updatePasswordCtrls[0].text}",
            "email": "${emailForgetCtrl.text}",
            "newPassword": "${updatePasswordCtrls[1].text}",
          },
        )
        .then((value) {
          if (value.statusCode == 200 || value.statusCode == 201) {
            updatePasswordLoading = false;
            emit(UpdatePasswordSuccess());
          } else {
            updatePasswordLoading = false;
            emit(UpdatePasswordError());
          }
        })
        .catchError((e) {
          updatePasswordLoading = false;
          emit(UpdatePasswordErrorConnect());
        });
  }

  bool isEnableForgetEmail = false;
  bool isErrorForgetEmail = false;
  enableForgetEmailValue(String value) {
    if (value.isNotEmpty) {
      String emailSource = r'^[a-zA-Z0-9._%]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$';
      RegExp regExp = RegExp(emailSource);
      if (regExp.hasMatch(value)) {
        isEnableForgetEmail = true;
        isErrorForgetEmail = false;
        emit(EnableButton());
        // update();
      } else {
        isEnableForgetEmail = false;
        isErrorForgetEmail = true;
        emit(EnableButton());
        // update();
      }
    } else {
      //
      isEnableForgetEmail = false;
      isErrorForgetEmail = false;
      emit(EnableButton());
      // update();
    }
  }
}
