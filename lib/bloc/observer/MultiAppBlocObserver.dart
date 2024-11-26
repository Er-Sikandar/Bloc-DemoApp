import 'package:flutter_bloc/flutter_bloc.dart';

class MultiAppBlocObserver extends BlocObserver{
/*
const AppBlocObserver(); //for single
*/
  /**
   * For Multiple
   */
  final List<BlocObserver> observers;
  MultiAppBlocObserver(this.observers);
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    for (var observer in observers) {
      observer.onChange(bloc, change);
      if (bloc is Cubit) print("Multi Change: $change");
    }
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition,) {
    super.onTransition(bloc, transition);
    for (var observer in observers) {
      observer.onTransition(bloc, transition);
      print("Multi Transition: $transition");
    }
  }
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    for (var observer in observers) {
      observer.onError(bloc, error,stackTrace);
      print("ulti Bloc Error: $error");
    }

  }
}