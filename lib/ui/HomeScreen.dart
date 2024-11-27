import 'package:bloc_demo/bloc/cubit/HomeCubit.dart';
import 'package:bloc_demo/bloc/cubit/LoginCubit.dart';
import 'package:bloc_demo/models/TestListModel.dart';
import 'package:bloc_demo/utils/Const.dart';
import 'package:bloc_demo/utils/Prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../networks/ApiInitial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    context.read<HomeCubit>().fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, ApiState>(
          builder: (context, state) {
            if (state is ApiLoading) {
      return Center(child: CircularProgressIndicator());
            } else if (state is ApiSuccess) {
              if (state.data is List<TestListModel>) {
                List<TestListModel> productsList = state.data;
                return ListView.builder(
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    final product = productsList[index];
                    return Card(
                      margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                      child: ListTile(
                        title: Text('Id: ${product.id}'),
                        subtitle: Text('Name: ${product.name}'),
                      ),
                    );
                  },
                );
              }else{
                return Center(child: Text('No Data Found'));
              }
            } else if (state is ApiError) {
      return Center(child: Text('Error: ${state.message}'));
            } else {
      return Center(child: Text('Something went wrong'));
            }
          }
            ),
      bottomNavigationBar:Container(
        height: 80,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child:  Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Prefs.deleteAllData();
                context.read<LoginCubit>().logout();
                Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
              },
              child: Text('Clear Data'),
            ),
            SizedBox(
              height: h*.002,
            ),
            Text('Name: ${Prefs.getPrefStr(NAME)}'),
          ],
        ),
      ),
    );
  }
}
