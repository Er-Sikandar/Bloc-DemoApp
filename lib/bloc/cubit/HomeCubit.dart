import 'package:bloc_demo/models/TestListModel.dart';

import '../../networks/ApiInitial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeCubit extends Cubit<ApiState>{
  HomeCubit():super(ApiInitial());

  Future<void> fetchData() async {
    emit(ApiLoading());
    try {
      final response = await http.get(Uri.parse('https://api.restful-api.dev/objects'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<TestListModel> products = data.map((json) => TestListModel.fromJson(json)).toList();
        emit(ApiSuccess(products));
      } else {
        emit(ApiError('Failed to load data. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ApiError('Error occurred: $e'));
    }
  }


}