import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData>{
  ThemeCubit() : super(_lightTheme);
  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Sanspro',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
    ),
   /* appBarTheme: AppBarTheme(
      backgroundColor: Colors.red,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red,
    ),*/
  );
  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Sanspro',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18),
      bodyMedium: TextStyle(fontSize: 16),
      bodySmall: TextStyle(fontSize: 14),
    ),
    /*appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green,
    ),*/
  );
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }

}