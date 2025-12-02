// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ajdar`
  String get app {
    return Intl.message(
      'Ajdar',
      name: 'app',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get loginTile {
    return Intl.message(
      'Sign In',
      name: 'loginTile',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get loginDescription {
    return Intl.message(
      '',
      name: 'loginDescription',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get createAccount {
    return Intl.message(
      'Sign Up',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get name {
    return Intl.message(
      'Full Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `First name, Last Name`
  String get nameHint {
    return Intl.message(
      'First name, Last Name',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `Do you already have an account?`
  String get account {
    return Intl.message(
      'Do you already have an account?',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Please enter please Name`
  String get nameValidate {
    return Intl.message(
      'Please enter please Name',
      name: 'nameValidate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a Saudi phone number`
  String get phoneValidate {
    return Intl.message(
      'Please enter a Saudi phone number',
      name: 'phoneValidate',
      desc: '',
      args: [],
    );
  }

  /// `Account confirmation`
  String get otpTitle {
    return Intl.message(
      'Account confirmation',
      name: 'otpTitle',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a text message containing the confirmation code to`
  String get otpDescription {
    return Intl.message(
      'We have sent a text message containing the confirmation code to',
      name: 'otpDescription',
      desc: '',
      args: [],
    );
  }

  /// `Resend the code in`
  String get recentCode {
    return Intl.message(
      'Resend the code in',
      name: 'recentCode',
      desc: '',
      args: [],
    );
  }

  /// `The confirmation code is no longer valid`
  String get codeValid {
    return Intl.message(
      'The confirmation code is no longer valid',
      name: 'codeValid',
      desc: '',
      args: [],
    );
  }

  /// `Recent Code`
  String get recent {
    return Intl.message(
      'Recent Code',
      name: 'recent',
      desc: '',
      args: [],
    );
  }

  /// `ID number`
  String get idNumber {
    return Intl.message(
      'ID number',
      name: 'idNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter ID Number`
  String get idHint {
    return Intl.message(
      'Enter ID Number',
      name: 'idHint',
      desc: '',
      args: [],
    );
  }

  /// `House Number`
  String get houseNumber {
    return Intl.message(
      'House Number',
      name: 'houseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter House Number`
  String get houseHint {
    return Intl.message(
      'Enter House Number',
      name: 'houseHint',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Complete Account Details`
  String get completeAccount {
    return Intl.message(
      'Complete Account Details',
      name: 'completeAccount',
      desc: '',
      args: [],
    );
  }

  /// `Your personal information is safe`
  String get safe {
    return Intl.message(
      'Your personal information is safe',
      name: 'safe',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Choose Photo`
  String get choosePhoto {
    return Intl.message(
      'Choose Photo',
      name: 'choosePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a photo for your profile`
  String get choosePhotoDescription {
    return Intl.message(
      'Please choose a photo for your profile',
      name: 'choosePhotoDescription',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get yourLocation {
    return Intl.message(
      'Your Location',
      name: 'yourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Kingdom of Saudi Arabia`
  String get country {
    return Intl.message(
      'Kingdom of Saudi Arabia',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get address {
    return Intl.message(
      'Your Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Neighborhood`
  String get neighborhood {
    return Intl.message(
      'Neighborhood',
      name: 'neighborhood',
      desc: '',
      args: [],
    );
  }

  /// `Enter neighborhood name`
  String get neighborhoodHint {
    return Intl.message(
      'Enter neighborhood name',
      name: 'neighborhoodHint',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Enter street name`
  String get streetHint {
    return Intl.message(
      'Enter street name',
      name: 'streetHint',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get wallet {
    return Intl.message(
      'My Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `You have`
  String get have {
    return Intl.message(
      'You have',
      name: 'have',
      desc: '',
      args: [],
    );
  }

  /// `in your wallet`
  String get wallerDescription {
    return Intl.message(
      'in your wallet',
      name: 'wallerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get requestMore {
    return Intl.message(
      'Request',
      name: 'requestMore',
      desc: '',
      args: [],
    );
  }

  /// `Search for service`
  String get searchService {
    return Intl.message(
      'Search for service',
      name: 'searchService',
      desc: '',
      args: [],
    );
  }

  /// `Bundle`
  String get bundle {
    return Intl.message(
      'Bundle',
      name: 'bundle',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offer {
    return Intl.message(
      'Offers',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `Your contract nears expiration`
  String get nearsExpiration {
    return Intl.message(
      'Your contract nears expiration',
      name: 'nearsExpiration',
      desc: '',
      args: [],
    );
  }

  /// `Your contract ends on`
  String get contractEnds {
    return Intl.message(
      'Your contract ends on',
      name: 'contractEnds',
      desc: '',
      args: [],
    );
  }

  /// `Renewal`
  String get renewal {
    return Intl.message(
      'Renewal',
      name: 'renewal',
      desc: '',
      args: [],
    );
  }

  /// `Next Visit`
  String get nextVisit {
    return Intl.message(
      'Next Visit',
      name: 'nextVisit',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated Supervisors`
  String get supervisors {
    return Intl.message(
      'Top Rated Supervisors',
      name: 'supervisors',
      desc: '',
      args: [],
    );
  }

  /// `Services you will like`
  String get serviceLike {
    return Intl.message(
      'Services you will like',
      name: 'serviceLike',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `My Bundles`
  String get myBundles {
    return Intl.message(
      'My Bundles',
      name: 'myBundles',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get me {
    return Intl.message(
      'Me',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `The Visit`
  String get visit {
    return Intl.message(
      'The Visit',
      name: 'visit',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get form {
    return Intl.message(
      'From',
      name: 'form',
      desc: '',
      args: [],
    );
  }

  /// `Until`
  String get until {
    return Intl.message(
      'Until',
      name: 'until',
      desc: '',
      args: [],
    );
  }

  /// `Morning`
  String get morning {
    return Intl.message(
      'Morning',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `Evening`
  String get evening {
    return Intl.message(
      'Evening',
      name: 'evening',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get rating {
    return Intl.message(
      'Reviews',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Bundles`
  String get bundles {
    return Intl.message(
      'Bundles',
      name: 'bundles',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get curren {
    return Intl.message(
      'Current',
      name: 'curren',
      desc: '',
      args: [],
    );
  }

  /// `Create Bundle`
  String get createBundle {
    return Intl.message(
      'Create Bundle',
      name: 'createBundle',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get profile {
    return Intl.message(
      'My Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal {
    return Intl.message(
      'Personal Information',
      name: 'personal',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change {
    return Intl.message(
      'Change Password',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark {
    return Intl.message(
      'Dark Mode',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `The Language`
  String get language {
    return Intl.message(
      'The Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Contact Customer Service`
  String get contact {
    return Intl.message(
      'Contact Customer Service',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy and Terms of Use`
  String get privacy {
    return Intl.message(
      'Privacy Policy and Terms of Use',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Change Application Language`
  String get changeLang {
    return Intl.message(
      'Change Application Language',
      name: 'changeLang',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Create New Bundle`
  String get createNewBundle {
    return Intl.message(
      'Create New Bundle',
      name: 'createNewBundle',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
