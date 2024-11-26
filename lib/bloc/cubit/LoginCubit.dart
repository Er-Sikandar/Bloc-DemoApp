import 'package:flutter_bloc/flutter_bloc.dart';
import '../../networks/ApiInitial.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginCubit extends Cubit<ApiState>{
  LoginCubit() : super(ApiInitial());

  Future<void> fetchData() async {
    emit(ApiLoading());
    try {
      final response = await http.get(Uri.parse('https://api.restful-api.dev/objects/7'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(ApiSuccess(data.toString())); // You can adjust the data processing here
      } else {
        emit(ApiError('Failed to load data. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ApiError('Error occurred: $e'));
    }


  }
}