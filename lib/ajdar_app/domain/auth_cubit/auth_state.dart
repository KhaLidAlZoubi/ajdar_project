import 'package:http/http.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

// login states
class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  AuthLoginSuccessState({required this.loginData});
  Map<String, dynamic> loginData;
}

class AuthLoginErrorConnectState extends AuthState {
  AuthLoginErrorConnectState({required this.loginConnectErrorData});
  Map<String, dynamic> loginConnectErrorData;
}

class AuthLoginErrorState extends AuthState {
  final String error;
  AuthLoginErrorState({required this.error});
}

class AuthLoginPhoneValueState extends AuthState {}
// register state

class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {
  AuthRegisterSuccessState({required this.registerData});
  Map<String, dynamic> registerData;
}

class AuthRegisterErrorConnectState extends AuthState {
  AuthRegisterErrorConnectState({required this.registerConnectErrorData});
  Map<String, dynamic> registerConnectErrorData;
}

class AuthRegisterAccountFoundConnectState extends AuthState {
  AuthRegisterAccountFoundConnectState({required this.registerConnectData});
  Map<String, dynamic> registerConnectData;
}

class AuthRegisterErrorState extends AuthState {
  AuthRegisterErrorState({required this.error});
  final String error;
}

class AuthRegisterNameValueState extends AuthState {}

class AuthRegisterEmailValueState extends AuthState {}

class AuthRegisterPhoneValueState extends AuthState {}

// verify
class AuthVerifyLoadingState extends AuthState {}

class AuthVerifySuccessState extends AuthState {
  AuthVerifySuccessState({required this.verifyData});
  Map<String, dynamic> verifyData;
}

class AuthVerifyErrorConnectState extends AuthState {
  AuthVerifyErrorConnectState({required this.verifyConnectErrorData});
  Map<String, dynamic> verifyConnectErrorData;
}

class AuthVerifyErrorState extends AuthState {
  AuthVerifyErrorState({required this.error});
  final String error;
}

class AuthVerifyValidateState extends AuthState {}

class AuthVerifyStartTimeState extends AuthState {}

class AuthVerifyEndTimeState extends AuthState {}

class AuthRecentSuccessState extends AuthState {
  Map<String, dynamic> recentData;
  AuthRecentSuccessState({required this.recentData});
}

class AuthRecentLoadingState extends AuthState {}

class AuthRecentErrorConnectState extends AuthState {
  Map<String, dynamic> errorData;
  AuthRecentErrorConnectState({required this.errorData});
}

class AuthRecentErrorState extends AuthState {
  String error;
  AuthRecentErrorState({required this.error});
}

// get location
class LocationDisableState extends AuthState {}

class LocationEnableState extends AuthState {}

class LocationLoadingState extends AuthState {}

class LocationSuccessState extends AuthState {}

// address
class AddressLoadingState extends AuthState {}

class AddressSuccessState extends AuthState {}

class AddressErrorState extends AuthState {}

// chose photo
class ChosePhotoSuccess extends AuthState {}

// complete info
class CompleteValidateState extends AuthState {}

class CompleteNoPhotoState extends AuthState {}

class CompleteLoadingState extends AuthState {}

class CompleteSuccessState extends AuthState {}

class CompleteErrorState extends AuthState {
  String error;
  CompleteErrorState({required this.error});
}

class CompleteErrorConnectState extends AuthState {
  String error;
  CompleteErrorConnectState({required this.error});
}

class EnableButton extends AuthState {}

class DisableButton extends AuthState {}

class ProfileLoadingState extends AuthState {}

class ProfileSuccessState extends AuthState {}

class ProfileErrorState extends AuthState {
  Map<String, dynamic> error;
  ProfileErrorState({required this.error});
}

class ProfileErrorConnectState extends AuthState {
  String error;
  ProfileErrorConnectState({required this.error});
}

class ContractLoading extends AuthState {}

class ContractSuccess extends AuthState {}

class ContractError extends AuthState {}

class ContractErrorConnect extends AuthState {}

class SelectImageSuccess extends AuthState {}

// class EnableButton extends AuthState{}
class HiddenPassword extends AuthState {}

class ValidationImage extends AuthState {}

class ForgetPasswordSuccess extends AuthState {}

class ForgetPasswordError extends AuthState {}

class ForgetPasswordErrorConnect extends AuthState {}

class UpdatePasswordLoading extends AuthState {}

class UpdatePasswordSuccess extends AuthState {}

class UpdatePasswordError extends AuthState {}

class UpdatePasswordErrorConnect extends AuthState {}

class ForgetPasswordLoading extends AuthState {}

class OtpAccount extends AuthState {}
