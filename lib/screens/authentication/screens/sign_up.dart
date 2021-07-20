import 'package:ecommerceproject/components/loading.dart';
import 'package:ecommerceproject/models/userInfo.dart';
import 'package:ecommerceproject/screens/authentication/components/button.dart';
import 'package:ecommerceproject/screens/authentication/components/header.dart';
import 'package:ecommerceproject/screens/authentication/components/textFields.dart';
import 'package:ecommerceproject/services/auth.dart';
import 'package:ecommerceproject/screens/dashboard/dashboard.dart';
import 'package:ecommerceproject/utils/globalData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<TextEditingController> controllers = List<TextEditingController>.generate(4, (index) => TextEditingController());
  bool isValidated = false;
  AuthService _auth = AuthService();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Header(
                text: 'Sign Up',
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    textInput(controllers[0], "Name", Icons.person, isValidated),
                    textInput(controllers[1], "Email", Icons.person, isValidated),
                    passwordInput(controllers[2], "Password", Icons.person, isValidated),
                    passwordInput(controllers[3], "Confirm password", Icons.person, isValidated),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Button(
                        buttonText: "Sign Up",
                        onClick: () async {
                          if (controllers[0].text.isNotEmpty &&
                              controllers[1].text.isNotEmpty &&
                              controllers[2].text.isNotEmpty &&
                              controllers[3].text.isNotEmpty &&
                              controllers[2].text == controllers[3].text) {
                            setState(() {
                              isValidated = true;
                            });
                          }
                          loader(context);
                          if (isValidated) {
                            dynamic result = await _auth.signUp(
                                controllers[0].text, controllers[1].text, controllers[2].text, context);
                            if (result == null) {
                              print('sign up failed');
                            } else {
                              final SharedPreferences prefs = await _prefs;
                              prefs.setStringList("user", [controllers[0].text, controllers[1].text]);
                              print('signed up');
                              print(result);

                              //GlobalData.user = User.fromMap(result["UserInfo"]);
                              print(GlobalData.user);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
                            }
                          }
                        },
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Already have an account ? ", style: TextStyle(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("Login", style: TextStyle(color: Theme.of(context).primaryColor)),
                      ),
                    ]),
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
