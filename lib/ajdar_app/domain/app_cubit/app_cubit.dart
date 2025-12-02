import 'package:ajder_project/ajdar_app/domain/app_cubit/app_state.dart';
import 'package:ajder_project/conest.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  String _key = 'isDark';
  bool isLight = box.read('isDark') ?? false;
  void sw(bool value) {
    isLight = !value;
    emit(state);
  }

  _saveData(bool isDark) => box.write(_key, isDark);
  bool get readThemeFromBox => box.read(_key) ?? false;
  ThemeMode get theme => readThemeFromBox ? ThemeMode.dark : ThemeMode.light;
  IconData get icon => readThemeFromBox ? Icons.dark_mode : Icons.light_mode;
  void switchTheme(bool value) {
    isLight = value;
    _saveData(value);
    emit(AppChangeThemeState());
  }

  String _langKey = 'lang';

  _saveLocalData(String value) => box.write(_langKey, value);
  String get lang => box.read(_langKey) ?? 'ar';
  // String get lang => option ?? 'tr';

  void saveLang() {
    // lang;
    _saveLocalData(option!);
    emit(AppChangeLangState());
  }

  String? option;
  void selectOption(String? value) {
    option = value;
    emit(AppChangeOptionState());
  }
}
