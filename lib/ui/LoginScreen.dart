import 'package:bloc_demo/bloc/cubit/LoginCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit/ThemeCubit.dart';
import '../networks/ApiInitial.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  @override
  void initState() {
    print("Login Splash");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<LoginCubit, ApiState>(
        builder: (context, state) {
          if (state is ApiLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ApiSuccess) {
            return Center(child: Text('Data: ${state.data}'));
          } else if (state is ApiError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().fetchData(); // Trigger API call
                },
                child: Text('Fetch Data'),
              ),
            );
          }
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          SizedBox(height: 2,),
          Text("Theme",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold))
        ],
      ),
    );

  }

}
