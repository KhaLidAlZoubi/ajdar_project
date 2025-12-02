// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleAuthService {
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//   bool _initialized = false;

//   GoogleAuthService() {
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     await _googleSignIn.initialize();
//     _initialized = true;
//   }

//   Future<void> signInWithGoogle() async {
//     if (!_initialized) {
//       await _initialize();
//     }

//     try {
//       // محاولة تسجيل دخول بصمت أولاً
//       var googleUser = await _googleSignIn.attemptLightweightAuthentication();

//       // إذا فشل (مدى الصمت ما فيه نتيجة) نجرّب authenticate
//       googleUser ??= await _googleSignIn.authenticate();

//       if (googleUser == null) {
//         print("المستخدم ألغى تسجيل الدخول");
//         return;
//       }

//       // الآن البيانات الآتية بضمان السلامة
//       // final idToken = googleUser.idToken;
//       // ملاحظة: الـ accessToken لا يعود متوفّر أو طريقة استرجاعه تغيّرت
//       // print("تم تسجيل الدخول: ${googleUser.displayName}, idToken: $idToken");
//       // بإمكانك إرسال البيانات لـ API خاصّتك...
//     } catch (e) {
//       print("خطأ أثناء تسجيل الدخول: $e");
//     }
//   }

//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//   }
// }

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSign {
  static final _googleSignIn = GoogleSignIn.instance;
  // static Future<GoogleSignInAccount?> login() => _googleSignIn.signOut();
}
