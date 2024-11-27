import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyFun{
  void CustToastMassage(String s) {
    Fluttertoast.showToast(
        msg: '$s',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }



}