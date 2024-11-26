import 'package:bloc_demo/ui/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/SplashCubit .dart';
import '../bloc/cubit/ThemeCubit.dart';
import '../utils/Const.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    context.read<SplashCubit>().startSplash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, bool>(
        listener: (context, state) {
      if (state) {
        Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
      }
    },
    child: Scaffold(
      body: Center(
        child: Image.asset('assets/images/coins.png',
          width: 180,height: 180,),
      ),
    ),
    );
  }
}
