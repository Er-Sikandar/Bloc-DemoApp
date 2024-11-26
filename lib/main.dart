import 'package:bloc_demo/bloc/cubit/SplashCubit%20.dart';
import 'package:bloc_demo/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/observer/AppBlocObserver.dart';
import 'bloc/observer/MultiAppBlocObserver.dart';
import 'bloc/cubit/ThemeCubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
/*
 Bloc.observer = const AppBlocObserver(); //for single
*/
  Bloc.observer = MultiAppBlocObserver([
    AppBlocObserver(),
  ]);

  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
            BlocProvider(create: (_) => SplashCubit()),
          ],
    child:BlocBuilder<ThemeCubit,ThemeData>(builder: (context,theme){
     return MaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'Bloc Demo',
         theme: theme,
         home: const Splashscreen(),
      );
    })
  ));
}

