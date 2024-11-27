import 'package:bloc_demo/bloc/cubit/SplashCubit%20.dart';
import 'package:bloc_demo/ui/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cubit/HomeCubit.dart';
import 'bloc/cubit/LoginCubit.dart';
import 'bloc/observer/AppBlocObserver.dart';
import 'bloc/observer/MultiAppBlocObserver.dart';
import 'bloc/cubit/ThemeCubit.dart';
import 'utils/Const.dart';
import 'ui/LoginScreen.dart';
import 'ui/SplashScreen.dart';
import 'utils/Prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
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
            BlocProvider(create: (_) => LoginCubit()),
            BlocProvider(create: (_) => HomeCubit()),
          ],
    child:BlocBuilder<ThemeCubit,ThemeData>(builder: (context,theme){
     return MaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'Bloc Demo App',
         theme: theme,
         initialRoute: SPLASH_SCREEN,
       routes: {
         SPLASH_SCREEN: (context) => const Splashscreen(),
         LOGIN_SCREEN: (context) => const Loginscreen(),
         HOME_SCREEN: (context) => const HomeScreen(),
       },
      );
    })
  ));
}

