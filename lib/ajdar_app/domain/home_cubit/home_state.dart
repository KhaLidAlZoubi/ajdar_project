abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeSelectPageState extends HomeState {}

class HomeSelectTabState extends HomeState {}

class SwitchThemeHomeState extends HomeState {}

// category
class CategoryLoadingState extends HomeState {}

class CategorySuccessState extends HomeState {}

class CategoryNoDataState extends HomeState {}

class CategoryErrorState extends HomeState {}

class CategoryErrorConnectState extends HomeState {}

// services
class ServicesLoadingState extends HomeState {}

class ServicesSuccessState extends HomeState {}

class ServicesNoDataState extends HomeState {}

class ServicesErrorState extends HomeState {}

class ServicesErrorConnectState extends HomeState {}

// profile
class ProfileLoadingState extends HomeState {}

class ProfileSuccessState extends HomeState {}

class ProfileErrorState extends HomeState {
  Map<String, dynamic> error;
  ProfileErrorState({required this.error});
}

class ProfileErrorConnectState extends HomeState {
  String error;
  ProfileErrorConnectState({required this.error});
}

// logout
class LogoutLoadingState extends HomeState {}

class LogoutSuccessState extends HomeState {}

class LogoutErrorState extends HomeState {}

class LogoutErrorConnectState extends HomeState {
  final String error;
  LogoutErrorConnectState({required this.error});
}

// sections
class SectionLoading extends HomeState {}

class SectionSuccess extends HomeState {}

class SectionNoData extends HomeState {}

class SectionError extends HomeState {}

class SectionErrorConnect extends HomeState {}

class AdsLoadingState extends HomeState {}

class AdsSuccessState extends HomeState {}

class AdsErrorState extends HomeState {}

class AdsErrorConnectState extends HomeState {
  final String error;
  AdsErrorConnectState({required this.error});
}

class SelectArea extends HomeState {}

class SelectSubSection extends HomeState {}

class NextPageAds extends HomeState {}

class DynamicFieldLoading extends HomeState {}

class DynamicFieldSuccess extends HomeState {}

class DynamicFieldNoData extends HomeState {}

class DynamicFieldError extends HomeState {}

class DynamicFieldErrorConnect extends HomeState {}

class AddAdsLoading extends HomeState {}

class AddAdsSuccess extends HomeState {
  final String message;
  AddAdsSuccess(this.message);
}

class AddAdsError extends HomeState {
  final String error;
  AddAdsError(this.error);
}

class AddAdsErrorConnect extends HomeState {}

class DynamicFieldsUpdated extends HomeState {}

class MeLoading extends HomeState {}

class MeSuccess extends HomeState {}

class MeError extends HomeState {}

class MeErrorConnect extends HomeState {}

class AddToWishList extends HomeState {}

class CheckLoading extends HomeState {}

class CheckSuccess extends HomeState {}

class CheckError extends HomeState {}

class CheckErrorConnect extends HomeState {}

class ActionWishlistLoading extends HomeState {}

class ActionWishlistError extends HomeState {}

class ActionWishlistSuccess extends HomeState {}

class ActionWishlistErrorConnect extends HomeState {}

class RemoveWishlistLoading extends HomeState {}

class RemoveWishlistError extends HomeState {}

class RemoveWishlistSuccess extends HomeState {}

class RemoveWishlistErrorConnect extends HomeState {}

class WishlistLoading extends HomeState {}

class WishlistError extends HomeState {}

class WishlistSuccess extends HomeState {}

class WishlistErrorConnect extends HomeState {}

class WishlistNoData extends HomeState {}

class IsAuthLoading extends HomeState {}

class IsAuthError extends HomeState {}

class IsAuthErrorConnect extends HomeState {}

class IsAuthSuccess extends HomeState {}

class SelectIndex extends HomeState {}

class DeleteWishlistLoading extends HomeState {}

class DeleteWishlistError extends HomeState {}

class DeleteWishlistSuccess extends HomeState {}

class DeleteWishlistErrorConnect extends HomeState {}

class HomeStateUpdated extends HomeState {}

class DynamicFieldsValidation extends HomeState {}

class UploadProgressState extends HomeState {
  double progress;
  UploadProgressState({required this.progress});
}

class SliderLoading extends HomeState {}

class SliderSuccess extends HomeState {}

class SliderNoData extends HomeState {}

class SliderError extends HomeState {}

class SliderErrorCConnect extends HomeState {}

class DeleteLoading extends HomeState {}

class DeleteSuccess extends HomeState {}

class DeleteError extends HomeState {}

class DeleteErrorConnect extends HomeState {}

class UpdateUserLoading extends HomeState {}

class UpdateUserSuccess extends HomeState {}

class UpdateUserError extends HomeState {}

class UpdateUserErrorConnect extends HomeState {}

class UpdatePhoneLoading extends HomeState {}

class UpdatePhoneSuccess extends HomeState {}

class UpdatePhoneError extends HomeState {}

class UpdatePhoneErrorConnect extends HomeState {}
