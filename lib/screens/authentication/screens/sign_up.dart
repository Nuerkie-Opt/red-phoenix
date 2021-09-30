import 'package:ecommerceproject/components/loading.dart';
import 'package:ecommerceproject/screens/authentication/components/button.dart';
import 'package:ecommerceproject/screens/authentication/components/header.dart';
import 'package:ecommerceproject/services/auth.dart';
import 'package:ecommerceproject/screens/dashboard/dashboard.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  SignUp({Key? key, required this.analytics}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  bool obscureConfirmPassword = true;
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) return 'Please enter your name';

                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) return 'Please enter a valid email address';
                            if (!value.contains('@')) return 'Please enter a valid email address';
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter email address',
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          obscureText: obscurePassword,
                          obscuringCharacter: '*',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) return 'Please your password';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter password',
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.vpn_key_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye,
                                    color: obscurePassword ? Color(0xFF484848) : Theme.of(context).primaryColor),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          obscureText: obscurePassword,
                          obscuringCharacter: '*',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) return 'Please confirm your password';
                            if (value != passwordController.text) return 'Passwords do not match';
                            return null;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm your password',
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.vpn_key_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye,
                                    color: obscureConfirmPassword ? Color(0xFF484848) : Theme.of(context).primaryColor),
                                onPressed: () {
                                  setState(() {
                                    obscureConfirmPassword = !obscureConfirmPassword;
                                  });
                                },
                              )),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Button(
                          buttonText: "Sign Up",
                          onClick: () async {
                            if (_formKey.currentState!.validate()) {
                              loader(context);
                              dynamic result = await _auth.signUp(
                                  nameController.text, emailController.text, passwordController.text, context);
                              if (result == null) {
                                print('sign up failed');
                              } else {
                                final SharedPreferences prefs = await _prefs;
                                prefs.setStringList("user", [nameController.text, emailController.text]);
                                await widget.analytics.logSignUp(
                                  signUpMethod: 'user_email_signup',
                                );
                                Navigator.pop(context);
                                print('signed up');

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard(
                                              analytics: widget.analytics,
                                            )));
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
