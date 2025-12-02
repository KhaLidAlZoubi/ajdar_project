class UserUrl {
  String _loginURL = 'Auth/login-flutter';
  String _registerURL = 'Auth/register';

  String _verifyURL = 'Auth/verify-otp';
  String _recentURL = 'Auth/resend-otp';
  String _logoutURL = 'auth/logout';

  String get loginURL => _loginURL;
  String get registerURL => _registerURL;
  String get verifyURL => _verifyURL;
  String get recentURL => _recentURL;
  String get logoutURL => _logoutURL;
}
