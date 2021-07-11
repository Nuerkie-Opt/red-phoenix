import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final buttonText;
  final onClick;
  const Button({Key? key, @required this.buttonText, @required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: Size.fromHeight(50),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ));

    return Center(
      child: ElevatedButton(
        style: style,
        onPressed: onClick,
        child: Text(buttonText),
      ),
    );
  }
}
