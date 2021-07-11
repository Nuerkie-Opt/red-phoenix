import 'package:ecommerceproject/screens/authentication/components/button.dart';
import 'package:ecommerceproject/screens/authentication/components/header.dart';
import 'package:ecommerceproject/screens/authentication/screens/sign_up.dart';
import 'package:ecommerceproject/screens/authentication/components/textFields.dart';
import 'package:ecommerceproject/screens/dashboard/dashboard.dart';
import 'package:ecommerceproject/services/auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  List<TextEditingController> controllers =
      List<TextEditingController>.generate(2, (index) => TextEditingController());
  bool isValidated = false;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Header(
                text: 'Login',
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  children: [
                    textInput(controllers[0], "Email", Icons.email, isValidated),
                    passwordInput(controllers[1], "Password", Icons.vpn_key, isValidated),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 60),
                      child: Button(
                        onClick: () async {
                          if (controllers[0].text.isNotEmpty &&
                              controllers[1].text.isNotEmpty) {
                            setState(() {
                              isValidated = true;
                            });
                          }
                          if (isValidated) {
                            dynamic result = await _auth.logIn(
                                controllers[0].text, controllers[1].text, context);
                            if (result == null) {
                              print('login failed');
                            } else {
                              print('logged in');

                              print(result);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Dashboard()));
                            }
                          }
                        },
                        buttonText: "Login",
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Don't have an account ? ",
                          style: TextStyle(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text("Sign Up",
                            style: TextStyle(color: Theme.of(context).primaryColor)),
                      ),
                    ])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
