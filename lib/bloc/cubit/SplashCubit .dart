import 'package:bloc_demo/utils/Const.dart';
import 'package:bloc_demo/utils/Prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit():super(false);

  void startSplash() {
    Future.delayed(const Duration(seconds: 5), () {
      print('Is Login: ${Prefs.getPrefBl(IS_LOGIN)}');
      if(Prefs.getPrefBl(IS_LOGIN)){
        emit(true);
      }else{
        emit(false);
      }
    });
  }

}