import 'package:bloc_demo/utils/Const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../networks/ApiInitial.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/Prefs.dart';

class LoggedOut extends ApiState {}

class LoginCubit extends Cubit<ApiState>{
  final TextEditingController mobCtrl = TextEditingController();
  final TextEditingController pwsCtrl = TextEditingController();
  bool _isPasswordVisible = false;

  LoginCubit() : super(ApiInitial());

  bool get isPasswordVisible => _isPasswordVisible;
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(ApiInitial());
  }

  Future<void> fetchData() async {
    emit(ApiLoading());
    try {
      final response = await http.get(Uri.parse('https://api.restful-api.dev/objects/7'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Prefs.setPrefStr(ID, data[ID] ?? "");
        Prefs.setPrefStr(NAME, data[NAME] ?? "");
        Prefs.setPrefBl(IS_LOGIN, true);
        mobCtrl.text=EMPTY;
        pwsCtrl.text=EMPTY;
        emit(ApiSuccess(data.toString()));
      } else {
        emit(ApiError('Failed to load data. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ApiError('Error occurred: $e'));
    }
  }

  @override
  Future<void> close() {
    // Dispose the controller to prevent memory leaks
    mobCtrl.dispose();
    pwsCtrl.dispose();
    return super.close();
  }

  void logout() {
    emit(LoggedOut());
  }

}