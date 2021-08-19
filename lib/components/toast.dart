import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showToastMessage(message) {
  Fluttertoast.showToast(
    msg: message ?? '',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    backgroundColor: Color(0xFF484848),
    textColor: Colors.white,
    fontSize: 9,
  );
}
