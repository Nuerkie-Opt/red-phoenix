import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:ecommerceproject/screens/authentication/components/button.dart';
import 'package:ecommerceproject/services/auth.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password?",
            style: Theme.of(context).primaryTextTheme.headline3,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "An email containing a link will be sent to your email address. Please use the link to reset your password",
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                ),
                SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email Address"),
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Please enter your email address";

                    return null;
                  },
                ),
                SizedBox(height: 30),
                Button(
                    buttonText: "Submit",
                    onClick: () async {
                      if (_formKey.currentState!.validate()) {
                        await _auth.resetPassword(
                            emailController.text, context);
                        showTopSnackBar(
                            context,
                            CustomSnackBar.success(
                                message:
                                    "Success. An link has been sent to your email address"));
                        Navigator.pop(context);
                      }
                    })
              ],
            ),
          ),
        )));
  }
}
