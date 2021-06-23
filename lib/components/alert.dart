import 'package:ecommerceproject/screens/authentication/components/button.dart';
import 'package:flutter/material.dart';

void alert(context, String message, {buttonText = 'Close'}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
          Center(child: Text(message)),
          SizedBox(height: 20),
          Button(
            buttonText: buttonText,
            onClick: () {
              Navigator.pop(context);
            },
          )
        ]));
      });
}
