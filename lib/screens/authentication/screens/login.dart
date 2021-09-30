import 'package:ecommerceproject/screens/authentication/components/button.dart';
import 'package:ecommerceproject/screens/authentication/components/header.dart';
import 'package:ecommerceproject/screens/authentication/screens/forgotPassword.dart';
import 'package:ecommerceproject/screens/authentication/screens/sign_up.dart';
import 'package:ecommerceproject/screens/dashboard/dashboard.dart';
import 'package:ecommerceproject/services/auth.dart';
import 'package:ecommerceproject/components/loading.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  final FirebaseAnalytics analytics;
  LogIn({Key? key, required this.analytics}) : super(key: key);
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 60),
                        child: Button(
                          onClick: () async {
                            if (_formKey.currentState!.validate()) {
                              loader(context);
                              dynamic result =
                                  await _auth.logIn(emailController.text, passwordController.text, context);
                              if (result == null) {
                                print('login failed');
                              } else {
                                print('logged in');
                                print(result);
                                await widget.analytics.logLogin();

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard(
                                              analytics: widget.analytics,
                                            )));
                              }
                            }
                          },
                          buttonText: "Login",
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text("Don't have an account ? ", style: TextStyle(color: Colors.black)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp(
                                          analytics: widget.analytics,
                                        )));
                          },
                          child: Text("Sign Up", style: TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ])
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
