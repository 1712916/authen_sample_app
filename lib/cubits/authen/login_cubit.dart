import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data.dart';
import '../../resources/resources.dart';
import '../../routers/route.dart';
import '../cubits.dart';

class LoginCubit extends Cubit <LoginState>{
  LoginCubit() : super(LoginState());

  final AuthenReposity authenReposity = AuthenReposity();

  void resetLoginMessage() {
    emit(state.copyWith(loginMessage: ''));
  }

  void resetRegisterMessage() {
    emit(state.copyWith(registerMessage: ''));
  }

  Future onLogin({required String email, required String password}) async {
    final response = await authenReposity.login(email: email, password: password);
    if (response.statusCode == StatusCode.success) {
      final shareRef = await SharedPreferences.getInstance();
      if (await shareRef.setString(SharedPreferencesKey.profileModel, jsonEncode(response.data!.toJson()))) {
        //handle when saved
      } else  {
        //handle when save failure
      }
      return NavigateEvent(routeName: RouteManager.home, arguments: response.data);
    } else if (response.statusCode == StatusCode.unauthorized) {
      emit(state.copyWith(loginMessage: response.message ?? LocaleKeys.defaultError.tr()));
    }
    return null;
  }

  Future onRegister({required String email, required String password, required String userName}) async {
    final response = await authenReposity.register(email: email, password: password, userName: userName);
    if (response.statusCode == StatusCode.success) {
      return NavigateEvent(routeName: RouteManager.home, arguments: response.data);
    } else if (response.statusCode == StatusCode.unauthorized) {
      emit(state.copyWith(registerMessage: response.message ?? LocaleKeys.defaultError.tr()));
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.forceInput.tr();
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.forceInput.tr();
    }
    return null;
  }

  String? emailRegisterValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.forceInput.tr();
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return LocaleKeys.invalidEmail.tr();
    }
    return null;
  }

  String? passwordRegisterValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.forceInput.tr();
    } else if (!RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(value)) {
      return LocaleKeys.invalidPassword.tr();
    }
    return null;
  }

  String? userNameRegisterValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.forceInput.tr();
    }
    return null;
  }
}
