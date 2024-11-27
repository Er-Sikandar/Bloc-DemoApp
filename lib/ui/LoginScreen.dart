import 'package:bloc_demo/bloc/cubit/LoginCubit.dart';
import 'package:bloc_demo/ui/HomeScreen.dart';
import 'package:bloc_demo/utils/Const.dart';
import 'package:bloc_demo/utils/MyFun.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final loginCubit = context.read<LoginCubit>();

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LoginCubit, ApiState>(
          builder: (context, state) {
            if (state is ApiLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ApiSuccess) {
              Future.microtask(() => Navigator.pushReplacementNamed(context, HOME_SCREEN));
              return SizedBox.shrink();
            } else if (state is ApiError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          autofocus: true,
                          enabled: true,
                          controller: loginCubit.mobCtrl,
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),

                            prefixStyle: Theme.of(context).textTheme.bodyMedium,
                            prefixIcon: Icon(Icons.call),
                            hintText: 'Enter Phone Number',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      SizedBox(height: h*0.001,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          autofocus: true,
                          enabled: true,
                          obscureText: !loginCubit.isPasswordVisible,
                          controller: loginCubit.pwsCtrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            prefixStyle: Theme.of(context).textTheme.bodyMedium,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(icon: Icon(loginCubit.isPasswordVisible ? Icons.visibility : Icons.visibility_off,),
                              onPressed: () {
                                setState(() {
                                  loginCubit.togglePasswordVisibility();
                                });
                              },),
                            hintText: 'Enter Password',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                     SizedBox(height: h*0.05,),
                      ElevatedButton(
                        onPressed: () {
                          if(loginCubit.mobCtrl.text.isEmpty){
                            MyFun().CustToastMassage('Please Enter Phone Number');
                          }else if(loginCubit.pwsCtrl.text.isEmpty){
                            MyFun().CustToastMassage('Please Enter Password');
                          }else {
                            loginCubit.fetchData();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child:  state is ApiLoading? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ) : Text('Login'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
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
