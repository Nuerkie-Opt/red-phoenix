import 'package:flutter/material.dart';

Widget textInput(
    TextEditingController controller, String hint, IconData icon, bool validate) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        errorText: validate ? null : 'Field must not be empty',
        prefixIcon: Icon(icon),
      ),
    ),
  );
}

Widget passwordInput(
    TextEditingController controller, String hint, IconData icon, bool validate) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        errorText: validate ? null : 'Field must not be empty',
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}
