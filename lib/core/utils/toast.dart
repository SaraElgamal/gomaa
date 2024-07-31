import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning ,white }

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.redAccent;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.white:
      color = Colors.blueGrey;
      break;
  }
  return color;
}
